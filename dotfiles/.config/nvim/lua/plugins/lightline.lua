return {
    'itchyny/lightline.vim',
    config = function()
        -- Custom path shortening helper
        function _G.lightline_filepath()
            local path = vim.fn.expand('%:p')
            if path == '' then
                return '[No File]'
            end

            local max_len = 50
            local len = string.len(path)

            if len <= max_len then
                return path
            else
                return '…' .. string.sub(path, len - max_len + 1)
            end
        end

        vim.g.lightline = {
            colorscheme = 'wombat',
            component_function = {
                filepath = 'v:lua.lightline_filepath',
            },
            active = {
                left = { { 'mode', 'paste' }, { 'readonly', 'filepath', 'modified' } },
                right = { { 'lineinfo' }, { 'percent' } },
            },
        }
    end
}

