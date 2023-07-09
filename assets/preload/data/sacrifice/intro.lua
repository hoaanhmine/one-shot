local djdjdj = false
function onCreate()
setProperty('camHUD.visible', false)
setProperty('camGame.visible', false)
setProperty('grunt.visible', false)
makeLuaSprite('move',nil,0, -2293); addLuaSprite('move',false); setProperty('move.visible', false)

makeAnimatedLuaSprite('title', 'bg/deimos/title',300,0)
scaleObject("title", 0.5, 0.5)
screenCenter('title', 'Y')
setObjectCamera('title', 'other')
addAnimationByPrefix('title', 'idle','intro',24,false)
addLuaSprite('title', false)

setProperty('skipCountdown', true)
end
function onStepHit()
if curStep == 1 then
objectPlayAnimation('title','idle',false)

playSound("title")
runTimer('start', 6.625)
end
if curStep == 125 then
setProperty('grunt.visible', true)
objectPlayAnimation('grunt','idle',false)
end
if curStep == 175 then
objectPlayAnimation('grunt','morido',false)
setObjectOrder('grunt', getObjectOrder('grunt')+1)
doTweenY('grunt', 'grunt', 300, 5, "linear")
end
end
function onTimerCompleted(tag, loops, loopsleft)
if tag == 'start' then
doTweenY('tag2', 'move', 0, 10, "smoothstepinout")
setProperty('camHUD.visible', true)
setProperty('camGame.visible', true)
removeLuaSprite('title', true)


end
end
function onTweenCompleted(name)
if name == 'tag2' then
removeLuaSprite('move', true)
djdjdj = true
triggerEvent('Camera Follow Pos', '', '')
end
end
function onUpdate()
if djdjdj == false then
triggerEvent('Camera Follow Pos', getProperty('move.x'), getProperty('move.y')  )
--debugPrint("ue")
end
end