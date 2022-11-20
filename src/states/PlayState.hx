package states;

import flixel.FlxG;
import flixel.text.FlxText;

/**
 * Main Playable State, handles gameplay and visuals for the game;
 */
class PlayState extends ExtensibleState
{
	private var displayText:String = "Hello World!";

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
	}
}
