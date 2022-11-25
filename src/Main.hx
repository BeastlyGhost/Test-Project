package;

import base.DebugInfo;
import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var game = {
		width: 640, // the game window width
		height: 480, // the game window height
		initialState: states.MenuState, // the game's initial state (shown after boot splash)
		framerate: 120, // the game's default framerate
		skipSplash: false, // whether the game boot splash should be skipped
		fullscreen: false, // whether the game should start at fullscreen
	};

	public static function main():Void
		Lib.current.addChild(new Main());

	public function new()
	{
		super();

		// initialize the game controls for later use;
		base.Controls.init();

		addChild(new FlxGame(game.width, game.height, Start, game.framerate, game.framerate, true, game.fullscreen));
		addChild(new DebugInfo(0, 0));
	}
}
