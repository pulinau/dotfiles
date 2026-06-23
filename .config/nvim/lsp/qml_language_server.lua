---@brief
---
--- https://github.com/cushycush/qml-language-server
---
--- > A Go-based Language Server for QML (Qt Meta-Object Language) that provides intelligent code
--- editing features.

---@type vim.lsp.Config
return {
    cmd = { "qml-language-server" },
    filetypes = { "qml" },
    root_markers = { { "qmldir", "shell.qml" }, ".git" },
}
