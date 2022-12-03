package game.states.menus;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;

/**
	the Menu State serves as a base menu that will be expanded later on
	right now, it simply shows text options that do a specific action
	such as toggling the framerate counter, or setting your keybinds
**/
class MenuState extends ScriptableState
{
	var selector:FlxText;
	var textGroup:FlxTypedGroup<FlxText>;
	var menuOptions:Array<String> = [
		"Anti-aliasing",
		"Show Framerate",
		"Show Memory",
		"Show Debug",
		"Set Keybinds",
		"Save and Leave"
	];

	override function create()
	{
		super.create();

		// set the wrappable group to our options group
		wrappableGroup = menuOptions;

		selector = new FlxText(0, 0, 0, '>', 32);
		add(selector);

		textGroup = new FlxTypedGroup<FlxText>();
		add(textGroup);

		for (i in 0...menuOptions.length)
		{
			var option:FlxText = new FlxText(0, 70 + (i * 56), 0, menuOptions[i], 32);
			option.screenCenter(X);
			textGroup.add(option);
		}

		updateSelection();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.getPressEvent("down"))
			updateSelection(1);
		if (Controls.getPressEvent("up"))
			updateSelection(-1);

		if (Controls.getPressEvent("accept"))
		{
			switch (textGroup.members[selection].text)
			{
				case "Set Keybinds":
					openSubState(new game.substates.ControlsSubstate());
				case "Save and Leave":
					ScriptableState.switchState(new game.states.PlayState());
				default:
					Start.preferences.set(textGroup.members[selection].text, !Start.getPref(textGroup.members[selection].text));
					Start.updatePrefs();
			}
		}
	}

	override function updateSelection(newSelection:Int = 0)
	{
		super.updateSelection(newSelection);

		textGroup.forEach(function(button:FlxText)
		{
			button.color = 0xFFFFFFFF;
		});

		if (newSelection != 0)
			FlxG.sound.play(AssetHandler.grabAsset("ui-changeSelection", SOUND, "sounds"));

		var currentSelection:Int = 0;
		for (text in textGroup.members)
		{
			// pointer follows your selected item
			if (currentSelection == selection)
			{
				selector.x = text.x - 35;
				selector.y = text.y;
			}
			currentSelection++;
		}
	}
}
