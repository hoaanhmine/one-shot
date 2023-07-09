function onCreate()
	makeLuaSprite('sky', 'bg/deimos/sky',-1482, -2323)
	setLuaSpriteScrollFactor('sky', 0.81, 0.9);
	addLuaSprite('sky', false)

	makeLuaSprite('bg7', 'bg/deimos/bg 7',-1461,-2970)
	setLuaSpriteScrollFactor('bg7', 1, 1.5); 
	addLuaSprite('bg7', false)
	
	makeAnimatedLuaSprite('grunt', 'bg/deimos/grunt',685,-1305)
	addAnimationByPrefix('grunt', 'idle','grunt normal',24,false)
	addAnimationByPrefix('grunt', 'morido','grunt morido',24,true)
	setLuaSpriteScrollFactor('grunt', 1,0.91);
	addLuaSprite('grunt', false)
	
	makeLuaSprite('bg6', 'bg/deimos/bg 6',-687,-1545.22)
	setLuaSpriteScrollFactor('bg6', 1,0.91); 
	addLuaSprite('bg6', false)
	
	makeLuaSprite('bg5', 'bg/deimos/bg 5',-1475,-985)
	setLuaSpriteScrollFactor('bg5', 1,0.98); 
	addLuaSprite('bg5', false)
	
	makeAnimatedLuaSprite('agentAppear', 'bg/deimos/agent appear',133,-185)
	addAnimationByPrefix('agentAppear', 'idle','agent appear',24,false)
	scaleObject("agentAppear", 0.9, 0.9)
	setProperty('agentAppear.visible', false)
	addLuaSprite('agentAppear', false)
	
	makeAnimatedLuaSprite('gruntAppear', 'bg/deimos/gunt appear',-690,60)
	addAnimationByPrefix('gruntAppear', 'idle','grunt appear',24,false)
	scaleObject("gruntAppear", 0.85, 0.85)
	setProperty('gruntAppear.visible', false)
	addLuaSprite('gruntAppear', false)
	
	makeAnimatedLuaSprite('soldatAppear', 'bg/deimos/soldat appear',-451,-28)
	addAnimationByPrefix('soldatAppear', 'idle','soldat appear',24,false)
	scaleObject("soldatAppear", 0.85, 0.85)
	setProperty('soldatAppear.visible', false)
	addLuaSprite('soldatAppear', false)
	
	makeAnimatedLuaSprite('barricada', 'bg/deimos/barricada',328,-54)
	addAnimationByIndices('barricada', 'not','barricada appears',"0",24)
	addAnimationByPrefix('barricada', 'idle','barricada idle',24,true)
	addAnimationByPrefix('barricada', 'shot','barricada shot',24,false)
	addAnimationByPrefix('barricada', 'appears','barricada appears',24,false)
	addAnimationByPrefix('barricada', 'death','barricada death',24,false)
	scaleObject("barricada", 0.81, 0.81)
	addLuaSprite('barricada', false)
	
	makeAnimatedLuaSprite('barricada_hank', 'bg/deimos/barricada_hank',165, -205)
	addAnimationByPrefix('barricada_hank', 'idle','hank idle',24,true)
	addAnimationByPrefix('barricada_hank', 'chao','hank chao',24,false)
	addAnimationByPrefix('barricada_hank', 'intro','hank cameo intro',24,false)
	scaleObject("barricada_hank", 0.81, 0.81)
	setProperty('barricada_hank.visible', false)
	addLuaSprite('barricada_hank', false)
	
	makeLuaSprite('bg1', 'bg/deimos/bg 1',-1559,-210)
	--setLuaSpriteScrollFactor('bg1', 1,0.9); 
	addLuaSprite('bg1', false)
	
	makeLuaSprite('bg2', 'bg/deimos/bg2',-1575,30)
	setLuaSpriteScrollFactor('bg2', 1,0.78); 
	addLuaSprite('bg2', false)
	
	makeAnimatedLuaSprite('chains', 'bg/deimos/chains',-1734,-1835)
	addAnimationByPrefix('chains', 'idle','chains',24,false)
	setProperty('chains.visible', false)
	addLuaSprite('chains', true)
	makeAnimatedLuaSprite('final', 'bg/deimos/final',-1323,-644)
	addAnimationByPrefix('final', 'idle','cadenas',24,false)
	setProperty('final.visible', false)
	setObjectOrder('final', '100')
	addLuaSprite('final', true)
	
	
--close(true)
end
