" in plugin/k8vim.vim

if exists('g:loaded_k8vim')
  finish
endif "prevent loading file twice


"command to run our plugin"
command! K8vim lua require'k8vim'.k8vim()


let g:loaded_k8vim = 1
