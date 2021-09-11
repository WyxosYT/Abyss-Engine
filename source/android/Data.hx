package android;

import android.FlxVirtualPad;
import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.math.FlxPoint;

class Data{
	public var android:FlxSave;
	public function new(){
		android = new FlxSave();
		android.bind("data");
	}

	public function getcontrolmode():Int {
		// load control mode num from FlxSave
		if (android.data.buttonsmode != null) return android.data.buttonsmode[0];
		return 0;
	}

	public function setcontrolmode(mode:Int = 0):Int {
		// save control mode num from FlxSave
		if (android.data.buttonsmode == null) android.data.buttonsmode = new Array();
		android.data.buttonsmode[0] = mode;
		android.flush();

		return android.data.buttonsmode[0];
	}

	public function savecustom(_pad:FlxVirtualPad) {
		trace("saved");

		if (android.data.buttons == null)
		{
			android.data.buttons = new Array();

			for (buttons in _pad)
			{
				android.data.buttons.push(FlxPoint.get(buttons.x, buttons.y));
			}
		}else
		{
			var tempCount:Int = 0;
			for (buttons in _pad)
			{
				android.data.buttons[tempCount] = FlxPoint.get(buttons.x, buttons.y);
				tempCount++;
			}
		}
		android.flush();
	}

	public function loadcustom(_pad:FlxVirtualPad):FlxVirtualPad {
		//load pad
		if (android.data.buttons == null) return _pad;
		var tempCount:Int = 0;

		for(buttons in _pad)
		{
			buttons.x = android.data.buttons[tempCount].x;
			buttons.y = android.data.buttons[tempCount].y;
			tempCount++;
		}	
		return _pad;
	}

	public function flushData(){
		android.flush();
	}
	
}