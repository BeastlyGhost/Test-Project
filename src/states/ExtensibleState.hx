package states;

import base.Transition;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;

/**
 * a State that is widely used by the other game states
 * it contains useful tools that can be used by every other state
**/
class ExtensibleState extends FlxUIState
{
	/*
		Defines the Current Selected Item on a State
	**/
	public var selection:Int = 0;

	/*
		Defines the `selection` limits
	**/
	public var wrappableGroup:Array<Dynamic> = [];

	override public function create()
	{
		// clear assets cache
		AssetHandler.clear(true);

		// play the transition if we are allowed to
		if (!FlxTransitionableState.skipNextTransOut)
			Transition.start(0.3, false, FlxEase.linear);

		super.create();
	}

	public static function boundFramerate(input:Float)
		return input * (60 / FlxG.drawFramerate);

	public static function switchState(state:FlxState)
	{
		if (!FlxTransitionableState.skipNextTransIn)
		{
			Transition.start(0.3, true, FlxEase.linear, function()
			{
				FlxG.switchState(state);
				Main.currentState = Type.getClass(state);
			});
			return;
		}
		else
		{
			FlxTransitionableState.skipNextTransIn = false;
			FlxTransitionableState.skipNextTransOut = false;
			FlxG.switchState(state);
		}
	}

	public static function resetState(?skipTransition:Bool)
	{
		if (!skipTransition)
		{
			Transition.start(0.3, true, FlxEase.linear, function()
			{
				FlxG.resetState();
			});
			return;
		}
		else
			FlxG.resetState();
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
	public var selection:Int = 0;

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
