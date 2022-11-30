package base;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
	Custom-made transition substate for transitioning from a class to another,
	based on this https://github.com/EyeDaleHim/CrowEngine/blob/dev/source/backend/Transitions.hx
**/
class Transition
{
	public static function start(speed:Null<Float>, transIn:Null<Bool>, ?fadeEase:Null<EaseFunction>, ?onEnd:Void->Void)
	{
		if (speed == null)
			speed = 0.3;
		if (transIn == null)
			transIn = true;
		if (fadeEase == null)
			fadeEase = FlxEase.linear;

		var camTrans:FlxCamera = new FlxCamera();
		camTrans.bgColor = 0;
		FlxG.cameras.add(camTrans, false);

		var grpTrans:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
		grpTrans.cameras = [camTrans];
		FlxG.state.add(grpTrans);

		var bgSpr:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		bgSpr.alpha = (transIn ? 0 : 1);
		grpTrans.add(bgSpr);

		FlxTween.tween(bgSpr, {alpha: (transIn ? 1 : 0)}, speed, {
			onComplete: t ->
			{
				if (onEnd != null)
					onEnd();
			},
			ease: fadeEase
		});
	}
}
