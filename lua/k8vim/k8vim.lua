local win, buf
local modifiable = true

local cluster = { "Namespaces", "Cluster Members", "Events" }
local workload = { "CronJobs", "Daemonsets", "Deployments", "Jobs", "StatefulSets", "Pods" }
local service_discovery = { "Ingresses", "Network Policies", "Services" }
local resources = { Cluster = cluster, workload, service_discovery }

local function create_win()
	local start_win = vim.api.nvim_get_current_win()
	vim.api.nvim_command(":45 vnew")
	win = vim.api.nvim_get_current_win()
	buf = vim.api.nvim_get_current_buf()

	vim.api.nvim_buf_set_name(buf, "window name")
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buf, "filetype", "nvim-oldfile")
	vim.api.nvim_win_set_option(win, "wrap", false)
	vim.api.nvim_win_set_option(win, "cursorline", true)
end

local function redraw(list)
	vim.api.nvim_buf_set_option(buf, "modifiable", true)
	--local list = vim.fn.systemlist("kubectl get ns")
	--local list = vim.fn.systemlist("ls")
	local title = { "----Title----" }
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, title)
	vim.api.nvim_buf_set_lines(buf, 2, -1, false, list)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
end

local function get_namespaces()
	local namespaces = vim.fn.systemlist("kubectl get ns")
	return namespaces
end

local function close_window()
	vim.api.nvim_win_close(win, true)
end

local function get_option()
	local str = vim.api.nvim_get_current_line()
	print(str)
end

local function set_mappings()
	vim.api.nvim_buf_set_keymap(
		buf,
		"n",
		"<cr>",
		':lua require"k8vim".' .. "get_option()" .. "<cr>",
		{ nowait = true, noremap = true, silent = true }
	)

	vim.api.nvim_buf_set_keymap(
		buf,
		"n",
		"q",
		':lua require"k8vim".' .. "close_window()" .. "<cr>",
		{ nowait = true, noremap = true, silent = true }
	)

	vim.api.nvim_buf_set_keymap(
		buf,
		"n",
		"m",
		':lua require"k8vim".' .. "toggle_modifiable()" .. "<cr>",
		{ nowait = true, noremap = true, silent = true }
	)
end

local function toggle_modifiable()
	modifiable = not modifiable
	vim.api.nvim_buf_set_option(buf, "modifiable", modifiable)
	print(modifiable)
end

local function k8vim()
	create_win()
	--get_namespaces()
	set_mappings()
	redraw(cluster)
end

return {
	k8vim = k8vim,
	close_window = close_window,
	get_option = get_option,
	toggle_modifiable = toggle_modifiable,
}
