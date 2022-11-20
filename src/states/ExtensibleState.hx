package states;

import flixel.FlxState;

/**
 * a State that is widely used by the other game states
 * it contains useful tools that can be used by every other state
 */
class ExtensibleState extends FlxState
{
	public var score:Int = 0;

	override public function create()
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
