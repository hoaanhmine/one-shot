function onCreate()
setProperty('skipCountdown', true)
	makeLuaSprite('wtf', '', 0, 0);
	makeGraphic('wtf',1280,720,'000000')
	addLuaSprite('wtf', true);
    scaleObject('wtf', 4, 4)
    setObjectCamera("wtf", 'other');
end
function onSongStart()
	doTweenAlpha('wtf', 'wtf', 0, 2.5, 'quadInOut');
end