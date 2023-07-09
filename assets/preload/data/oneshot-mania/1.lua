local inSubstate = 'titleMenu'
local substateVar = {
	titleMenu = {
		flashing = [[
				THIS GAME CONTAINS FLASHING LIGHTS
		YOU CAN DISABE THIS AND OTHER VISUAL EFFECTS
						IN THE OPTIONS MENU
		]],
		startIntro = false,
		introText = {
			'',
			'quality',
			'is',
			'batter',
			'than',
			'quantity'
		},
		curIntro = 1,
		intro = true,
		canStart = false,
	},
	mainMenu = {
		choose = '',
		canChoose = true
	},
	songsMenu = {
		canChoose = true,
		canExit = false,
		canStart = false,
		choose = ''
	},
	creditsMenu = {
		curSelected = 1,
		speakFrame = 1,
		curText = 1
	}
}

local Credits = {
	{'Oneshot Mania Team'},
	{'DozenRahyz', 'DozenRahyz', 'https://twitter.com/dozenrahyz', 'Artist & Animator', 'Hola tengo un kofi denme plata'},
	{'RechiTv', 'RechiTv', 'https://twitter.com/RechiTv', 'Artist & Animator', 'Coffee is just bean soup'},
	{'SugarMoon', 'SugarMoon', 'https://twitter.com/sugarcoatedOwO', 'Musician & Programmer', 'Te estas portando mal, seras sacrificada'},
	{'Farsy', 'Farsy', 'https://twitter.com/Farsyyyyy', 'Charter', 'es martillo, es real!!! tomenme una foto con e-oh on hermano'},
	{'NOH Team'},
	{'TieGuo', 'TieGuo', 'https://b23.tv/4ofgblD', 'Lua Programmer & Menu Restore', "I'm a yellow fox not cat"},
	{'Yeoildx', 'Yeoildx', 'https://b23.tv/KpxQRnc', 'Lua Programmer & Sprite Optimizer', 'Chair love TieGuo'},
	{'Frog\nFNF_BOYFRIEND', 'Frog', 'https://b23.tv/wp0ahv3', 'Lua Programmer & Shaders Fixer', 'Fucking memory gets higher and higher'}
}

local CreditsSpecialThanks = [[
	SPECIAL THANKS
	
	Novasaur
	Girlfriend's VA
	
	Lumi
	Emotional support
]]

local beatTime = 60/140/2
local curBeat = 0

function onCreate()
	runHaxeCode([[
        FlxG.cameras.remove(game.camOther, false);
        
		var camBack:FlxCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
        camBack.bgColor = 0x00;
        setVar('camBack', camBack);
        
        var camCredits:FlxCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
        camCredits.bgColor = 0x00;
        setVar('camCredits', camCredits);
        
        var camUI:FlxCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
        camUI.bgColor = 0x00;
        setVar('camUI', camUI);
        
        var camVirtualPad:FlxCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
        camVirtualPad.bgColor = 0x00;
        setVar('camVirtualPad', camVirtualPad);
        
        FlxG.cameras.add(camBack, false);
        FlxG.cameras.add(game.camOther, false);
        FlxG.cameras.add(camCredits, false);
        FlxG.cameras.add(camUI, false);
        FlxG.cameras.add(camVirtualPad, false);
        
        game.initLuaShader('bgMenu');
		shaderBlur = game.createRuntimeShader('bgMenu');
		camBack.setFilters([new ShaderFilter(shaderBlur)]);
		shaderBlur.setFloat('iTime', 1);
		setVar('shaderBlur', shaderBlur);
	]])
end

function onCreatePost()
	addHaxeLibrary('FlxMath', 'flixel.math')
	addHaxeLibrary('CoolUtil')
	addHaxeLibrary('LoadingState')
	
	changeSub('titleMenu', false)
	
	initLuaShader('white')
	initLuaShader('colorSwap')
	
	makeLuaSprite('blackLoading', '', 0, 0);
	makeGraphic('blackLoading', 1280, 720, '000000')
	addLuaSprite('blackLoading', true);
	setObjCamera("blackLoading", 'camUI');
	setProperty('blackLoading.alpha', 0)
end

function onUpdatePost(elapsed)
	if inSubstate == 'titleMenu' then titleMenuUpdate() 
	elseif inSubstate == 'mainMenu' then mainMenuUpdate()
	elseif inSubstate == 'songsMenu' then songsMenuUpdate()
	elseif inSubstate == 'creditsMenu' then creditsMenuUpdate() end
	
	if inSubstate == 'titleMenu' then
		runHaxeCode([[
			game.camOther.zoom = FlxMath.lerp(1, game.camOther.zoom, CoolUtil.boundTo(1 - (]]..elapsed..[[ * 3.125 * 1), 0, 1));
			game.getLuaObject('logo').scale.x = FlxMath.lerp(0.2, game.getLuaObject('logo').scale.x, CoolUtil.boundTo(1 - (]]..elapsed..[[ * 3.125 * 1), 0, 1));
			game.getLuaObject('logo').scale.y = FlxMath.lerp(0.2, game.getLuaObject('logo').scale.y, CoolUtil.boundTo(1 - (]]..elapsed..[[ * 3.125 * 1), 0, 1));
		]])
	end
	
	runHaxeCode("getVar('camBack').zoom = FlxMath.lerp(1, getVar('camBack').zoom, CoolUtil.boundTo(1 - ("..elapsed.." * 3.125 * 1), 0, 1)); getVar('shaderBlur').setFloat('iTime', "..os.clock()..");")

	androidPadUpdate()
	setShaderFloat('back', 'iTime', os.clock())
	--debugPrint(inSubstate)
end

function titleMenuUpdate()
	if not substateVar.titleMenu.startIntro then
		if mouseClicked('left') or keyboardJustPressed('ENTER') then
			doTweenAlpha('flashing', 'flashing', 0, 0.8)
			substateVar.titleMenu.startIntro = true
		end
	else
		if substateVar.titleMenu.intro then
			setTextString('introText', substateVar.titleMenu.introText[substateVar.titleMenu.curIntro])
			if substateVar.titleMenu.curIntro >= 6 then
				setProperty('introText.scale.x', getProperty('introText.scale.x')+0.15)
				setProperty('introText.scale.y', getProperty('introText.scale.y')-0.07)
			end
		end
		if substateVar.titleMenu.canStart then
			if mouseClicked('left') or keyboardJustPressed('ENTER') then
				playSound('menu/selec', 1)
				substateVar.titleMenu.canStart = false
				cameraFlash('camOther', 'FFFFFF', 0.45, false)
				playAnim('titleEnter', 'ENTER_PRESSED')
				runTimer('goMenuMenu1', 2.5)
			end
		end
	end
end

local choosingMain = {false, false, false}

function mainMenuUpdate()
	setProperty('mause.x', getMouseX('camOther')-75)
	setProperty('mause.y', getMouseY('camOther')-75)
	if mouseClicked('left') then
		playAnim('mause', 'play')
	end
	
	if androidPadJustPress('b') or keyboardJustPressed('ESCAPE') then
		exitSong()
	end
	
	if substateVar.mainMenu.canChoose then
	if getMouseX('camOther') > 60 and getMouseX('camOther') < 320 and
	getMouseY('camOther') > 220 and getMouseY('camOther') < 500 then
		substateVar.mainMenu.choose = 'Credits'
	elseif getMouseX('camOther') > 380 and getMouseX('camOther') < 800 and
	getMouseY('camOther') > 220 and getMouseY('camOther') < 500 then
		substateVar.mainMenu.choose = 'Songs'
	elseif getMouseX('camOther') > 850 and getMouseX('camOther') < 1100 and
	getMouseY('camOther') > 220 and getMouseY('camOther') < 500 then
		substateVar.mainMenu.choose = 'Options'
	else
		substateVar.mainMenu.choose = ''
	end
	
	if substateVar.mainMenu.choose == 'Songs' then
		if not choosingMain[1] then
			playAnim('Songs', 'play')
			loadGraphic('backG', 'menu/main/bg_songs')
			doTweenX('songX', 'Songs.scale', 0.92, 0.08)
			doTweenY('songY', 'Songs.scale', 0.92, 0.08)
			
			doTweenX('optionX', 'Options.scale', 0.9, 0.08)
			doTweenY('optionY', 'Options.scale', 0.9, 0.08)
			
			doTweenX('creditX', 'Credits.scale', 0.9, 0.08)
			doTweenY('creditY', 'Credits.scale', 0.9, 0.08)
			
			doTweenY('songT', 'SongsT', 600, 0.08)
			doTweenY('optionT', 'OptionsT', 300, 0.08)
			doTweenY('creditT', 'CreditsT', 300, 0.08)
			playSound('menu/change', 1)
			choosingMain = {true, false, false}
		end
		setProperty('Credits.animation.curAnim.curFrame', 0)
		setProperty('Options.animation.curAnim.curFrame', 0)
		if mouseClicked('left') then
			substateVar.mainMenu.canChoose = false
			doTweenY('creditsStart_y', 'Credits', 1000, 0.5, 'smootherstepinout')
			doTweenY('optionsStart_Songs', 'Options', 1000, 0.75, 'smootherstepinout')
			doTweenX('songsStart_x', 'Songs', 350, 0.4, 'smootherstepinout')
			cameraFlash('camOther', 'FFFFFF', 0.45, false)
			removeLuaText('SongsT'); removeLuaText('CreditsT'); removeLuaText('OptionsT')
		end
	elseif substateVar.mainMenu.choose == 'Options' then
		if not choosingMain[2] then
			playAnim('Options', 'play')
			loadGraphic('backG', 'menu/main/bg_options')
			doTweenX('optionX', 'Options.scale', 0.98, 0.08)
			doTweenY('optionY', 'Options.scale', 0.98, 0.08)
			
			doTweenX('songX', 'Songs.scale', 0.8, 0.08)
			doTweenY('songY', 'Songs.scale', 0.8, 0.08)
			
			doTweenX('creditX', 'Credits.scale', 0.9, 0.08)
			doTweenY('creditY', 'Credits.scale', 0.9, 0.08)
			
			doTweenY('optionT', 'OptionsT', 130, 0.08)
			doTweenY('creditT', 'CreditsT', 300, 0.08)
			doTweenY('songT', 'SongsT', 400, 0.08)
			playSound('menu/change', 1)
			choosingMain = {false, true, false}
		end
		setProperty('Credits.animation.curAnim.curFrame', 0)
		setProperty('Songs.animation.curAnim.curFrame', 0)
		if mouseClicked('left') then
			substateVar.mainMenu.canChoose = false
			doTweenY('creditsStart_y', 'Credits', 1000, 0.5, 'smootherstepinout')
			doTweenY('songsStart_Options', 'Songs', 1000, 0.75, 'smootherstepinout')
			doTweenX('OptionsStart_x', 'Options', 500, 0.4, 'smootherstepinout')
			removeLuaText('SongsT'); removeLuaText('CreditsT'); removeLuaText('OptionsT')
		end
	elseif substateVar.mainMenu.choose == 'Credits' then
		if not choosingMain[3] then
			playAnim('Credits', 'play')
			loadGraphic('backG', 'menu/main/bg_credits')
			doTweenX('creditX', 'Credits.scale', 0.98, 0.08)
			doTweenY('creditY', 'Credits.scale', 0.98, 0.08)
			
			doTweenX('songX', 'Songs.scale', 0.8, 0.08)
			doTweenY('songY', 'Songs.scale', 0.8, 0.08)
	
			doTweenX('optionX', 'Options.scale', 0.9, 0.08)
			doTweenY('optionY', 'Options.scale', 0.9, 0.08)
			
			doTweenY('creditT', 'CreditsT', 130, 0.08)
			doTweenY('optionT', 'OptionsT', 300, 0.08)
			doTweenY('songT', 'SongsT', 400, 0.08)
			playSound('menu/change', 1)
			choosingMain = {false, false, true}
		end
		setProperty('Options.animation.curAnim.curFrame', 0)
		setProperty('Songs.animation.curAnim.curFrame', 0)
		if mouseClicked('left') then
			substateVar.mainMenu.canChoose = false
			makeCreditsThings()
		end
	elseif substateVar.mainMenu.choose == '' then
		setProperty('Options.animation.curAnim.curFrame', 0)
		setProperty('Songs.animation.curAnim.curFrame', 0)
		setProperty('Credits.animation.curAnim.curFrame', 0)
		loadGraphic('backG', 'menu/main/bg_gray')
		doTweenX('creditX', 'Credits.scale', 0.9, 0.03)
		doTweenY('creditY', 'Credits.scale', 0.9, 0.03)
			
		doTweenX('songX', 'Songs.scale', 0.8, 0.03)
		doTweenY('songY', 'Songs.scale', 0.8, 0.03)
	
		doTweenX('optionX', 'Options.scale', 0.9, 0.03)
		doTweenY('optionY', 'Options.scale', 0.9, 0.03)
		
		doTweenY('creditT', 'CreditsT', 300, 0.08)
		doTweenY('songT', 'SongsT', 400, 0.08)
		doTweenY('optionT', 'OptionsT', 300, 0.08)
		choosingMain = {false, false, false}
	end
	end
end

local choosingSongs = {false, false}

function songsMenuUpdate()
	setProperty('mause.x', getMouseX('camOther')-75)
	setProperty('mause.y', getMouseY('camOther')-75)
	if mouseClicked('left') then
		playAnim('mause', 'play')
	end
	if substateVar.songsMenu.canChoose then
		if getMouseX('camOther') > 845 and getMouseX('camOther') < 1077 and
	getMouseY('camOther') > 254 and getMouseY('camOther') < 361 then
			substateVar.songsMenu.choose = 'deimos'
			if not choosingSongs[1] then
				doTweenX('back1X', 'barra1.scale', 0.58, 0.08)
				doTweenY('back1Y', 'barra1.scale', 0.57, 0.08)
				
				doTweenX('back1TX', 'deimosTiltle.scale', 0.36, 0.08)
				doTweenY('back1TY', 'deimosTiltle.scale', 0.36, 0.08)
				
				doTweenX('back2X', 'barra2.scale', 0.48, 0.08)
				doTweenY('back2Y', 'barra2.scale', 0.48, 0.08)

				doTweenX('back2TX', 'convictTiltle.scale', 0.28, 0.08)
				doTweenY('back2TY', 'convictTiltle.scale', 0.28, 0.08)
				
				playSound('menu/change', 1)
				
				setProperty('convict.alpha', 0)
				setProperty('convict_bg.alpha', 0)
				setProperty('deimos.alpha', 1)
				setProperty('deimos_bg.alpha', 0)
				setProperty('deimos_rock.alpha', 0)
			end
			choosingSongs = {true, false}
			
			if mouseClicked('left') then
				playSound('music/deimos', 1, 'backMusic')
				playAnim('deimos', 'idleintro')
				doTweenAlpha('deimos_bg', 'deimos_bg', 1, 0.5)
				doTweenAlpha('deimos_rock', 'deimos_rock', 1, 0.5)
				doTweenY('deimos_rock2', 'deimos_rock', 0, 0.5, 'smootherstepinout')
				setProperty('esc.alpha', 1)
				setProperty('enter.alpha', 1)
				setProperty('exit.alpha', 0)
				substateVar.songsMenu.canChoose = false
				substateVar.songsMenu.canExit = true
				addVirtualPad('', 'a_b')
			end
		elseif getMouseX('camOther') > 800 and getMouseX('camOther') < 1050 and
	getMouseY('camOther') > 370 and getMouseY('camOther') < 480 then
			substateVar.songsMenu.choose = 'convict'
			if not choosingSongs[2] then
				doTweenX('back2X', 'barra2.scale', 0.58, 0.08)
				doTweenY('back2Y', 'barra2.scale', 0.58, 0.08)
				
				doTweenX('back2TX', 'convictTiltle.scale', 0.33, 0.08)
				doTweenY('back2TY', 'convictTiltle.scale', 0.33, 0.08)
				
				doTweenX('back1X', 'barra1.scale', 0.48, 0.08)
				doTweenY('back1Y', 'barra1.scale', 0.48, 0.08)
				
				doTweenX('back1TX', 'deimosTiltle.scale', 0.3, 0.08)
				doTweenY('back1TY', 'deimosTiltle.scale', 0.3, 0.08)
				
				playSound('menu/change', 1)
				
				setProperty('convict.alpha', 1)
				setProperty('convict_bg.alpha', 1)
				setProperty('deimos.alpha', 0)
				setProperty('deimos_bg.alpha', 0)
				setProperty('deimos_rock.alpha', 0)
			end
			choosingSongs = {false, true}
			
			if mouseClicked('left') then
				doTweenColor('convictC', 'convict', 'FFFFFF', 1.2)
				playSound('music/convict', 1, 'backMusic')
				setProperty('esc.alpha', 1)
				setProperty('enter.alpha', 1)
				setProperty('exit.alpha', 0)
				substateVar.songsMenu.canChoose = false
				substateVar.songsMenu.canExit = true
				substateVar.songsMenu.canStart = true
				addVirtualPad('', 'a_b')
			end
		else
			substateVar.songsMenu.choose = ''
			doTweenX('back1X', 'barra1.scale', 0.48, 0.08)
			doTweenY('back1Y', 'barra1.scale', 0.48, 0.08)
				
			doTweenX('back1TX', 'deimosTiltle.scale', 0.3, 0.08)
			doTweenY('back1TY', 'deimosTiltle.scale', 0.3, 0.08)
			
			doTweenX('back2X', 'barra2.scale', 0.48, 0.08)
			doTweenY('back2Y', 'barra2.scale', 0.48, 0.08)
				
			doTweenX('back2TX', 'convictTiltle.scale', 0.28, 0.08)
			doTweenY('back2TY', 'convictTiltle.scale', 0.28, 0.08)
			choosingSongs = {false, false}
			if keyboardJustPressed('ESCAPE') or androidPadJustPress('b') then
				loadingChangeSub('mainMenu', true)
			end
		end
	else
		if getProperty('deimos.animation.curAnim.name') == 'idleintro' and getProperty('deimos.animation.curAnim.finished') then
			playAnim('deimos', 'idleact')
		end
		
		if substateVar.songsMenu.choose == 'deimos' then
			if (keyboardJustPressed('ESCAPE') or androidPadJustPress('b')) and substateVar.songsMenu.canExit then
				substateVar.songsMenu.canChoose = true
				playAnim('deimos', 'inactive')
				playSound('music/freakyMenu', 1, 'backMusic')
				playSound('menu/selec', 1)
				setProperty('esc.alpha', 0)
				setProperty('enter.alpha', 0)
				setProperty('exit.alpha', 1)
				addVirtualPad('', 'b')
				doTweenAlpha('deimos_bg', 'deimos_bg', 0, 0.5)
				doTweenAlpha('deimos_rock', 'deimos_rock', 0, 0.5)
				doTweenY('deimos_rock2', 'deimos_rock', -300, 0.5, 'smootherstepinout')
			end
			
			if keyboardJustPressed('ENTER') or androidPadJustPress('a') and substateVar.songsMenu.canStart then
				makeLuaSprite('blackBack', '', 0, 0);
				makeGraphic('blackBack', 1280, 720, '000000')
				addLuaSprite('blackBack', true);
				setObjectCamera("blackBack", 'camOther');
				
				setProperty('esc.alpha', 0)
				setProperty('enter.alpha', 0)
				setProperty('exit.alpha', 0)
	
				cameraFlash('camOther', 'FF0000', 0.5, true)
				
				playSound('menu/deimos_acept', 1)
				removeVirtualPad()
				runTimer('startsacrifice', 1)
			end
			
			if keyboardJustPressed('ENTER') or androidPadJustPress('a') then
				cameraFlash('camOther', 'FF0000', 0.1)
				substateVar.songsMenu.canExit = false
				substateVar.songsMenu.canStart = true
				playSound('menu/warn', 1)
				makeAnimatedLuaSprite('choose', 'hud/deimos/choose', 0, 0);
				addAnimationByPrefix('choose', 'idle', 'mensaje', 24, true)
				addLuaSprite('choose')
				scaleObject('choose', 0.5, 0.5)
				screenCenter('choose')
				setObjectCamera('choose', 'camOther');
				
				makeAnimatedLuaSprite('grunt_tutorial', 'hud/deimos/grunt_tutorial', 480, 325);
				addAnimationByPrefix('grunt_tutorial', 'idle', 'MADNESS MODE MISS', 24, true)
				addLuaSprite('grunt_tutorial')
				scaleObject('grunt_tutorial', 0.45, 0.45)
				setObjectCamera('grunt_tutorial', 'camOther');
				
				makeAnimatedLuaSprite('exp', 'hud/deimos/exp', 630, 290);
				addAnimationByPrefix('exp', 'standard', 'standard explanation', 24, true)
				addAnimationByPrefix('exp', 'madness', 'madness explanation', 24, true)
				addLuaSprite('exp')
				scaleObject('exp', 0.45, 0.45)
				setObjectCamera('exp', 'camOther');
				
				makeAnimatedLuaSprite('diff', 'hud/deimos/diff', 585, 260);
				addAnimationByPrefix('diff', 'standard', 'standard', 24, true)
				addAnimationByPrefix('diff', 'madness', 'madness loop', 24, true)
				addLuaSprite('diff')
				scaleObject('diff', 0.45, 0.45)
				setObjectCamera('diff', 'camOther');
			end
		elseif substateVar.songsMenu.choose == 'convict' then
			if (keyboardJustPressed('ESCAPE') or androidPadJustPress('b')) and substateVar.songsMenu.canExit then
				doTweenColor('convictC', 'convict', '000000', 0.6)
				substateVar.songsMenu.canChoose = true
				substateVar.songsMenu.canStart = false
				playSound('music/freakyMenu', 1, 'backMusic')
				playSound('menu/selec', 1)
				setProperty('esc.alpha', 0)
				setProperty('enter.alpha', 0)
				setProperty('exit.alpha', 1)
				addVirtualPad('', 'b')
			end
			
			if keyboardJustPressed('ENTER') or androidPadJustPress('a') and substateVar.songsMenu.canStart then
				makeLuaSprite('blackBack', '', 0, 0);
				makeGraphic('blackBack', 1280, 720, '000000')
				addLuaSprite('blackBack', true);
				setObjCamera("blackBack", 'camUI');
				setProperty('blackBack.alpha', 0)
				doTweenAlpha('blackBack', 'blackBack', 1, 2)
				
				cameraFlash('camOther', 'FFFFFF', 0.25, true)
				
				setProperty('camOther.zoom', 1.3)
				doTweenZoom('camOtherz', 'camOther', 1, 2, 'smootherstepinout')
		
				playSound('menu/convict/start', 1)
				removeVirtualPad()
				runTimer('startconvict', 2.5)
			end
			
		end
	end
	--debugPrint(getMouseX('camOther'), getMouseY('camOther'))
end

function creditsMenuUpdate()
	for i = 1, #Credits do
		if #Credits[i] > 1 then
			doTweenY('credits_icon_'..i..'_move', 'credits_icon_'..i, 310-(substateVar.creditsMenu.curSelected-i)*150, 0.1)
			doTweenY('credits_text_'..i..'_move', 'credits_text_'..i, 350-(substateVar.creditsMenu.curSelected-i)*150, 0.1)
			
			doTweenX('credits_icon_'..i..'_xScale', 'credits_icon_'..i..'.scale', 0.85, 0.1)
			doTweenY('credits_icon_'..i..'_yScale', 'credits_icon_'..i..'.scale', 0.85, 0.1)
			
			doTweenX('credits_text_'..i..'_xScale', 'credits_text_'..i..'.scale', 0.85, 0.1)
			doTweenY('credits_text_'..i..'_yScale', 'credits_text_'..i..'.scale', 0.85, 0.1)
			
			setProperty('credits_icon_'..i..'.alpha', 0.7)
			setProperty('credits_text_'..i..'.alpha', 0.7)
		else
			doTweenY('credits_text_'..i..'_move', 'credits_text_'..i, 335-(substateVar.creditsMenu.curSelected-i)*150, 0.1)
		end
	end
	
	if keyboardJustPressed('DOWN') or androidPadJustPress('down') then
		substateVar.creditsMenu.curSelected = substateVar.creditsMenu.curSelected+1
		if #Credits[substateVar.creditsMenu.curSelected] <= 1 then
			substateVar.creditsMenu.curSelected = substateVar.creditsMenu.curSelected + 1
		end
		substateVar.creditsMenu.curText = 1
	elseif keyboardJustPressed('UP') or androidPadJustPress('up') then
		substateVar.creditsMenu.curSelected = substateVar.creditsMenu.curSelected-1
		if #Credits[substateVar.creditsMenu.curSelected] <= 1 then
			substateVar.creditsMenu.curSelected = substateVar.creditsMenu.curSelected - 1
		end
		substateVar.creditsMenu.curText = 1
	end
	
	if substateVar.creditsMenu.curSelected < 1 then substateVar.creditsMenu.curSelected = #Credits end
	if substateVar.creditsMenu.curSelected > #Credits then substateVar.creditsMenu.curSelected = 1 end
	
	if substateVar.creditsMenu.curSelected == 1 and #Credits[1] <= 1 then
		substateVar.creditsMenu.curSelected = 2
		substateVar.creditsMenu.curText = 1
	end
 	
	if keyboardJustPressed('ENTER') or androidPadJustPress('a') then
		runHaxeCode("CoolUtil.browserLoad('"..Credits[substateVar.creditsMenu.curSelected][3].."');") 
	end
	
	if keyboardJustPressed('ESCAPE') or androidPadJustPress('b') then
		runHaxeCode([[
			FlxTween.tween(getVar('camCredits'), {alpha: 0}, 0.3, {ease: FlxEase.quadOut});
		]])
		inSubstate = 'mainMenu'
		substateVar.mainMenu.canChoose = true
		addVirtualPad('none', 'b')
		setProperty('exit.alpha', 1)
		setProperty('esc.alpha', 0)
		setProperty('enter.alpha', 0)
	end
	
	substateVar.creditsMenu.speakFrame = substateVar.creditsMenu.speakFrame + 1
	if substateVar.creditsMenu.speakFrame > 3 then
		substateVar.creditsMenu.speakFrame = 1
		substateVar.creditsMenu.curText = substateVar.creditsMenu.curText+1
	end
	doTweenX('credits_icon_'..substateVar.creditsMenu.curSelected..'_xScale', 'credits_icon_'..substateVar.creditsMenu.curSelected..'.scale', 1, 0.1)
	doTweenY('credits_icon_'..substateVar.creditsMenu.curSelected..'_yScale', 'credits_icon_'..substateVar.creditsMenu.curSelected..'.scale', 1, 0.1)
	
	doTweenX('credits_text_'..substateVar.creditsMenu.curSelected..'_xScale', 'credits_text_'..substateVar.creditsMenu.curSelected..'.scale', 1, 0.1)
	doTweenY('credits_text_'..substateVar.creditsMenu.curSelected..'_yScale', 'credits_text_'..substateVar.creditsMenu.curSelected..'.scale', 1, 0.1)
	
	setProperty('credits_icon_'..substateVar.creditsMenu.curSelected..'.alpha', 1)
	setProperty('credits_text_'..substateVar.creditsMenu.curSelected..'.alpha', 1)
	
	setTextString('positionText', Credits[substateVar.creditsMenu.curSelected][4])
	setTextString('describeText', string.sub(Credits[substateVar.creditsMenu.curSelected][5], 1, substateVar.creditsMenu.curText))
end

function makeCreditsThings()
	runHaxeCode("getVar('camCredits').alpha = 1;")
	addVirtualPad('up_down', 'a_b')
	inSubstate = 'creditsMenu'
	makeLuaSprite('blackBack', '', 0, 0);
	makeGraphic('blackBack', 1280, 720, '000000')
	addLuaSprite('blackBack');
	setProperty('blackBack.alpha', 0.5)
	setObjCamera("blackBack", 'camCredits');
	
	makeLuaSprite('box', 'menu/credits/box', 800, 90)
	addLuaSprite('box')
	setObjCamera("box", 'camCredits');
	
	makeLuaText('positionText', '', 350, 810, 106)
	addLuaText('positionText')
	setTextSize('positionText', 24)
	setTextFont('positionText', 'hudFont.ttf')
	setObjCamera("positionText", 'camCredits');
	
	makeLuaText('describeText', '', 350, 810, 206)
	addLuaText('describeText')
	setTextSize('describeText', 24)
	setTextFont('describeText', 'hudFont.ttf')
	setObjCamera("describeText", 'camCredits');
	
	makeLuaText('CreditsSpecialThanks', CreditsSpecialThanks, 350, 810, 490)
	addLuaText('CreditsSpecialThanks')
	setTextSize('CreditsSpecialThanks', 20)
	setTextFont('CreditsSpecialThanks', 'hudFont.ttf')
	setObjCamera("CreditsSpecialThanks", 'camCredits');
	
	for i = 1, #Credits do
		if #Credits[i] > 1 then
			makeLuaSprite('credits_icon_'..i, 'menu/credits/'..Credits[i][2], 100, 0)
			addLuaSprite('credits_icon_'..i)
			setObjCamera('credits_icon_'..i, 'camCredits');
			
			makeLuaText('credits_text_'..i, Credits[i][1], 1000, -100, 0)
			addLuaText('credits_text_'..i)
			setTextSize('credits_text_'..i, 24)
			setTextFont('credits_text_'..i, 'hudFont.ttf')
			setObjCamera('credits_text_'..i, 'camCredits');
		else
			makeLuaText('credits_text_'..i, Credits[i][1], 1000, -225, 0)
			addLuaText('credits_text_'..i)
			setTextSize('credits_text_'..i, 30)
			setTextFont('credits_text_'..i, 'hudFont.ttf')
			setObjCamera('credits_text_'..i, 'camCredits');
		end
	end
	makeLuaSprite('enter', 'menu/options/enter', 1030, 590);
	addLuaSprite('enter', true);
	scaleObject('enter', 0.6, 0.6)
	setObjCamera("enter", 'camUI');
		
	makeLuaSprite('esc', 'menu/options/esc', 10, 5);
	addLuaSprite('esc', true);
	scaleObject('esc', 0.6, 0.6)
	setObjCamera("esc", 'camUI');
	
	setProperty('exit.alpha', 0)
end

function loadingChangeSub(name)
	doTweenAlpha('blackLoading-'..name, 'blackLoading', 1, 0.5)
end

function changeSub(name, load)
	runTimer('changeSub-'..name, 0.0001)
	if name == 'titleMenu' then
		substateVar.titleMenu.curIntro = 1
		
		makeLuaSprite('back', 'menu/main/bg_options', 0, 0);
		addLuaSprite('back');
		setObjCamera("back", 'camBack');
		
		setSpriteShader('back', 'colorSwap')
		setSpriteShader('back2', 'bgMenu')
		
		makeLuaSprite('logo', 'menu/title/logo', 400.2, 1990.4); -- 190.4
		addLuaSprite('logo');
		scaleObject('logo', 0.3, 0.3)
		setProperty('logo.angle', 90)
		setObjCamera("logo", 'camUI');
		
		makeAnimatedLuaSprite('titleEnter', 'titleEnter', 450, 2000)
		addAnimationByPrefix('titleEnter', 'ENTER_PRESSED', 'ENTER PRESSED', 24, true)
		addAnimationByPrefix('titleEnter', 'Press_Enter_to_Begin', 'Press Enter to Begin', 24, true)
		scaleObject('titleEnter', 0.4, 0.4)
		addLuaSprite('titleEnter')
		playAnim('titleEnter', 'Press_Enter_to_Begin')
		setObjCamera("titleEnter", 'camUI');
		
		makeLuaSprite('upBar', 'menu/misc/black_bars', 0, 0);
		addLuaSprite('upBar');
		setObjCamera("upBar", 'camUI');
		
		makeLuaSprite('downBar', 'menu/misc/black_bars', 0, 640);
		addLuaSprite('downBar');
		setObjCamera("downBar", 'camUI');
		
		makeLuaSprite('blackBack', '', 0, 0);
		makeGraphic('blackBack', 1280, 720, '000000')
		addLuaSprite('blackBack');
		setObjectCamera("blackBack", 'camOther');
	
		makeLuaSprite('witheBack', '', 0, 0);
		makeGraphic('witheBack', 1280, 720, 'FFFFFF')
		addLuaSprite('witheBack');
		setProperty('witheBack.alpha', 0)
		setProperty('witheBack.scale.y', 0.85)
		setObjectCamera("witheBack", 'camOther');
		
		makeLuaText('introText', '', 1000, 0, 0)
		addLuaText('introText')
		setTextFont('introText', 'akira.otf')
		setTextSize('introText', 35)
		setObjectCamera('introText', 'camOther')
		screenCenter('introText')
	elseif name == 'mainMenu' then
		substateVar.mainMenu.canChoose = true
		addVirtualPad('', 'b')
		
		makeLuaSprite('backG', 'menu/main/bg_gary', 0, 0);
		addLuaSprite('backG', true);
		setObjCamera("backG", 'camBack');
		
		makeLuaText('CreditsT', 'credits', 0, 160, 300)
		setTextFont('CreditsT', 'Agora.ttf')
		setTextSize('CreditsT', 30)
		setTextColor('CreditsT', '000000')
		setTextBorder('CreditsT', 2, 'FFFFFF')
		setObjectCamera('CreditsT', 'camOther');
		addLuaText('CreditsT', true)
		
		makeLuaText('SongsT', 'challenges', 0, 528, 400)
		setTextFont('SongsT', 'Agora.ttf')
		setTextSize('SongsT', 30)
		setTextColor('SongsT', '000000')
		setTextBorder('SongsT', 2, 'FFFFFF')
		setObjectCamera('SongsT', 'camOther');
		addLuaText('SongsT', true)
		
		makeLuaText('OptionsT', 'options', 0, 910, 300)
		setTextFont('OptionsT', 'Agora.ttf')
		setTextSize('OptionsT', 30)
		setTextColor('OptionsT', '000000')
		setTextBorder('OptionsT', 2, 'FFFFFF')
		setObjectCamera('OptionsT', 'camOther');
		addLuaText('OptionsT', true)
	
		makeAnimatedLuaSprite('Credits', 'menu/main/credits', -10, 170);
		addAnimationByPrefix('Credits', 'play', 'play', 24, false)
		addLuaSprite('Credits', true);
		scaleObject('Credits', 0.9, 0.9)
		setObjectCamera("Credits", 'camOther');
		
		makeAnimatedLuaSprite('Options', 'menu/main/options', 840, 143);
		addAnimationByPrefix('Options', 'play', 'play', 24, false)
		addLuaSprite('Options', true);
		scaleObject('Options', 0.9, 0.9)
		setObjectCamera("Options", 'camOther');
		
		makeAnimatedLuaSprite('Songs', 'menu/main/songs', 350.5, 142.5);
		addAnimationByPrefix('Songs', 'play', 'play', 24, false)
		addLuaSprite('Songs', true);
		scaleObject('Songs', 0.8, 0.8)
		setObjectCamera('Songs', 'camOther');
		
		makeLuaSprite('upBar', 'menu/misc/black_bars', 0, 0);
		addLuaSprite('upBar');
		setObjCamera("upBar", 'camUI');
		
		makeLuaSprite('downBar', 'menu/misc/black_bars', 0, 640);
		addLuaSprite('downBar');
		setObjCamera("downBar", 'camUI');
		
		makeLuaSprite('exit', 'menu/main/exit', 880, 510);
		addLuaSprite('exit');
		scaleObject('exit', 0.6, 0.6)
		setObjCamera("exit", 'camUI');
		
		makeAnimatedLuaSprite('mause', 'menu/misc/mouse', 0, 0);
		addAnimationByPrefix('mause', 'play', 'mause', 24, false)
		addLuaSprite('mause');
		--scaleObject('mause', 0.9, 0.9)
		setObjCamera("mause", 'camUI');
	elseif name == 'songsMenu' then
		removeLuaSprite('Songs'); removeLuaSprite('Credits'); removeLuaSprite('Options'); removeLuaSprite('backG')
		
		makeLuaSprite('blackBack', '', 940, 0);
		makeGraphic('blackBack', 340, 720, '000000')
		addLuaSprite('blackBack');
		setObjectCamera("blackBack", 'camOther');
		
		makeLuaSprite('REDBGDEI', '', 0, 0);
		makeGraphic('REDBGDEI', 940, 720, 'FF0000')
		addLuaSprite('REDBGDEI');
		setObjectCamera("REDBGDEI", 'camOther');
		
		makeLuaSprite('convict_bg', 'menu/songs/convict_bg', 0, 0)
		addLuaSprite('convict_bg')
		setObjectCamera("convict_bg", 'camOther');
		setProperty('convict_bg.alpha', 0)
		
		makeAnimatedLuaSprite('convict', 'menu/songs/convict', 0, 103);
		addAnimationByPrefix('convict', 'idle', 'idle', 24, true)
		addLuaSprite('convict');
		scaleObject('convict', 0.7, 0.7)
		setObjectCamera('convict', 'camOther');
		setProperty('convict.alpha', 0)
		setProperty('convict.color', getColorFromHex('000000'))
		
		makeLuaSprite('deimos_bg', 'menu/songs/deimos_bg', 0, 0)
		addLuaSprite('deimos_bg')
		setObjectCamera("deimos_bg", 'camOther');
		setProperty('deimos_bg.alpha', 0)
		
		makeLuaSprite('deimos_rock', 'menu/songs/deimos_rock', 0, -300)
		addLuaSprite('deimos_rock')
		setObjectCamera("deimos_rock", 'camOther');
		setProperty('deimos_rock.alpha', 0)
		
		makeAnimatedLuaSprite('challengeBase', 'menu/songs/challengeBase', 370, -49);
		addAnimationByPrefix('challengeBase', 'idle', 'challengeBase instancia 10', 24, true)
		addLuaSprite('challengeBase');
		scaleObject('challengeBase', 0.85, 1)
		setObjectCamera('challengeBase', 'camOther');
		
		makeLuaSprite('challenges', 'menu/songs/challenges', 685, 108)
		addLuaSprite('challenges')
		scaleObject('challenges', 0.45, 0.45)
		setObjectCamera('challenges', 'camOther');
		
		makeAnimatedLuaSprite('barra1', 'menu/songs/barra', 750, 240);
		addAnimationByPrefix('barra1', 'idle', 'barra info0', 24, true)
		addLuaSprite('barra1');
		scaleObject('barra1', 0.48, 0.48)
		setProperty('barra1.angle', 10)
		setObjectCamera('barra1', 'camOther');
		
		makeLuaSprite('deimosTiltle', 'menu/songs/title/deimos', 870, 260)
		setProperty('deimosTiltle.angle', 14)
		addLuaSprite('deimosTiltle')
		scaleObject('deimosTiltle', 0.3, 0.3)
		setObjectCamera('deimosTiltle', 'camOther');
		
		makeAnimatedLuaSprite('barra2', 'menu/songs/barra', 720, 350);
		addAnimationByPrefix('barra2', 'idle', 'barra info0', 24, true)
		addLuaSprite('barra2');
		scaleObject('barra2', 0.48, 0.48)
		setProperty('barra2.angle', 10)
		setObjectCamera('barra2', 'camOther');
		
		makeLuaSprite('convictTiltle', 'menu/songs/title/convict', 825, 360)
		setProperty('convictTiltle.angle', 17)
		addLuaSprite('convictTiltle')
		scaleObject('convictTiltle', 0.24, 0.24)
		setObjectCamera('convictTiltle', 'camOther');
		
		makeAnimatedLuaSprite('barra3', 'menu/songs/barra', 690, 450);
		addAnimationByPrefix('barra3', 'idle2', 'barra info block0', 24, true)
		addLuaSprite('barra3');
		scaleObject('barra3', 0.48, 0.48)
		setProperty('barra3.angle', 10)
		setObjectCamera('barra3', 'camOther');
		
		makeAnimatedLuaSprite('barra4', 'menu/songs/barra', 660, 540);
		addAnimationByPrefix('barra4', 'idle2', 'barra info block0', 24, true)
		addLuaSprite('barra4');
		scaleObject('barra4', 0.48, 0.48)
		setProperty('barra4.angle', 10)
		setObjectCamera('barra4', 'camOther');
		
		makeAnimatedLuaSprite('deimos', 'menu/songs/deimos', 0, 73);
		addAnimationByPrefix('deimos', 'inactive', 'inactive', 36, true)
		addAnimationByPrefix('deimos', 'idleintro', 'idleintro', 36, false)
		addAnimationByPrefix('deimos', 'idleact', 'idleact', 36, true)
		addLuaSprite('deimos');
		setObjectCamera('deimos', 'camOther');
		setProperty('convict.alpha', 0)
		
		makeLuaSprite('upBar', 'menu/misc/black_bars', 0, 0);
		addLuaSprite('upBar');
		setObjCamera("upBar", 'camUI');
		
		makeLuaSprite('downBar', 'menu/misc/black_bars', 0, 640);
		addLuaSprite('downBar');
		setObjCamera("downBar", 'camUI');
		
		makeLuaSprite('enter', 'menu/options/enter', 1030, 590);
		addLuaSprite('enter');
		scaleObject('enter', 0.6, 0.6)
		setObjCamera("enter", 'camUI');
		setProperty('enter.alpha', 0)
		
		makeLuaSprite('esc', 'menu/options/esc', 10, 5);
		addLuaSprite('esc');
		scaleObject('esc', 0.6, 0.6)
		setObjCamera("esc", 'camUI');
		setProperty('esc.alpha', 0)
		
		makeLuaSprite('exit', 'menu/main/exit', 880, 510);
		addLuaSprite('exit');
		scaleObject('exit', 0.6, 0.6)
		setObjCamera("exit", 'camUI');
	end
end

function onTimerCompleted(tag, loops)
	if tag == 'beatHit' then
		beatHit()
	end
	
	if tag == 'goMenuMenu1' then
		doTweenY('lgo', 'logo', 1190.4, 0.85, 'expoinout')
		doTweenAngle('lgo2', 'logo', 90, 0.85, 'circinout')
		doTweenY('titleEnter', 'titleEnter', 2000, 2, 'expoinout')
		runTimer('goMenuMenu2', 0.9)
	end
	if tag == 'goMenuMenu2' then
		loadingChangeSub('mainMenu', true)
	end
	
	if tag == 'startsacrifice' then
		loadSong('Sacrifice', 0)
	end
	if tag == 'startconvict' then
		loadSong('My Rumble', 0)
	end
	
	if string.find(tag, 'changeSub-') then
		inSubstate = string.sub(tag, 11, #tag)
	end
end

function onTweenCompleted(tag)
	if tag == 'logo' then
		substateVar.titleMenu.canStart = true
	end
	
	if tag == 'flashing' then
		runTimer('beatHit', beatTime, 0)
		playSound('music/freakyMenu', 1, 'backMusic')
	end
	
	if string.find(tag, 'blackLoading-') then
		inSubstate = string.sub(tag, 14, #tag)
		changeSub(inSubstate, false)
		doTweenAlpha('blackLoaded', 'blackLoading', 0, 0.5)
		if string.sub(tag, 14, #tag) == 'mainMenu' then
			removeLuaSprite('convict'); removeLuaSprite('convict_bg'); removeLuaSprite('REDBGDEI'); removeLuaSprite('blackBack'); removeLuaSprite('challenges'); removeLuaSprite('challengeBase'); removeLuaSprite('deimos_rock'); removeLuaSprite('deimos_bg'); removeLuaSprite('barra1'); removeLuaSprite('barra2'); removeLuaSprite('barra3'); removeLuaSprite('barra4'); removeLuaSprite('convictTiltle'); removeLuaSprite('deimosTiltle'); removeLuaSprite('deimos');
		end
	end
	
	if tag == 'optionsStart_Songs' then
		doTweenX('songStartX', 'Songs.scale', 1.05, 0.2, 'smootherstepinout')
		doTweenY('songStartY', 'Songs.scale', 1.05, 0.2, 'smootherstepinout')
	end
	if tag == 'songStartX' then
		setSpriteShader('Songs', 'white')
		loadingChangeSub('songsMenu', true)
	end
	
	if tag == 'songsStart_Options' then
		doTweenX('optionStartX', 'Options.scale', 1.05, 0.2, 'smootherstepinout')
		doTweenY('optionStarY', 'Options.scale', 1.05, 0.2, 'smootherstepinout')
	end
	if tag == 'optionStartX' then
		runHaxeCode("LoadingState.loadAndSwitchState(new options.OptionsState()); FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);")
	end
end

function beatHit()
	curBeat = curBeat + 1
	if inSubstate == 'titleMenu' then
		if substateVar.titleMenu.intro then
			substateVar.titleMenu.curIntro = substateVar.titleMenu.curIntro + 1
			if substateVar.titleMenu.curIntro == 6 then
				doTweenAlpha('witheBack', 'witheBack', 1, 0.35)
				doTweenY('witheBackY', 'witheBack.scale', 0, 0.35, 'cubeinout')
			end
			if substateVar.titleMenu.curIntro == 8 then
				substateVar.titleMenu.intro = false
				cameraFlash('camOther', 'FFFFFF', 0.45, false)
				doTweenY('logo', 'logo', 190.4, 0.85, 'expoinout')
				doTweenY('titleEnter', 'titleEnter', 550, 2, 'expoinout')
				doTweenAngle('logo2', 'logo', 0, 0.85, 'circinout')
				removeLuaText('introText')
				removeLuaSprite('blackBack')
			end
		end
		if not substateVar.titleMenu.intro then
			if curBeat % 2 == 0 then
				setProperty('logo.scale.x', getProperty('logo.scale.x')+0.06)
				setProperty('logo.scale.y', getProperty('logo.scale.y')+0.06)
				runHaxeCode("getVar('camBack').zoom = getVar('camBack').zoom+0.05;")
			end
		end
	end
end

function onStartCountdown()
	makeLuaText('flashing', substateVar.titleMenu.flashing, 1280, 0, 0)
	addLuaText('flashing')
	screenCenter('flashing')
	setTextFont('flashing', 'akira.otf')
	setTextSize('flashing', 34)
	setObjectCamera('flashing', 'camOther')
	
	return Function_Stop;
end

function onSoundFinished(tag)
	if tag == 'backMusic' then
		if not substateVar.songsMenu.canChoose then
			if substateVar.songsMenu.choose == 'deimos' then
				playSound('music/deimos', 1, 'backMusic')
			elseif substateVar.songsMenu.choose == 'convict' then
				playSound('music/convict', 1, 'backMusic')
			end
		else
			playSound('music/freakyMenu', 1, 'backMusic')
		end
	end
end

function readdObject(tag)
	removeLuaSprite(tag, false)
	addLuaSprite(tag)
end

function setObjCamera(tag, camera)
    runHaxeCode([[
        game.getLuaObject("]]..tag..[[").camera = getVar("]]..camera..[[");
    ]])
end

androidPad = {}

function addVirtualPad(left, right) removeVirtualPad() if buildTarget == 'android' then androidPad = {}; if left:upper() == 'UP_DOWN' then addAndroidPad('up', 0, 471, 'FFFFFF'); addAndroidPad('down', 0, 593, 'FFFFFF'); elseif left:upper() == 'LEFT_RIGHT' then addAndroidPad('left', 0, 593, 'FFFFFF'); addAndroidPad('right', 132, 593, 'FFFFFF'); elseif left:upper() == 'FULL' then addAndroidPad('up', 112, 359, 'FFFFFF'); addAndroidPad('down', 112, 573, 'FFFFFF'); addAndroidPad('left', 0, 461, 'FFFFFF'); addAndroidPad('right', 223, 461, 'FFFFFF'); end if right:upper() == 'A' then addAndroidPad('a', 1148, 593, 'FFFFFF'); elseif right:upper() == 'B' then addAndroidPad('b', 1148, 593, 'FFFFFF'); elseif right:upper() == 'A_B' then addAndroidPad('a', 1148, 593, 'FFFFFF'); addAndroidPad('b', 1024, 593, 'FFFFFF'); elseif right:upper() == 'ALL' then addAndroidPad('a', 1148, 593, 'FFFFFF'); addAndroidPad('b', 1024, 593, 'FFFFFF'); addAndroidPad('c', 900, 593, 'FFFFFF'); addAndroidPad('d', 776, 593, 'FFFFFF'); addAndroidPad('e', 1148, 477, 'FFFFFF'); addAndroidPad('f', 1024, 477, 'FFFFFF'); addAndroidPad('g', 900, 477, 'FFFFFF'); addAndroidPad('s', 776, 477, 'FFFFFF'); addAndroidPad('v', 1148, 355, 'FFFFFF'); addAndroidPad('x', 1024, 355, 'FFFFFF'); addAndroidPad('y', 900, 355, 'FFFFFF'); addAndroidPad('z', 776, 355, 'FFFFFF'); elseif right:upper() == 'FULL' then addAndroidPad('a', 1148, 593, 'FFFFFF'); addAndroidPad('b', 1024, 593, 'FFFFFF'); addAndroidPad('c', 900, 593, 'FFFFFF'); addAndroidPad('d', 776, 593, 'FFFFFF'); addAndroidPad('e', 1148, 477, 'FFFFFF'); addAndroidPad('f', 1024, 477, 'FFFFFF'); addAndroidPad('g', 900, 477, 'FFFFFF'); addAndroidPad('s', 776, 477, 'FFFFFF'); elseif right:upper() == 'A_B_C' then addAndroidPad('a', 1148, 593, 'FFFFFF'); addAndroidPad('b', 1024, 593, 'FFFFFF'); addAndroidPad('c', 900, 593, 'FFFFFF'); elseif right:upper() == 'A_B_C_D' then addAndroidPad('a', 1148, 593, 'FFFFFF'); addAndroidPad('b', 1024, 593, 'FFFFFF'); addAndroidPad('c', 900, 593, 'FFFFFF'); addAndroidPad('d', 776, 593, 'FFFFFF'); elseif right:upper() == 'FUN' then addAndroidPad('a', 1155, 595, 'FFFFFF'); addAndroidPad('b', 1030, 595, 'FFFFFF'); addAndroidPad('c', 905, 595, 'FFFFFF'); addAndroidPad('d', 780, 595, 'FFFFFF'); addAndroidPad('e', 655, 595, 'FFFFFF'); addAndroidPad('f', 530, 595, 'FFFFFF'); addAndroidPad('g', 405, 595, 'FFFFFF'); addAndroidPad('h', 280, 595, 'FFFFFF'); addAndroidPad('i', 155, 595, 'FFFFFF'); addAndroidPad('j', 1155, 470, 'FFFFFF'); addAndroidPad('k', 1030, 470, 'FFFFFF'); addAndroidPad('l', 905, 470, 'FFFFFF'); addAndroidPad('m', 780, 470, 'FFFFFF'); addAndroidPad('n', 655, 470, 'FFFFFF'); addAndroidPad('o', 530, 470, 'FFFFFF'); addAndroidPad('p', 405, 470, 'FFFFFF'); addAndroidPad('q', 280, 470, 'FFFFFF'); addAndroidPad('r', 155, 470, 'FFFFFF'); addAndroidPad('s', 1155, 345, 'FFFFFF'); addAndroidPad('t', 1030, 345, 'FFFFFF'); addAndroidPad('u', 905, 345, 'FFFFFF'); addAndroidPad('v', 780, 345, 'FFFFFF'); addAndroidPad('w', 655, 345, 'FFFFFF'); addAndroidPad('x', 530, 345, 'FFFFFF'); addAndroidPad('y', 405, 345, 'FFFFFF'); addAndroidPad('z', 280, 345, 'FFFFFF'); addAndroidPad('one', 155, 345, 'FFFFFF'); addAndroidPad('two', 1155, 220, 'FFFFFF'); addAndroidPad('three', 1030, 220, 'FFFFFF'); addAndroidPad('four', 905, 220, 'FFFFFF'); addAndroidPad('five', 780, 220, 'FFFFFF'); addAndroidPad('six', 655, 220, 'FFFFFF'); addAndroidPad('seven', 530, 220, 'FFFFFF'); addAndroidPad('eight', 405, 220, 'FFFFFF'); addAndroidPad('nine', 280, 220, 'FFFFFF'); addAndroidPad('zero', 155, 220, 'FFFFFF'); addAndroidPad('frog', 577.5, 297.5, 'FFFFFF'); end end end
function addAndroidPad(name, x, y, color) makeAnimatedLuaSprite(name:lower()..'_AndroidPad', 'virtualpad/virtualpad', x, y); setObjectCamera(name:lower()..'_AndroidPad', 'other'); addLuaSprite(name:lower()..'_AndroidPad', true); addAnimationByPrefix(name:lower()..'_AndroidPad', 'normal', name:lower()..'1', 24, false); addAnimationByPrefix(name:lower()..'_AndroidPad', 'pressed', name:lower()..'2', 24, false); setProperty(name:lower()..'_AndroidPad.alpha', 0.7); setProperty(name:lower()..'_AndroidPad.color', getColorFromHex(color)); setObjCamera(name:lower()..'_AndroidPad', 'camVirtualPad'); table.insert(androidPad, name:lower()) end
function androidPadUpdate() for i = 1, #androidPad do if ((getMouseY('camOther') > getProperty(androidPad[i]..'_AndroidPad.y') and getMouseY('camOther') < getProperty(androidPad[i]..'_AndroidPad.y')+132) and (getMouseX('camOther') > getProperty(androidPad[i]..'_AndroidPad.x') and getMouseX('camOther') < getProperty(androidPad[i]..'_AndroidPad.x')+132) and mousePressed('left')) then playAnim(androidPad[i]..'_AndroidPad', 'pressed', true); else playAnim(androidPad[i]..'_AndroidPad', 'normal', true); end end end
function androidPadJustPress(name) return ((getMouseY('camOther') > getProperty(name:lower()..'_AndroidPad.y') and getMouseY('camOther') < getProperty(name:lower()..'_AndroidPad.y')+132) and (getMouseX('camOther') > getProperty(name:lower()..'_AndroidPad.x') and getMouseX('camOther') < getProperty(name:lower()..'_AndroidPad.x')+132) and mouseClicked('left')) end
function androidPadPress(name) return ((getMouseY('camOther') > getProperty(name:lower()..'_AndroidPad.y') and getMouseY('camOther') < getProperty(name:lower()..'_AndroidPad.y')+132) and (getMouseX('camOther') > getProperty(name:lower()..'_AndroidPad.x') and getMouseX('camOther') < getProperty(name:lower()..'_AndroidPad.x')+132) and mousePressed('left')) end
function removeVirtualPad() if #androidPad > 0 then for i = 1, #androidPad do if luaSpriteExists(androidPad[i]..'_AndroidPad') then removeLuaSprite(androidPad[i]..'_AndroidPad', true); end end end end