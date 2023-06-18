local function  open_definition_file()
  local params = vim.lsp.util.make_position_params()
  local result = vim.lsp.buf_request_sync(0, 'textDocument/definition', params, 1000)

  if result and result[1] then
    local location = result[1].result[1]

    if location then
      vim.cmd('vsp ' .. vim.fn.fnameescape(location.targetUri))
    else
      print('No definition found.')
    end
  else
    print('No definition found.')
  end
end

return {
  open_definition_file = open_definition_file
}
