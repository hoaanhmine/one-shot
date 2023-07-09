local edn = 0
function onCreate()
precacheImage('characters/nega-gf')
precacheImage('bg/deimos/final')
precacheImage('bg/deimos/soldat appear')
precacheImage('bg/deimos/gunt appear')
precacheImage('bg/deimos/agent appear')
precacheSound("final")
end
function onUpdate()
if edn == 1 then
triggerEvent('Camera Follow Pos', "202", "272")
end
end
function onEvent(n,v1,v2)
if n == "Play Animation" and v1 == "final" and v2 == "gf" then
playSound("final")
edn = 1
end
if n == "Play Animation" and v1 == "final2" and v2 == "gf" then
setProperty('gf.visible', false)
setProperty('boyfriend.visible', false)
makeAnimatedLuaSprite('gfFinal2','characters/nega-gf',-210, -80)
addAnimationByPrefix('gfFinal2', 'final2','gf laugh',24,false)
objectPlayAnimation('gfFinal2','final2',false)
addLuaSprite('gfFinal2',false);

makeAnimatedLuaSprite('PICO', 'characters/nega-pico',535,65)
	addAnimationByPrefix('PICO', 'reaction','pico reaction',24,false)
	objectPlayAnimation('PICO','reaction',false)
	addLuaSprite('PICO', false)

setProperty('agentAppear.visible', true)
setProperty('gruntAppear.visible', true)
setProperty('soldatAppear.visible', true)
setProperty('final.visible', true)

objectPlayAnimation('barricada','appears',false)
objectPlayAnimation('agentAppear','idle',false)
objectPlayAnimation('soldatAppear','idle',false)
objectPlayAnimation('gruntAppear','idle',false)
objectPlayAnimation('final','idle',false)
end
end