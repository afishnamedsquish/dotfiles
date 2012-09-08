XPTemplate priority=personal

XPTinclude
	\ _common/personal
	\ _common/inlineComplete
	\ _common/common.*

XPT pd
echo '<pre>'; var_dump(`a^); echo '</pre>';`cursor^

XPT pp
echo '<pre>'; print_r(`a^); echo '</pre>';`cursor^


" this snippet has a nested snippet, via `:SNIPNAME:^
XPT pdd " this appears in the pop up menu
`:pd:^ die();
`cursor^

" this will repeat the value of the two placeholder throughout
XPT delta
one `two^ `two^
	`two^ `two^
	`two^ `two^ `two^
	`two^ `two^ `two^ `two^

" this snippet has a left edge which will be deleted if the placeholder is skipped
XPT epsilon
<
thread` `four^ five` `six^ ######
>

" head with optional title using left and right edges
XPT head
<head>`
	<title>`title`</title>^
</head>

XPT theta
nine `expand me...{{^`:epsilon:^` `expand me...^`}}^

XPT arr
`expand me...{{^`myvar`, ^` `expand me...^`}}^
