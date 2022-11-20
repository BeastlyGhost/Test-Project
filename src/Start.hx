package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * Starting Class for the game
 * used to set up useful functions and variables for the main game!
 */
class Start extends FlxState
{
	override public function create()
	{
		super.create();

		FlxG.fixedTimestep = true;
		FlxG.mouse.useSystemCursor = true;
		FlxG.mouse.visible = false;

		triggerSplash();
	}

	function triggerSplash():Void
	{
		var bianca:FlxSprite = new FlxSprite().loadGraphic(Assets.getAsset("test-image", IMAGE, "images"));
		bianca.setGraphicSize(Std.int(bianca.width * 0.6));
		bianca.screenCenter(XY);
		bianca.x -= 20;
		add(bianca);

		FlxG.sound.play(Assets.getSound("test-sound", "sounds"));

		FlxTween.tween(bianca, {alpha: 0}, 2, {
			ease: FlxEase.sineOut,
			onComplete: t ->
			{
				FlxG.switchState(cast Type.createInstance(Main.initialState, []));
			}
		});
	}
}
