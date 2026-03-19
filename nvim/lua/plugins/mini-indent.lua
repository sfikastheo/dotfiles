return {
    'nvim-mini/mini.indentscope',
    version = '*',
	config = function(_)
        require('mini.indentscope').setup()
	end
}
