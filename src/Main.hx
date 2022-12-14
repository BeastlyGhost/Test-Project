package;

import base.FPS;
import flixel.FlxGame;
import flixel.FlxState;
import game.states.menus.TitleState;
import openfl.Lib;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var game = {
		width: 640, // the game window width
		height: 480, // the game window height
		zoom: -1.0, // defines the game's state bounds, -1.0 usually means automatic setup
		initialState: TitleState, // the game's initial state (shown after boot splash)
		framerate: 120, // the game's default framerate
		skipSplash: false, // whether the game boot splash should be skipped
		fullscreen: false, // whether the game should start at fullscreen
	};

	// specifies the current state
	public static var currentState:Class<FlxState> = TitleState;

	public static function main():Void
		Lib.current.addChild(new Main());

	public function new()
	{
		super();

		// initialize the game controls for later use;
		Controls.init();

		addChild(new FlxGame(game.width, game.height, Start, #if (flixel < "5.0.0") game.zoom, #end game.framerate, game.framerate, true, game.fullscreen));
		addChild(new FPS(0, 0));
	}
}
