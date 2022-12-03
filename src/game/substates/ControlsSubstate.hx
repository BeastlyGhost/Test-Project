package game.substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import game.states.ScriptableState.ScriptableSubstate;

/**
	The Controls Substate, used for setting up custom keybinds for game actions and such
**/
class ControlsSubstate extends ScriptableSubstate
{
	var textGroup:FlxTypedGroup<FlxText>;
	var controlOptions:Array<String> = ["Nothing", "for now"];

	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		bg.scrollFactor.set();
		add(bg);

		textGroup = new FlxTypedGroup<FlxText>();
		add(textGroup);

		for (i in 0...controlOptions.length)
		{
			var option:FlxText = new FlxText(0, 70 + (i * 56), 0, controlOptions[i], 32);
			option.screenCenter(X);
			textGroup.add(option);
		}
	}

	override function update(elapsed:Float)
	{
		// if (Controls.getPressEvent("back"))
		if (FlxG.keys.justPressed.ANY)
			close();
	}
}
