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
	public static var preferences:Map<String, Dynamic> = [
		//
		"Show Framerate" => false,
		"Show Memory" => true,
	];

	/**
	 * [Returns the specified preference from within the preferences map]
	 * @param name the `name` of your desired preference
	 * @return the default / current parameter for your preference
	 */
	public static function getPref(name:String)
	{
		if (preferences.exists(name))
			return preferences.get(name);
		//
		trace('Preference "$name" does not exist in the preferences map.');
		return null;
	}

	public static function savePrefs()
	{
		FlxG.save.bind("Ghost");
		FlxG.save.data.preferences = preferences;
		// FlxG.save.data.flush();
	}

	public static function loadPrefs()
	{
		FlxG.save.bind("Ghost");
		if (FlxG.save.data.preferences != null)
			preferences = FlxG.save.data.preferences;
	}

	override public function create()
	{
		super.create();

		loadPrefs();

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
