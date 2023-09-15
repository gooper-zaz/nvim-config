local consts = require("contants")
-- 检测项目下是否存在eslint配置文件
function eslint_config_exists()
	local eslintrc = vim.fn.glob(".eslintrc*", false, true)

	if not vim.tbl_isempty(eslintrc) then
		return true
	end

	if vim.fn.filereadable("package.json") then
		if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
			return true
		end
	end

	return false
end

local function get_typescript_server_path(root_dir)
	local util = require("lspconfig.util")

	local global_ts = consts.global_ts_server
	-- Alternative location if installed as root:
	-- local global_ts = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
	local found_ts = ""
	local function check_dir(path)
		found_ts = util.path.join(path, "node_modules", "typescript", "lib", "tsserverlibrary.js")
		if util.path.exists(found_ts) then
			return path
		end
	end
	if util.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return global_ts
	end
end

return {
	eslint_config_exists,
	get_typescript_server_path,
}
