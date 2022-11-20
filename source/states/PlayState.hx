package states;

import flixel.FlxG;

/**
 * Main Playable State, handles gameplay and visuals for the game;
 */
class PlayState extends ExtensibleState
{
	override public function create()
	{
		super.create();

		FlxG.sound.play(Assets.getSound("test-sound", "sounds"));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.getPressEvent("accept"))
			trace("accept key");
	}
}
