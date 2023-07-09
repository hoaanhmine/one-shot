local anim = 1
function onCreate()
precacheImage('bg/deimos/deimos/deimos-assets-pack')
precacheImage('bg/deimos/barricada_hank')
precacheImage('bg/deimos/barricada')
end
function onEvent(name, value1, value2)
	if name == 'Shot Deimos' then
	if value1 == "0" then
	    objectPlayAnimation('barricada','appears',false)
	    runTimer('barricadaAppears', 1.375)
	end
	if value1 == "1" then
	setProperty('dad.visible', false)	
	makeAnimatedLuaSprite('DeimosMiss', 'bg/deimos/deimos/deimos-assets-pack',-765,-25)
	addAnimationByPrefix('DeimosMiss', '1','left miss',24,false)
	addAnimationByPrefix('DeimosMiss', '2','right miss',24,false)
	addLuaSprite('DeimosMiss', true)
	objectPlayAnimation('DeimosMiss',tostring(getRandomInt(1, 2)),false)
	triggerEvent('Play Animation', 'shoot', 'gf')
	objectPlayAnimation('barricada','shot',true)
	playSound("shoot")
	
	end
	if value1 == "2" then
	makeAnimatedLuaSprite('DeimosMiss', 'bg/deimos/deimos/deimos-assets-pack',-765,-25)
	addAnimationByPrefix('DeimosMiss', 'shot1','shot 2',24,false)
	objectPlayAnimation('DeimosMiss','shot1',false)
	addLuaSprite('DeimosMiss', true)
	
	objectPlayAnimation('barricada','shot',false)
	playSound("shoot")	
	objectPlayAnimation('barricada','death',false)
	playSound("deimosShot2")
	playSound("die")
	
	runTimer('DeimosShot1', 0.625)
	end
	if value1 == "3" then
	setProperty('dad.visible', false)
	makeAnimatedLuaSprite('DeimosMiss', 'bg/deimos/deimos/deimos-assets-pack',-765,-25)
	addAnimationByPrefix('DeimosMiss', 'shot1','deimos parry',24,false)
	objectPlayAnimation('DeimosMiss','shot1',false)
	addLuaSprite('DeimosMiss', true)
	playSound("parry")
		runTimer('eee', 0.3)
	runTimer('DeimosShot1', 0.5)
	end
	if value1 == "4" then
	setProperty('barricada.visible', false)
	setProperty('barricada_hank.visible', true)
	objectPlayAnimation('barricada_hank','intro',false)
	runTimer('barricada_hank', 3.125)
	end
	end
end
function onTimerCompleted(tag, loops, loopsleft)
if tag == 'barricadaAppears' then
objectPlayAnimation('barricada','idle',false)
end
if tag == 'DeimosShot1' then
removeLuaSprite('DeimosMiss', false)
setProperty('dad.visible', true)
end
if tag == 'barricada_hank' then
objectPlayAnimation('barricada_hank','chao',false)
runTimer('barricada_hank2', 1.541666667)
end
if tag == 'barricada_hank2' then
setProperty('barricada.visible', true)
setProperty('barricada_hank.visible', false)
end
if tag == 'eee' then
objectPlayAnimation('barricada','death',false)
playSound("die")
end
end