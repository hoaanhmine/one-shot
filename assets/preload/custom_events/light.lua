function onCreate()
precacheImage('bg/deimos/rayo')
end
function onEvent(name, value1, value2)
	if name == 'light' then
		initLuaShader("light");
		
		makeLuaSprite("temporaryShader");
		makeGraphic("temporaryShader", screenWidth, screenHeight);
		
		setSpriteShader("temporaryShader", "light");
		addHaxeLibrary("ShaderFilter", "openfl.filters");
		runHaxeCode([[
			trace(ShaderFilter);
			game.camGame.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
		]]);
		makeLuaSprite('red','empty',-100,-100)
		makeGraphic('red',1480,920,"ff0000")
		setObjectCamera('red','camHUD')
		setProperty('red.alpha',0.5)
		addLuaSprite('red',false)
		doTweenAlpha('red','red',0,0.3,'quadInOut')
		
		makeLuaSprite('black','empty',-100,-100)
		makeGraphic('black',1480,920,"000000")
		setObjectCamera('black','camHUD')
		setProperty('black.alpha',0)
		addLuaSprite('black',false)
		doTweenAlpha('black','black',1,1,'quadInOut')
		
	makeAnimatedLuaSprite('rayo', 'bg/deimos/rayo',-624,-1371)
	addAnimationByPrefix('rayo', 'ray','ray',24,false)
	objectPlayAnimation('rayo','ray',false)
	addLuaSprite('rayo', true)
	playSound("ray")
	runTimer('black', 1)
	runTimer('ray', 0.75)
    end
end
function onTimerCompleted(tag, loops, loopsleft)
if tag == 'black' then
doTweenAlpha('black','black',0,1,'quadInOut')
runHaxeCode([[
	trace(ShaderFilter);
	game.camGame.setFilters();
]]);
end
end