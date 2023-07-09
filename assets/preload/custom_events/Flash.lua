function onEvent(name, value1, value2)
	if name == 'Flash' then
		makeLuaSprite('flash','empty',-100,-100)
		makeGraphic('flash',1480,920,value2)
		setObjectCamera('flash','camHUD')
		setProperty('flash.alpha',0.5)
		addLuaSprite('flash',false)
		doTweenAlpha('flash','flash',0,value1,'quadInOut')
    end
end