package states.menus;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.graphics.FlxGraphic;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import openfl.display.BlendMode;

class TitleState extends ScriptableState
{
	private var lockedMovement:Bool = false;

	private var enterText:FlxText;
	private var movingBack:FlxBackdrop;

	override function create()
	{
		super.create();

		var titleGrid:FlxGraphic = AssetHandler.grabAsset('titleGrid', IMAGE, 'images/menus');

		movingBack = new FlxBackdrop(titleGrid, XY, 0, 0);
		movingBack.alpha = 0.2;
		movingBack.velocity.set(30, 0);
		movingBack.blend = BlendMode.DIFFERENCE;
		add(movingBack);

		enterText = new FlxText(0, 0, 0, 'Press Enter to Begin', 32);
		enterText.screenCenter(XY);
		add(enterText);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.getPressEvent("accept") && !lockedMovement)
		{
			lockedMovement = true;
			FlxG.sound.play(AssetHandler.grabAsset("ui-changeSelection", SOUND, "sounds"));
			new FlxTimer().start(1, function(timer:FlxTimer)
			{
				ScriptableState.switchState(new MenuState());
			});
		}
	}
}
