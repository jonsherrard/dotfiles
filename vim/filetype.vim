if exists("did\_load\_filetypes")
	finish
endif
augroup markdown
	au! BufRead,BufNewFile *.md   setfiletype md
augroup END
