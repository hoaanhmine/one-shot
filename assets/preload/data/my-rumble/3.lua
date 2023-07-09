local path = 'hud/convict/'
local startAmimStep = 48
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
	if not downscroll then
		makeLuaSprite('barTop', path..'barTop', -67, 865)
		makeLuaSprite('barDown', path..'barDown', -47, -455)
		makeAnimatedLuaSprite('bar', path..'bar', 880, 800)
		setProperty('barTop.flipY', true)
		setProperty('barDown.flipY', true)
	else
		makeLuaSprite('barTop', path..'barTop-down', -45.5, -455)
		makeLuaSprite('barDown', path..'barDown', -47, 800)
		makeAnimatedLuaSprite('bar', path..'bar', 875, -305)
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
	
	makeLuaText('scoreText', '', 150, 0, (downscroll and -235 or 920))
	addLuaText('scoreText')
	setTextSize('scoreText', 40)
	setTextFont('scoreText', 'Schluber.ttf')
	setTextAlignment('scoreText', 'center');
	setTextColor('scoreText', 'FFFF00')
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
	setProperty('camHUD.alpha', 0)
	setProperty('showRating', false)
	setProperty('showComboNum', false)
	
	local middleWay = {412, 524, 636, 748}
	for i = 0, 3 do
		setPropertyFromGroup('opponentStrums', i, 'x', middleWay[i+1]-1919810)
		setPropertyFromGroup('playerStrums', i, 'x', middleWay[i+1])
	end
	
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
		game.camGame.zoom = 1;
	]])
end

function onStepHit()
if curStep == 1 then
		doTweenZoom('camGame', 'camGame', 0.54, 4, 'smootherstepinout')
		doTweenAlpha('camGameA', 'camGame', 1, 3.5)
	end
	if curStep == startAmimStep-25 then
		doTweenAlpha('HUD', 'camHUD', 1, 2)
		doTweenY('top', 'barTop', (downscroll and -155 or 565), 3, 'cubeinout')
		doTweenY('but', 'barDown', (downscroll and 500 or -155), 3, 'cubeinout')
		doTweenY('bar', 'bar', (downscroll and -5 or 500), 3, 'cubeinout')
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
			noteTweenY((i-1)..'note', i+3, defaultOpponentStrumY1, 0.3)
		end
	end
end