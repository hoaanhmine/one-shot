function onCreate()
precacheImage('bg/deimos/deimos/deimos-assets-pack')
end
function onEvent(name, value1, value2)
	if name == 'Deimos Anim' then
	setProperty('dad.visible', false)
	makeAnimatedLuaSprite('DeimosAnim', 'bg/deimos/deimos/deimos-assets-pack',-765,-25)
	addAnimationByPrefix('DeimosAnim', 'Anim',value1,24,false)
	objectPlayAnimation('DeimosAnim','Anim',false)
	addLuaSprite('DeimosAnim', true)
	
	runTimer('DeimosAnim', value2/24)
	end
end
function onTimerCompleted(tag, loops, loopsleft)
if tag == 'DeimosAnim' then
removeLuaSprite('DeimosAnim', false)
setProperty('dad.visible', true)
end
end