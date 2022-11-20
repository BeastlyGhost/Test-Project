package states;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

class MenuState extends ExtensibleState
{
	public var textGroup:FlxTypedGroup<FlxText>;
	public var menuOptions:Array<String> = ["Show Framerate", "Show Memory", "Leave Settings"];

	override public function create()
	{
		super.create();

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

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.getPressEvent("down"))
			updateSelection(selection - 1);
		if (Controls.getPressEvent("up"))
			updateSelection(selection + 1);

		if (Controls.getPressEvent("accept"))
		{
			if (textGroup.members[selection].text == "Leave Settings")
				FlxG.switchState(new PlayState());
			else
			{
				trace("String: " + textGroup.members[selection].text);
				Start.preferences.set(textGroup.members[selection].text, !Start.getPref(textGroup.members[selection].text));
			}
		}
	}

	override public function updateSelection(newSelection:Int = 0)
	{
		super.updateSelection(newSelection);

		textGroup.forEach(function(button:FlxText)
		{
			button.color = 0xFFFFFFFF;
		});

		if (selection >= menuOptions.length)
			selection = 0;
		if (selection < 0)
			selection = menuOptions.length - 1;
	}
}
