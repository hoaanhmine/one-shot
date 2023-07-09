followchars = true
testMode = false
dad = {
	x = -227,
	y = 202,
	size = 0,
	resizeCam = false,
	offset = 20
}
gf = {
	x = 1270,
	y = 150,
	allow = true,
	size = 0.9,
	resizeCam = false,
	offset = 15
}
bf = {
	x = 553,
	y = 202,
	resizeCam = false,
	size = 0,
	offset = 20
}
customFocus = false
moveChar = 'bf'

function setNewFocus(char)
	if char == '' then
		customFocus = false
	else
		customFocus = true
		moveChar = char
	end
end

function onUpdatePost()
	if getProperty('cameraSpeed') > 8 then
		followchars = false else followchars = true end
	
	if testMode then
		followchars = false if keyPressed('left') then setProperty('camFollow.x', getProperty('camFollow.x')-10) elseif keyPressed('right') then setProperty('camFollow.x', getProperty('camFollow.x')+10) elseif keyPressed('up') then setProperty('camFollow.y', getProperty('camFollow.y')-10) elseif keyPressed('down') then setProperty('camFollow.y', getProperty('camFollow.y')+10) end debugPrint('x; '..getProperty('camFollow.x')..', ', 'y; '..getProperty('camFollow.y')..', '); setPropertyFromClass('Conductor', 'songPosition', 1); setPropertyFromClass('flixel.FlxG', 'sound.music.time', 1); setProperty('vocals.time', 1); setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0); setProperty('vocals.volume', 0)
	end
	
	if followchars == true then
		if not customFocus then
			if mustHitSection then
				moveChar = 'bf'
			else
				moveChar = 'dad'
			end
		end
			
		if gfSection then
			setNewFocus('gf')
		else
			setNewFocus('')
		end
		
		if moveChar == 'bf' then
			if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
				triggerEvent('Camera Follow Pos', bf.x-bf.offset, bf.y)
			elseif getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
				triggerEvent('Camera Follow Pos', bf.x+bf.offset, bf.y)
			elseif getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
				triggerEvent('Camera Follow Pos', bf.x, bf.y-bf.offset)
			elseif getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
				triggerEvent('Camera Follow Pos', bf.x, bf.y+bf.offset)
			else
				triggerEvent('Camera Follow Pos', bf.x, bf.y)
			end
			if bf.resizeCam then setProperty('defaultCamZoom', bf.size) end
		elseif moveChar == 'dad' then
			if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
				triggerEvent('Camera Follow Pos', dad.x-dad.offset, dad.y)
			elseif getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
				triggerEvent('Camera Follow Pos', dad.x+dad.offset, dad.y)
			elseif getProperty('dad.animation.curAnim.name') == 'singUP' then
				triggerEvent('Camera Follow Pos', dad.x, dad.y-dad.offset)
			elseif getProperty('dad.animation.curAnim.name') == 'singDOWN' then
				triggerEvent('Camera Follow Pos', dad.x, dad.y+dad.offset)
			else
				triggerEvent('Camera Follow Pos', dad.x, dad.y)
			end
			if dad.resizeCam then setProperty('defaultCamZoom', dad.size) end
		elseif moveChar == 'gf' then
			if getProperty('gf.animation.curAnim.name') == 'singLEFT' then
				triggerEvent('Camera Follow Pos', gf.x-gf.offset, gf.y)
			elseif getProperty('gf.animation.curAnim.name') == 'singRIGHT' then
				triggerEvent('Camera Follow Pos', gf.x+gf.offset, gf.y)
			elseif getProperty('gf.animation.curAnim.name') == 'singUP' then
				triggerEvent('Camera Follow Pos', gf.x, gf.y-gf.offset)
			elseif getProperty('gf.animation.curAnim.name') == 'singDOWN' then
				triggerEvent('Camera Follow Pos', gf.x, gf.y+gf.offset)
			end
			if gf.resizeCam then setProperty('defaultCamZoom', gf.size) end
		end
	else
		triggerEvent('Camera Follow Pos', '', '')
	end
end

function onStepHit()
	if curStep == 952 then
		followchars = false
		triggerEvent('Camera Follow Pos', 610, 202)
		doTweenZoom('camGameZ', 'camGame', 1, 3, 'smoothstepinout')
	elseif curStep == 976 then
		followchars = true
		triggerEvent('Camera Follow Pos', '', '')
		doTweenZoom('camGameZ', 'camGame', 0.569999999999997, 1.1, 'smoothstepinout')
	end
end