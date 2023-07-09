local oUCH = 0
function onCreate()
precacheImage('characters/nega-pico')
end
function onUpdate()
    for i = 0, getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes', i, 'noteType') == 'bullet' then
        setPropertyFromGroup('notes', i, 'texture', 'bala');
        setPropertyFromGroup('notes', i, 'offset.x', 100);
        setPropertyFromGroup('notes', i, 'noteSplashTexture', 'Not');
        end
    end
end

function noteMiss(id, noteData, noteType, isSustainNote)--点了按键运行
	if noteType == 'bullet' then
		health = getProperty('health')
	setProperty('health', health -1);
		end
end
function goodNoteHit(id, noteData, noteType, isSustainNote)
if noteType == 'bullet' then
setProperty('dad.visible', false)
setProperty('boyfriend.visible', false)
oUCH = oUCH + 1

makeAnimatedLuaSprite('DeimosShot1', 'bg/deimos/deimos/deimos-assets-pack',-765,-25)
	addAnimationByPrefix('DeimosShot1', 'shot1','shot 1',24,false)
	objectPlayAnimation('DeimosShot1','shot1',false)
	addLuaSprite('DeimosShot1', true)
	
	makeAnimatedLuaSprite('PICO', 'characters/nega-pico',535,65)
	addAnimationByPrefix('PICO', 'dodge','dodge',24,false)
	objectPlayAnimation('PICO','dodge',false)
	addLuaSprite('PICO', true)
	
	makeAnimatedLuaSprite('bullet' .. oUCH,'bala',getPropertyFromGroup('playerStrums', noteData, 'x')-90, getPropertyFromGroup('playerStrums', 0, 'y')-90)addAnimationByPrefix('bullet' .. oUCH, 'idle','bullet arrow touch',24,false)
	setObjectCamera('bullet' .. oUCH, 'hud')
	addLuaSprite('bullet' .. oUCH,true);
	playSound("deimosShot")
	
	runTimer('bullet' .. oUCH, 0.3333333333)
	runTimer('DeimosShot1', 0.4166666667)
	runTimer('pico', 0.4583333333)
end
end

function onTimerCompleted(tag, loops, loopsleft)
 if string.sub(tag, 1, 6) == "bullet" then
 removeLuaSprite(tag, false)
 end
 if tag == 'DeimosShot1' then
removeLuaSprite('DeimosShot1', false)
setProperty('dad.visible', true)
end
if tag == 'pico' then
removeLuaSprite('PICO', false)
setProperty('boyfriend.visible', true)
end
end