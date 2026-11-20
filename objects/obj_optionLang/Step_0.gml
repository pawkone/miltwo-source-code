if stop
{
	lang_change(lang[select])
	instance_destroy()
	exit
}
select = clamp(select+mky_left2+mky_right2,0,array_length(lang)-1)
if selectold != select
{
	selectold = select
	txt = $"- {select+1}/{array_length(inis)} -\n\n- {inis[select][0]} -\n{inis[select][1]}\n\n{inis[select][2]}"
}
if mky_slap2 || mky_jump2
	stop = true