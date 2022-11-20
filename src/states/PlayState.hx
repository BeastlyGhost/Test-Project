package states;

import flixel.FlxG;
import flixel.text.FlxText;

/**
 * Main Playable State, handles gameplay and visuals for the game;
 */
class PlayState extends ExtensibleState
{
	override public function create()
	{
		super.create();

		var text:FlxText = new FlxText(0, 0, 0, "Hello World", 32);
		text.screenCenter(XY);
		add(text);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.getPressEvent("accept"))
			trace("accept key");
	}
}
