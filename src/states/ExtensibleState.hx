package states;

import flixel.FlxState;
import flixel.FlxSubState;

/**
 * a State that is widely used by the other game states
 * it contains useful tools that can be used by every other state
 */
class ExtensibleState extends FlxState
{
	// for selecting items on a menu;
	public var selection:Int = 0;

	override public function create()
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function updateSelection(newSelection:Int = 0)
		selection = newSelection;
}

class ExtensibleSubstate extends FlxSubState
{
	// for selecting items on a menu;
	public var selection:Int = 0;

	override public function create()
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function updateSelection(newSelection:Int = 0)
		selection = newSelection;
}
