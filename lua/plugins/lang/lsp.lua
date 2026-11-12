-- LSP servers are declared per language in lang/*.lua via `opts.servers`
-- (merged by lazy.nvim) and enabled here with the native vim.lsp.config API.
--
-- Extra keys understood here (stripped before vim.lsp.config):
--   servers.<name>.ensure_installed = false  -- never install with Mason
--   extra.<mason-package> = { bin = "<executable>", ensure_installed = bool }
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      -- only used by mason-tool-installer to map lspconfig names to Mason packages
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      -- blink.cmp registers its completion capabilities for every server
      -- (vim.lsp.config("*")) when it loads, so it must load before servers start.
      "saghen/blink.cmp",
    },
    event = { "BufReadPre", "BufNewFile" },
    -- nvim-lspconfig skips its :Lsp* commands on Nvim 0.12+ (the built-in :lsp
    -- replaces them), so define the familiar names as aliases at startup.
    init = function()
      local function alias(name, sub, desc)
        vim.api.nvim_create_user_command(name, function(o)
          vim.cmd("lsp " .. sub .. (o.args ~= "" and " " .. o.args or ""))
        end, {
          nargs = "*",
          desc = desc,
          complete = function(arg)
            return vim.fn.getcompletion("lsp " .. sub .. " " .. arg, "cmdline")
          end,
        })
      end
      alias("LspStart", "enable", "Enable LSP configs (:lsp enable)")
      alias("LspStop", "stop", "Stop LSP clients (:lsp stop)")
      alias("LspRestart", "restart", "Restart LSP clients (:lsp restart)")
      vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", { desc = "LSP status (:checkhealth vim.lsp)" })
      vim.api.nvim_create_user_command("LspLog", function()
        vim.cmd.tabnew(vim.lsp.log.get_filename())
      end, { desc = "Open the LSP log" })
    end,
    opts = {
      servers = {
        vimls = {},
        bashls = {
          filetypes = { "sh", "bash" },
        },
      },
      extra = {
        cmakelang = { bin = "cmake-format" },
        dprint = {},
        jupytext = {},
        shfmt = {},
      },
    },
    config = function(_, opts)
      require("mason").setup()

      local servers = opts.servers or {}

      -- Let Mason install only what is missing from PATH, so it never shadows
      -- tools installed system-wide (Mason prepends its bin dir to PATH).
      local missing = {}
      local function need(pkg, bin)
        if type(bin) == "string" and vim.fn.executable(bin) == 0 then
          missing[#missing + 1] = pkg
        end
      end

      for name, settings in pairs(servers) do
        local install = settings.ensure_installed ~= false
        settings.ensure_installed = nil -- not an LSP field
        if install then
          local cmd = settings.cmd or (vim.lsp.config[name] or {}).cmd
          need(name, type(cmd) == "table" and cmd[1] or nil)
        end
        vim.lsp.config(name, settings)
      end
      for pkg, tool in pairs(opts.extra or {}) do
        if tool.ensure_installed ~= false then
          need(pkg, tool.bin or pkg)
        end
      end

      require("mason-tool-installer").setup({ ensure_installed = missing })
      vim.lsp.enable(vim.tbl_keys(servers))
    end,
  },
}
