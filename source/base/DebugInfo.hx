package base;

import haxe.Timer;
import openfl.display.FPS;
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
	public var memoryPeak:UInt = 0;

	public function new(x:Float, y:Float)
	{
		super();

		this.x = x;
		this.y = y;

		autoSize = LEFT;
		selectable = false;

		defaultTextFormat = new TextFormat(Assets.getFont("vcr"), 12, -1);
		text = "";

		width = 150;
		height = 70;

		addEventListener(Event.ENTER_FRAME, update);
	}

	private function update(_:Event)
	{
		var now:Float = Timer.stamp();
		times.push(now);
		while (times[0] < now - 1)
			times.shift();

		var memory = System.totalMemory;
		if (memory > memoryPeak)
			memoryPeak = memory;

		if (visible)
			text = "FPS: " + times.length;
	}
}
