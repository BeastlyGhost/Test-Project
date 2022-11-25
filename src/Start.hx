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
	/*
		the Preferences Map sets up settings and default setting parameters
		it can be used alongside a menu for changing said paramaters to new ones
	 */
	public static var preferences:Map<String, Dynamic> = [
		//
		"Show Framerate" => true,
		"Show Memory" => true,
		"Show Objects" => false,
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

	/**
	 * [Saves your game preferences with "Ghost" as the save file name]
	 */
	public static function savePrefs()
	{
		FlxG.save.bind("Ghost");
		FlxG.save.data.preferences = preferences;
		// FlxG.save.data.flush();
	}

	/**
	 * [Loads your game preferences with "Ghost" as the save file name]
	 */
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

		triggerSplash(Main.game.skipSplash);
	}

	function triggerSplash(skip:Bool):Void
	{
		if (skip)
			return FlxG.switchState(cast Type.createInstance(Main.game.initialState, []));

		var bianca:FlxSprite = new FlxSprite().loadGraphic(Assets.getAsset("biancaSplash", IMAGE, "images/UI"));
		bianca.setGraphicSize(Std.int(bianca.width * 0.6));
		bianca.screenCenter(XY);
		bianca.x -= 20;
		add(bianca);

		FlxG.sound.play(Assets.getAsset("ui-splashRingSound", SOUND, "sounds"));

		FlxTween.tween(bianca, {alpha: 0}, 2, {
			onComplete: t ->
			{
				FlxG.switchState(cast Type.createInstance(Main.game.initialState, []));
			},
			ease: FlxEase.sineOut
		});
	}
}
