package states;

import flixel.FlxState;
import flixel.FlxSubState;
import flixel.math.FlxMath;

/**
 * a State that is widely used by the other game states
 * it contains useful tools that can be used by every other state
 */
class ExtensibleState extends FlxState
{
	/*
		Defines the Current Selected Item on a State
	 */
	public var selection:Int = 0;

	/*
		Defines the `selection` limits
	 */
	public var wrappableGroup:Array<Dynamic> = [];

	override public function create()
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function updateSelection(newSelection:Int = 0)
	{
		selection = FlxMath.wrap(Math.floor(selection) + newSelection, 0, wrappableGroup.length - 1);
	}
}

class ExtensibleSubstate extends FlxSubState
{
	/*
		Defines the Current Selected Item on a State
	 */
	public var selection:Int = 0;

	/*
		Defines the `selection` limits
	 */
	public var wrappableGroup:Array<Dynamic> = [];

	override public function create()
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function updateSelection(newSelection:Int = 0)
	{
		selection = FlxMath.wrap(Math.floor(selection) + newSelection, 0, wrappableGroup.length - 1);
	}
}
