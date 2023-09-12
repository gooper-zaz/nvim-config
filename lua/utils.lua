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

return {
	eslint_config_exists,
}
