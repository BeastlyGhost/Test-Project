package base;

import states.ExtensibleState.ExtensibleSubstate;

/**
 * Custom-made transition substate for transitioning from a class to another
 * based on this https://github.com/EyeDaleHim/CrowEngine/blob/dev/source/backend/Transitions.hx
**/
class Transition extends ExtensibleSubstate
{
	public var onEnd:Void->Void;

	public function new(speed:Null<Float>, transIn:Null<Bool>)
	{
		if (speed == null)
			speed = 0.6;
		if (transIn == null)
			transIn = true;

		// close for now
		close();

		super();
	}
}
