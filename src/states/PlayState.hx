package states;

import flixel.FlxG;
import flixel.text.FlxText;

/**
 * Main Playable State, handles gameplay and visuals for the game;
 */
class PlayState extends ExtensibleState
{
	private var displayText:String = "Press 1 to Toggle FPS Counter\nPress 2 to Toggle Memory Counter\n\nthose preferences should be saved.";

	override public function create()
	{
		super.create();

		var text:FlxText = new FlxText(0, 0, 0, displayText, 32);
		text.screenCenter(XY);
		add(text);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ONE)
		{
			Start.preferences.set("Show Framerate", !Start.getPref("Show Framerate"));
			Start.savePrefs();
		}

		if (FlxG.keys.justPressed.TWO)
		{
			Start.preferences.set("Show Memory", !Start.getPref("Show Memory"));
			Start.savePrefs();
		}
	}
}
