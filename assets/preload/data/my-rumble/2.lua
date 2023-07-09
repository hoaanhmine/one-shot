function onBeatHit()
	if curBeat >= 16.0 and curBeat <= 72.0 then
		triggerEvent('Add Camera Zoom','0.1','0.08')
	end
	if curBeat >= 80.0 and curBeat <= 93.0 and curBeat % 4 == 0 then
triggerEvent('Add Camera Zoom','0.1','0.08')
	end
	if curBeat >= 94.0 and curBeat < 111.0 then
triggerEvent('Add Camera Zoom','0.1','0.08')
	end
	if curBeat >= 112.0 and curBeat <= 167.0 then
		if curBeat % 2 == 0 then
	triggerEvent('Add Camera Zoom','0.1','0.08')
		end
	end
	if curBeat >= 176.0 and curBeat <= 203.0 then
		triggerEvent('Add Camera Zoom','0.1','0.08')
	end
	if curBeat >= 208.0 and curBeat <= 263.0 then
		triggerEvent('Add Camera Zoom','0.1','0.08')
	end
	if curBeat >= 272.0 and curBeat <= 327.0 then
		if curBeat % 2 == 0 then
	triggerEvent('Add Camera Zoom','0.1','0.08')
		end
	end
	if curBeat >= 416.0 and curBeat <= 520.0 then
		if curBeat % 2 == 0 then
	triggerEvent('Add Camera Zoom','0.1','0.08')
		end
	end
	if curBeat > 528.0 and curBeat < 560.0 then
triggerEvent('Add Camera Zoom','0.1','0.08')
	end
end

function onStepHit()
	if curStep == 704 then
		cameraFlash('camGame', '000000', 2.5, false)
	end
	if curStep == 720 then
		setProperty('intro.alpha', 1)
		playAnim('intro', 'in')
	end
	if curStep == 64 then
		setProperty('camZooming',true)
	end
	if curStep == 1344 then
		cameraFlash('camGame', '000000', 5, false)
	end
	if curStep == 1472 then
		doTweenZoom('camGame', 'camGame', 0.95, 10)
	end
	if curStep == 1600 then
		makeLuaSprite('whiteBG', nil, 21, -796)
		makeGraphic('whiteBG', 2876, 1811, 'FFFFFF')
		setObjectOrder('whiteBG', getObjectOrder('dadGroup')-1)
		addLuaSprite('whiteBG', false)
		setProperty('dad.color', getColorFromHex('000000'))
		setProperty('boyfriend.color', getColorFromHex('000000'))
		setProperty('gf.alpha', 0)
		setProperty('ilumination.visible', false)
		setProperty('filter.visible', false)
		setProperty('light.visible', false)
	end
	if curStep == 1664 then
		removeLuaSprite('whiteBG', false)
		setProperty('dad.color', getColorFromHex('FFFFFF'))
		setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
		setProperty('gf.alpha', 1)
		setProperty('ilumination.visible', true)
		setProperty('filter.visible', true)
		setProperty('light.visible', true)
	end
	if curStep == 2240 then
		cameraFlash('camOther', '000000', 2000, false)
	end
end

local introAnimPart = 1

function onUpdate()
	if curStep > 721 then
		if getProperty('intro.animation.curAnim.name') == 'in' and getProperty('intro.animation.curAnim.finished') and introAnimPart == 1 then
			removeLuaSprite('intro', false)
			setProperty('landing.alpha', 1)
			playAnim('landing', 'land')
			introAnimPart = 2
		end
		
		if getProperty('landing.animation.curAnim.name') == 'land' and getProperty('landing.animation.curAnim.finished') and introAnimPart == 2 then
			removeLuaSprite('landing', false)
			setProperty('gf.visible', true)
			triggerEvent('Change Character', 'gf', 'darnell')
		end
	end
end