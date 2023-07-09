local oUCH = 0
function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if not isSustainNote then
		oUCH = oUCH + 1
	
	makeAnimatedLuaSprite('deimosSplash' .. oUCH,'skins/deimos/deimosSplash',getPropertyFromGroup('opponentStrums', noteData, 'x')-100, getPropertyFromGroup('opponentStrums', 0, 'y')-90)
	addAnimationByPrefix('deimosSplash' .. oUCH, 'idle','deimoss splash',24,false)
	setObjectCamera('deimosSplash' .. oUCH, 'hud')
	objectPlayAnimation('deimosSplash','idle',false)
	addLuaSprite('deimosSplash' .. oUCH,true);
	
	runTimer('deimosSplash' .. oUCH, 0.375)
	end
end
function onTimerCompleted(tag, loops, loopsleft)
 if string.sub(tag, 1, 12) == "deimosSplash" then
 removeLuaSprite(tag, true)
 end
end