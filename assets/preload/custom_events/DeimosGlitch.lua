function onCreatePost()
initLuaShader("TvGlitch");
end
function onEvent(name, value1, value2)
	if name == 'DeimosGlitch' then
	
	makeLuaSprite('BgDeimos',nil,-1482, -2323);
	makeGraphic('BgDeimos', 3560, 3629, 'ff0000')
	setLuaSpriteScrollFactor('BgDeimos', 0.81, 0.9);
	setObjectOrder('BgDeimos', '0')
	addLuaSprite('BgDeimos', false)
	setSpriteShader("BgDeimos", "BgDeimos");
	
	makeLuaSprite("TvGlitch");
	makeGraphic("TvGlitch", screenWidth, screenHeight);
	setSpriteShader("TvGlitch", "TvGlitch");
	addHaxeLibrary("ShaderFilter", "openfl.filters");
	runHaxeCode('game.camGame.setFilters([new ShaderFilter(game.getLuaObject("TvGlitch").shader)]);');
	runTimer('DeimosGlitch', 0.2)
	end
end
function onUpdate()
setShaderFloat("BgDeimos", "iTime", os.clock())
setShaderFloat("TvGlitch", "iTime", os.clock())
end
function onTimerCompleted(tag, loops, loopsleft)
if tag == 'DeimosGlitch' then
runHaxeCode("game.camGame.setFilters();");
removeLuaSprite('BgDeimos', false)
end
end