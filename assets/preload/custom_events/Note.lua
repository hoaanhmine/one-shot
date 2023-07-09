function onEvent(name, value1, value2)
	if name == 'Note' then
	noteTweenAlpha('f'..value1, value1, 1, 0.01)
	noteTweenAlpha('f2'..value1, value1+4, 1, 0.01)
	end
end