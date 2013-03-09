" Text Manipulation
function! HtmlEscape()
	silent s/&/\&amp;/eg
	silent s/</\&lt;/eg
	silent s/>/\&gt;/eg
	silent s/“/\&ldquo;/eg
	silent s/”/\&rdquo;/eg
	silent s/™/\&trade;/eg
	silent s/®/\&reg;/eg
	silent s/©/\&copy;/eg
	silent s/‘/\&lsquo;/eg
	silent s/’/\&rsquo;/eg
	silent s/–/\&ndash;/eg
	silent s/—/\&mdash;/eg
endfunction

function! HtmlUnEscape()
	silent s/&amp;/\&/eg
	silent s/&lt;/</eg
	silent s/&gt;/>/eg
	silent s/&ldquo;/“/eg
	silent s/&rdquo;/”/eg
	silent s/&trade;/™/eg
	silent s/&reg;/®/eg
	silent s/&copy;/©/eg
	silent s/&lsquo;/‘/eg
	silent s/&rsquo;/’/eg
	silent s/&ndash;/–/eg
	silent s/&mdash;/—/eg
endfunction

nnoremap <silent> <Leader>h :call HtmlEscape()<CR>
nnoremap <silent> <Leader>H :call HtmlUnEscape()<CR>
vnoremap <silent> <Leader>h :call HtmlEscape()<CR>
vnoremap <silent> <Leader>H :call HtmlUnEscape()<CR>
