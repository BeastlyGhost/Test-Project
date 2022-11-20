package;

import base.DebugInfo;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Lib;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var initialState:Class<FlxState> = states.PlayState;

	public static function main():Void
		Lib.current.addChild(new Main());

	public function new()
	{
		super();

		// initialize the game controls for later use;
		base.Controls.init();

		addChild(new FlxGame(1280, 720, Start, 60));
		addChild(new DebugInfo(0, 0));
	}
}
