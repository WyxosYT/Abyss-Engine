package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.math.FlxPoint;

class Data{
	public var abyss:FlxSave;

	public function new()
	{
		abyss = new FlxSave();
		abyss.bind("data");
	}

	public function startData()
	{
		// gameplay
		if (abyss.data.isgtapping == null){
			abyss.data.isgtapping = true;
		}

		// customization
		if (abyss.data.isfnflogo == null){
			abyss.data.isfnflogo = false;
		}
		if (abyss.data.isabysslogo == null){
			abyss.data.isabysslogo = true;
		}
		if (abyss.data.iszombieslogo == null){
			abyss.data.iszombieslogo = false;
		}

		if (abyss.data.isfnfns == null){
			abyss.data.isfnfns = true;
		}
		if (abyss.data.iscirclens == null){
			abyss.data.iscirclens = false;
		}
		if (abyss.data.istrianglens == null){
			abyss.data.istrianglens = false;
		}

		if (abyss.data.isnotesplash == null){
			abyss.data.isnotesplash = true;
		}

		if (abyss.data.isfnfbf == null){
			abyss.data.isfnfbf = true;
		}
		if (abyss.data.isdsidesbf == null){
			abyss.data.isdsidesbf = false;
		}
		if (abyss.data.isgenderswapgf == null){
			abyss.data.isgenderswapgf = false;
		}

		if (abyss.data.isfnfgf == null){
			abyss.data.isfnfgf = true;
		}
		if (abyss.data.isdogegf == null){
			abyss.data.isdogegf = false;
		}
		if (abyss.data.isgenderswapbf == null){
			abyss.data.isgenderswapbf = false;
		}

		// sounds & settings
		if (abyss.data.isfreakym == null){
			abyss.data.isfreakym = true;
		}
		if (abyss.data.isdamnedm == null){
			abyss.data.isdamnedm = false;
		}

		if (abyss.data.ishitsounds == null){
			abyss.data.ishitsounds = false;
		}

		if (abyss.data.isfnfmiss == null){
			abyss.data.isfnfmiss = true;
		}
		if (abyss.data.isosumiss == null){
			abyss.data.isosumiss = false;
		}
	}

	public function flushData(){
		abyss.flush();
	}
}