-- Enhanced lua/jdtls_setup.lua with additional fixes
local M = {}

-- Store the current client ID when started
local jdtls_client_id = nil

M.setup = function()
  local jdtls_settings = {
    java = {
      home = '/Users/mihailiurco/.sdkman/candidates/java/current',
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
        }
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      -- Completely fixing the formatter settings
      format = {
        enabled = true,
        -- Remove problematic formatter settings completely since they're causing errors
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      enabled = true,
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      importOrder = {
        "java",
        "javax",
        "com",
        "org"
      },
    },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  }
  
  -- Add extended capabilities to handle the _java.reloadBundles.command issue
  local extendedClientCapabilities = {}
  if jdtls_settings.extendedClientCapabilities then
    extendedClientCapabilities = jdtls_settings.extendedClientCapabilities
  end
  
  -- Adding support for reload bundles command
  extendedClientCapabilities.commands = {
    supportedCommands = {
      "_java.reloadBundles.command"
    }
  }
  jdtls_settings.extendedClientCapabilities = extendedClientCapabilities
  
  require('jdtls').jol_path = os.getenv("HOME") .. '/java_tools/jol-cli-0.17-full.jar'
  local client_capabilities_config = require('blink.cmp').get_lsp_capabilities()
  
  -- Define the root directory dynamically
  local root_dir = vim.fs.dirname(vim.fs.find(
    { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
    { upward = true })[1])
  if not root_dir then
    vim.notify("No valid Java root directory found!", vim.log.levels.ERROR)
    return
  end
  
  -- Fix the bundle loading issue
  local bundles = {}
  
  -- More careful approach to loading bundles
  local java_debug_path = require("mason-registry").get_package("java-debug-adapter"):get_install_path()
  local debug_bundle = vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar")
  if debug_bundle ~= "" then
    table.insert(bundles, debug_bundle)
  end
  
  -- Only add test bundles if they actually exist and are valid
  local function add_bundles_from_path(path_pattern)
    local bundle_files = vim.split(vim.fn.glob(path_pattern), "\n")
    for _, file in ipairs(bundle_files) do
      if file ~= "" and not file:match("jacocoagent.jar$") and not file:match("runner%-jar%-with%-dependencies.jar$") then
        -- Skip the problematic JAR files mentioned in the error logs
        table.insert(bundles, file)
      end
    end
  end
  
  local java_test_path = require("mason-registry").get_package("java-test"):get_install_path()
  add_bundles_from_path(java_test_path .. "/extension/server/*.jar")
  
  -- Ensure lombok path exists
  local lombok_path = vim.fn.stdpath("data") .. "/lombok/lombok.jar"
  
  -- Download lombok if not exists
  if (vim.fn.filereadable(lombok_path) == 0) then
    vim.fn.mkdir(vim.fn.stdpath("data") .. "/lombok", "p")
    vim.fn.system({
      "curl",
      "-fLo",
      vim.fn.stdpath("data") .. "/lombok/lombok.jar",
      "--create-dirs",
      "https://projectlombok.org/downloads/lombok.jar"
    })
  end
  
  local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()
  local config = {
    cmd = {
      jdtls_path .. "/bin/jdtls",
      "-data", vim.fn.stdpath("data") .. "/jdtls_workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t"), -- Workspace per project
      "--jvm-arg=-javaagent:" .. lombok_path,
    },
    root_dir = root_dir,
    on_attach = function(client, bufnr)
      -- Store the client ID for later use when stopping
      jdtls_client_id = client.id
      
      print('Attaching to the java buffer, relevant keymaps will be set')
      local jdtls_keys = require('keymaps').jdtls_keys()
      require('util-module').set_keymaps(bufnr, jdtls_keys)
    end,
    settings = jdtls_settings,
    capabilities = client_capabilities_config,
    init_options = {
      bundles = bundles, -- Add debug/test bundles if needed
      -- Adding command handler support
      commands = {
        "_java.reloadBundles.command"
      }
    },
    -- Add handlers for commands that aren't supported by default
    handlers = {
      ["_java.reloadBundles.command"] = function()
        -- Empty handler just to prevent the error
        return {}
      end
    }
  }
  
  require('jdtls').start_or_attach(config)
  
  -- Print some debug info
  vim.notify("JDTLS started with " .. #bundles .. " bundles", vim.log.levels.INFO)
end

-- Function to stop the jdtls server
M.stop = function()
  if jdtls_client_id then
    -- Check if the client is still active
    local clients = vim.lsp.get_active_clients()
    local is_active = false
    local jdtls_client = nil
    
    for _, client in ipairs(clients) do
      if client.id == jdtls_client_id then
        is_active = true
        jdtls_client = client
        break
      end
    end
    
    if is_active and jdtls_client then
      -- Only stop the specific jdtls client by ID
      vim.lsp.stop_client(jdtls_client_id, true)
      
      -- Additionally, kill the Java process for jdtls using a more targeted approach
      if jdtls_client.config and jdtls_client.config.cmd then
        local pid_cmd = string.format("pgrep -f '%s'", jdtls_client.config.cmd[1])
        local pid = vim.fn.trim(vim.fn.system(pid_cmd))
        
        if pid ~= "" then
          vim.fn.system(string.format("kill %s", pid))
        end
      else
        -- Fallback to a more specific pkill that targets only jdtls
        vim.fn.system('pkill -f "jdtls\\.sh\\|jdtls/bin"')
      end
      
      vim.notify("Java Language Server stopped", vim.log.levels.INFO)
    else
      vim.notify("Java Language Server is not running", vim.log.levels.WARN)
    end
    
    -- Reset the client ID
    jdtls_client_id = nil
  else
    vim.notify("No Java Language Server was started by this session", vim.log.levels.WARN)
  end
end

-- Function to check if jdtls is running
M.is_running = function()
  if jdtls_client_id then
    local clients = vim.lsp.get_active_clients()
    for _, client in ipairs(clients) do
      if client.id == jdtls_client_id then
        return true
      end
    end
  end
  return false
end

return M
