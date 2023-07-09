AnimStartStep = 916

function onCreatePost()
	makeAnimatedLuaSprite('deimosShot', 'bg/deimos/deimos/deimos-assets-pack', -765, -25)
	addAnimationByPrefix('deimosShot', 'shot1', 'shot 1', 24, false)
	addLuaSprite('deimosShot', true)
	
	makeAnimatedLuaSprite('bfTrans', 'characters/nega-bf', 505, -25)
	addAnimationByPrefix('bfTrans', 'shot1', 'bf trans', 24, false)
	addLuaSprite('bfTrans', true)
	
	makeAnimatedLuaSprite('chains', 'bg/deimos/chains', -1735, -1835)
	addAnimationByPrefix('chains', 'in', 'chains', 24, false)
	addLuaSprite('chains', true)

	makeAnimatedLuaSprite('gfText', 'hud/deimos/gfText', 70, 445)
	addAnimationByPrefix('gfText', 'shot1', 'GF TEXT', 24, false)
	setObjectCamera('gfText', 'other')
	scaleObject("gfText", 0.666288308740068, 0.666288308740068)
	addLuaSprite('gfText', true)

	makeAnimatedLuaSprite('polvo', 'bg/deimos/polvo', -421, 123)
	addAnimationByPrefix('polvo', 'idle', 'polvo', 24, false)
	addLuaSprite('polvo', true)
	
	makeAnimatedLuaSprite('piedra', 'bg/deimos/piedra', 61, -1151)
	addAnimationByPrefix('piedra', 'out', 'pilar out', 24, false)
	addAnimationByPrefix('piedra', 'in', 'pilar in', 24, false)
	addLuaSprite('piedra', true)
	
	makeAnimatedLuaSprite('mira', 'bg/deimos/mira', 205, -275)
	addAnimationByPrefix('mira', 'shot', 'alert shoot', 24, false)
	addLuaSprite('mira', true)

	setProperty('polvo.alpha', 0.00001)
	setProperty('deimosShot.alpha', 0.00001)
	setProperty('gfText.alpha', 0.00001)
	setProperty('piedra.alpha', 0.00001)
	setProperty('bfTrans.alpha', 0.00001)
	setProperty('mira.alpha', 0.00001)
	setProperty('chains.alpha', 0.00001)
end

function onStepHit()
	if curStep == AnimStartStep then
		setProperty('mira.alpha', 1)
		playSound('mira', 1, 'mira')
		soundFadeIn('mira', 0.7, 0, 1)
		playAnim('mira', 'shot')
	elseif curStep == AnimStartStep + 28 then
		setProperty('dad.visible', false)
		setProperty('boyfriend.visible', false)
		
		setProperty('deimosShot.alpha', 1)
		playAnim('deimosShot', 'shot1')
		playSound("deimosShot")
		
		setProperty('bfTrans.alpha', 1)
		playAnim('bfTrans', 'shot1')
		
		triggerEvent('Play Animation', 'shoot', 'gf')
	elseif curStep == AnimStartStep + 32 then
		setProperty('chains.alpha', 1)
		playAnim('chains', 'in')
	elseif curStep == AnimStartStep + 36 then
		setProperty('piedra.alpha', 1)
		playAnim('piedra', 'in')
	elseif curStep == AnimStartStep + 60 then
		playAnim('piedra', 'out')
	end
end

function onUpdatePost()
	if curStep >= AnimStartStep and curStep < AnimStartStep + 70 then
		if getProperty('deimosShot.animation.curAnim.finished') and getProperty('deimosShot.alpha') == 1 then
			removeLuaSprite('deimosShot', true)
			setProperty('dad.visible', true)
		end
		if getProperty('chains.animation.curAnim.finished') and getProperty('chains.alpha') == 1 then
			removeLuaSprite('chains', true)
		end
		if getProperty('chains.animation.curAnim.name') == 'out' and getProperty('chains.animation.curAnim.finished') and getProperty('chains.alpha') == 1 then
			removeLuaSprite('chains', true)
		end
		if getProperty('gf.animation.curAnim.name') == 'shoot' then
			if getProperty('gf.animation.curAnim.finished') then
				triggerEvent('Play Animation', 'angry', 'gf')
				triggerEvent('Alt Idle Animation', 'gf', '-alt')
				
				setProperty('gfText.alpha', 1)
				playAnim('gfText', 'shot1')
				playSound('gfangry', 2)
			end
		end
		if getProperty('gfText.animation.curAnim.finished') and getProperty('gfText.alpha') == 1 then
			removeLuaSprite('gfText', true)
		end
		if getProperty('bfTrans.animation.curAnim.finished') and getProperty('bfTrans.alpha') == 1 then
			removeLuaSprite('bfTrans', true)
			--setProperty('boyfriend.visible', true)
		end
	end
end

function onEvent(n, one, two)
	if n == 'Change Character' then
		if two == 'nega-pico-player' then
			triggerEvent('Play Animation', 'hey', 'bf')
		end
	end
end