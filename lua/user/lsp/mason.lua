local status_ok, _ = pcall(require, "mason")
if not status_ok then
  return
end

status_ok, _ = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

require("mason").setup(require("user.lsp.settings.mason_config").settings)
require("mason-lspconfig").setup(require("user.lsp.settings.mason_lspconfig").settings)

-- Register a handler that will be called for all installed servers.
local opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup(opts)
  end,
  -- Next, you can provide targeted overrides for specific servers.
  -- ["rust_analyzer"] = function ()
  --     require("rust-tools").setup {}
  -- end,
  ["sumneko_lua"] = function ()
    local sumneko_opts = require("user.lsp.settings.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    require("lspconfig").sumneko_lua.setup(opts)
  end,
  ["clangd"] = function ()
    local clangd_opts = require("user.lsp.settings.clangd")
	 	opts = vim.tbl_deep_extend("force", clangd_opts, opts)
    require("lspconfig").clangd.setup(opts)
  end,
})

