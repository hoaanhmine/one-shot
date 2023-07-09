local path = 'hud/deimos/'
local startAmimStep = 304
local curHealth = 6
local addHealth_ = 0

function onCreate()
	runHaxeCode([[
		FlxG.cameras.remove(game.camHUD,false);
		FlxG.cameras.remove(game.camOther,false);
		
		var camHUD2:FlxCamera =new FlxCamera(0, 0, FlxG.width, FlxG.height);
		camHUD2.bgColor=0x00;
		setVar("camHUD2",camHUD2);
		
		FlxG.cameras.add(camHUD2,false);
		FlxG.cameras.add(game.camHUD,false);
		FlxG.cameras.add(game.camOther,false);
	]])
	setProperty('skipCountdown', true)
end

function onCreatePost()
	for i = 0, getProperty('playerStrums.length')-1 do
		setPropertyFromGroup('playerStrums', i, 'texture', "deimosBF");
	end
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
			setPropertyFromGroup('unspawnNotes', i, 'texture', "deimosBF");
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', "skins/deimos/bf/bfSplash");
		end
	end
	for i = 0, getProperty('opponentStrums.length')-1 do
		setPropertyFromGroup('opponentStrums', i, 'texture', "deimos");
	end
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then
			setPropertyFromGroup('unspawnNotes', i, 'texture', "deimos");
		end
	end
	if not downscroll then
		makeLuaSprite('barTop', path..'barTop', -67, 865)
		makeLuaSprite('barDown', path..'barDown', -47, -455)
		makeAnimatedLuaSprite('bar', path..'bar', 880, 755)
		setProperty('barTop.flipY', true)
		setProperty('barDown.flipY', true)
	else
		makeLuaSprite('barTop', path..'barTop', -45.5, -455)
		makeLuaSprite('barDown', path..'barDown', -47, 800)
		makeAnimatedLuaSprite('bar', path..'bar-down', 875, -270)
	end
	
	addLuaSprite('barDown', false)
	scaleObject('barDown', 0.6665, 0.6665)
	
	addLuaSprite('barTop', false)
	scaleObject('barTop', 0.6665, 0.6665)
	
	addLuaSprite('bar', false)
	scaleObject('bar', 0.5, 0.5)
	
	for i = 0, 6 do addAnimationByPrefix('bar', 'health_'..i, i..'0', 24, true); end
	addAnimationByPrefix('bar', 'load', 'load', 24, false);
	addAnimationByPrefix('bar', 'die', 'die', 24, false);
	playAnim('bar', 'health_0')
	
	makeLuaText('scoreText', '', 150, 0, (downscroll and -235 or 920))
	addLuaText('scoreText')
	setTextSize('scoreText', 40)
	setTextFont('scoreText', 'impact.ttf')
	setTextAlignment('scoreText', 'center');
	setTextColor('scoreText', 'FF0055')
	screenCenter('scoreText', 'X')
	
	makeLuaSprite('scoreValue');
	addLuaSprite('scoreValue');
	setProperty('scoreValue.alpha', 0)
	
	setProperty('iconP1.visible', false)
	setProperty('iconP2.visible', false)
	setProperty('healthBar.visible', false)
	setProperty('healthBarBG.visible', false)
	setProperty('timeTxt.visible', false)
	setProperty('timeBar.visible', false)
	setProperty('timeBarBG.visible', false)
	setProperty('scoreTxt.visible', false)
	setProperty('camHUD.alpha', 1)
	for i = 0,7 do
	noteTweenAlpha(i, i, 0, 0.1,"linear")
	end
	setProperty('showRating', false)
	setProperty('showComboNum', false)

	runHaxeCode([[
		var shaderName = "textGlitch";
		
		game.initLuaShader(shaderName);
	
		var shader0 = game.createRuntimeShader(shaderName);
		game.getLuaObject("scoreText").shader = shader0;
		setVar('shader0', shader0);
		
		game.getLuaObject('scoreText').cameras = [getVar('camHUD2')];
		game.getLuaObject('bar').cameras = [getVar('camHUD2')];
		game.getLuaObject('barDown').cameras = [getVar('camHUD2')];
		game.getLuaObject('barTop').cameras = [getVar('camHUD2')];
	]])
end

function onStepHit()
	if curStep == startAmimStep-25 then
		doTweenY('top', 'barTop', (downscroll and -155 or 565), 3, 'cubeinout')
		doTweenY('but', 'barDown', (downscroll and 500 or -155), 3, 'cubeinout')
		doTweenY('bar', 'bar', (downscroll and 30 or 455), 3, 'cubeinout')
		doTweenY('score', 'scoreText', (downscroll and 65 or 620), 3, 'cubeinout')
	end
	if curStep == startAmimStep+12 then
		playAnim('bar', 'load')
	end
end

function goodNoteHit(id, data, type, hold)
	if not hold then
		doTweenX('scoreValue', 'scoreValue', score, 0.5)
	end
	addHealth_ = addHealth_ + 1
	if addHealth_ > 5 then
		addHealth_ = 1
		if curHealth < 6 then
			curHealth = curHealth + 1
		end
	end
	if not botPlay then
	noteTweenY(data..'note', data+4, defaultOpponentStrumY1 + (downscroll and 15 or 15), 0.15)
	end
end

function noteMiss(id, data, type, hold)
	curHealth = curHealth - 1
	if curHealth < 1 then
		addHealth(-114514)
	end
end

function onUpdatePost()
	runHaxeCode([[
		getVar('shader0').setFloat('iTime', ]]..os.clock()..[[);
	]])
	
	setTextString('scoreText', math.floor(getProperty('scoreValue.x')))
	
	if getProperty('bar.animation.curAnim.name') ~= ('die' or 'load') and curStep > startAmimStep+14 then
		playAnim('bar', 'health_'..curHealth)
	end	
	
	resetKey()
	setProperty('camHUD2.zoom', getProperty('camHUD.zoom'))
end

local key = {'left', 'down', 'up', 'right'}
function resetKey()
	for i = 1, 4 do
		if keyReleased(key[i]) then
			noteTweenY((i-1)..'note', i+3, defaultOpponentStrumY1, 0.15)
		end
	end
end