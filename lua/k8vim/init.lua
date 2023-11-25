local win, buf

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

create_win()
--get_namespaces()
redraw(cluster)
