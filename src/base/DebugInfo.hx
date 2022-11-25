package base;

import haxe.Timer;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * Debug Info class for displaying Framerate and Memory information on screen;
 * based on this tutorial https://keyreal-code.github.io/haxecoder-tutorials/17_displaying_fps_and_memory_usage_using_openfl.html
 */
class DebugInfo extends TextField
{
	public var times:Array<Float> = [];
	public var memoryTotal:UInt = 0;

	public function new(x:Float, y:Float)
	{
		super();

		this.x = x;
		this.y = y;

		autoSize = LEFT;
		selectable = false;

		defaultTextFormat = new TextFormat(AssetHandler.grabAsset("vcr", FONT, "data/fonts"), 16, -1);
		text = "";

		width = 150;
		height = 70;

		addEventListener(Event.ENTER_FRAME, update);
	}

	static final intervalArray:Array<String> = ['B', 'KB', 'MB', 'GB', 'TB'];

	inline public static function getInterval(num:UInt):String
	{
		var size:Float = num;
		var data = 0;
		while (size > 1024 && data < intervalArray.length - 1)
		{
			data++;
			size = size / 1024;
		}

		size = Math.round(size * 100) / 100;
		return '$size ${intervalArray[data]}';
	}

	private function update(_:Event)
	{
		var now:Float = Timer.stamp();
		times.push(now);
		while (times[0] < now - 1)
			times.shift();

		var memory = System.totalMemory;
		if (memory > memoryTotal)
			memoryTotal = memory;

		if (visible)
		{
			text = ""
				+ (Start.getPref("Show Framerate") ? '${times.length} FPS\n' : '')
				+ (Start.getPref("Show Memory") ? '${getInterval(memory)} // ${getInterval(memoryTotal)}\n' : '')
				+ (Start.getPref("Show Objects") ? 'Class Object Count: ${flixel.FlxG.state.members.length}\n' : '');
		}
	}
}
