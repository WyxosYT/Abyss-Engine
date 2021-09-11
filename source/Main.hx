package;

import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;

class Main extends Sprite
{
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = TitleState; // The FlxState the game starts with.
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
	var data:Data = new Data();

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		
		#if android
		zoom = 1;
		gameWidth = 1280;
		gameHeight = 720;
		#end
		

		#if !debug
		initialState = TitleState;
		#end

		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));

		#if !mobile
		addChild(new FPS(10, 3, 0xFFFFFF));
		#end

		// FlxSave is weird, had to do this for it to work.

		// gameplay
		if (data.abyss.data.isgtapping == null){
			data.abyss.data.isgtapping = true;
		}

		// customization
		if (data.abyss.data.isfnflogo == null){
			data.abyss.data.isfnflogo = false;
		}
		if (data.abyss.data.isabysslogo == null){
			data.abyss.data.isabysslogo = true;
		}
		if (data.abyss.data.iszombieslogo == null){
			data.abyss.data.iszombieslogo = false;
		}

		if (data.abyss.data.isfnfns == null){
			data.abyss.data.isfnfns = true;
		}
		if (data.abyss.data.iscirclens == null){
			data.abyss.data.iscirclens = false;
		}
		if (data.abyss.data.istrianglens == null){
			data.abyss.data.istrianglens = false;
		}

		if (data.abyss.data.isnotesplash == null){
			data.abyss.data.isnotesplash = true;
		}

		if (data.abyss.data.isfnfbf == null){
			data.abyss.data.isfnfbf = true;
		}
		if (data.abyss.data.isdsidesbf == null){
			data.abyss.data.isdsidesbf = false;
		}
		if (data.abyss.data.isgenderswapgf == null){
			data.abyss.data.isgenderswapgf = false;
		}

		if (data.abyss.data.isfnfgf == null){
			data.abyss.data.isfnfgf = true;
		}
		if (data.abyss.data.isdogegf == null){
			data.abyss.data.isdogegf = false;
		}
		if (data.abyss.data.isgenderswapbf == null){
			data.abyss.data.isgenderswapbf = false;
		}

		// sounds & settings
		if (data.abyss.data.isfreakym == null){
			data.abyss.data.isfreakym = true;
		}
		if (data.abyss.data.isdamnedm == null){
			data.abyss.data.isdamnedm = false;
		}

		if (data.abyss.data.ishitsounds == null){
			data.abyss.data.ishitsounds = false;
		}

		if (data.abyss.data.isfnfmiss == null){
			data.abyss.data.isfnfmiss = true;
		}
		if (data.abyss.data.isosumiss == null){
			data.abyss.data.isosumiss = false;
		}
	}
}
