return
{
    'itchyny/lightline.vim',
    config = function()
            function _G.lightline_filepath()
                local path = vim.fn.expand('%')
                if path == '' then
                    return '[No File]'
                else
                    return path
                end
            end

            vim.g.lightline = {
                colorscheme = 'wombat',
                component_function = {
                    filepath = 'v:lua.lightline_filepath',
                },
                active = {
                    left = { { 'mode', 'paste' }, { 'readonly', 'filepath', 'modified' } },
                    right = { { 'lineinfo' }, { 'percent' }}
                },
            }
    end
}
