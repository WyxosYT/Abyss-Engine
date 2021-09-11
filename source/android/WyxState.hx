package android;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;

class WyxState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var bg:FlxSprite;

	var heyTxt:FlxText;
	var bugsTxt:FlxText;

	override function create()
	{
		super.create();
		// background
		bg = new FlxSprite();
		bg.loadGraphic(Paths.image('android/kid', 'shared'));
		bg.setGraphicSize(Std.int(bg.width * 1));
		bg.alpha = 0.5;
		bg.screenCenter(X);
		add(bg);
		heyTxt = new FlxText(0, 100, FlxG.width,
			"Hello!");
		heyTxt.setFormat(Paths.font("vcr.ttf"), 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		heyTxt.screenCenter(X);
		heyTxt.color = FlxColor.LIME;
		add(heyTxt);
		var txt:FlxText = new FlxText(0, 200, FlxG.width,
			"Thanks for downloading my engine ^^
			\nThis is still a very early version, version - " + Application.current.meta.get('version') + " to be exact"
			+"\nContact me on Discord, Wyxos#6294, or Youtube if you want to help!\nThanks for reading, and most importantly, Have a nice day :D", 24);
		txt.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		txt.screenCenter(X);
		add(txt);
		bugsTxt = new FlxText(0, 400, FlxG.width);
		#if desktop
		bugsTxt.text = "Bugs:\nKeybinds not saving.";
		#end
		#if android
		bugsTxt.text = "Bugs:\nButtons not working after pausing.";
		#end
		bugsTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		bugsTxt.screenCenter(X);
		bugsTxt.color = FlxColor.RED;
		add(bugsTxt);
		var grnTxt:FlxText = new FlxText(0, 600, FlxG.width);
		#if desktop
		grnTxt.text = "Press [ENTER] to go to Wyxos' Channel, or Press [ESCAPE] to play!";
		#end
		#if android
		grnTxt.text = "Press [ENTER] to go to Wyxos' Channel, or Press [BACK] to play!";
		#end
		grnTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		grnTxt.screenCenter(X);
		grnTxt.color = FlxColor.LIME;
		add(grnTxt);

		#if android
		addVirtualPad(NONE, A_B);
		#end
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			FlxG.openURL("https://youtube.com/wyxos");
		}
		if (controls.BACK)
		{
			leftState = true;
			FlxG.switchState(new MenuState());
		}
		super.update(elapsed);
	}
}
