package;

import flixel.FlxG;
import flixel.FlxState;

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

		FlxG.switchState(cast Type.createInstance(Main.initialState, []));
	}
}
