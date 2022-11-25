package states;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;

class MenuState extends ExtensibleState
{
	public var selector:FlxText;
	public var textGroup:FlxTypedGroup<FlxText>;
	public var menuOptions:Array<String> = ["Show Framerate", "Show Memory", "Show Objects", "Leave Settings"];

	override public function create()
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

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.getPressEvent("down"))
			updateSelection(1);
		if (Controls.getPressEvent("up"))
			updateSelection(-1);

		if (Controls.getPressEvent("accept"))
		{
			if (textGroup.members[selection].text == "Leave Settings")
				FlxG.switchState(new PlayState());
			else
				Start.preferences.set(textGroup.members[selection].text, !Start.getPref(textGroup.members[selection].text));
		}
	}

	override public function updateSelection(newSelection:Int = 0)
	{
		super.updateSelection(newSelection);

		textGroup.forEach(function(button:FlxText)
		{
			button.color = 0xFFFFFFFF;
		});

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
