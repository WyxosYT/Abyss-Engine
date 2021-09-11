package;

import flixel.input.actions.FlxActionInput;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
#if android
import android.FlxVirtualPad;
#end

using StringTools;

/**
	*DEBUG MODE
 */
class AnimationDebug extends MusicBeatState
{
	var dad:Character;
	var dadBG:Character;
	//var char:Character;
	var textAnim:FlxText;
	var dumbTexts:FlxTypedGroup<FlxText>;
	var animList:Array<String> = [];
	var curAnim:Int = 0;
	var isDad:Bool = true;
	var daAnim:String = 'spooky';
	var camFollow:FlxObject;

	private var camHUD:FlxCamera;
	private var camGame:FlxCamera;

	var flippedChars:Array<String> = ["pico"];

	public function new(daAnim:String = 'spooky')
	{
		super();
		this.daAnim = daAnim;
	}

	override function create()
	{

		//openfl.Lib.current.stage.frameRate = 144;

		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);

		FlxCamera.defaultCameras = [camGame];

		FlxG.sound.music.stop();

		var gridBG:FlxSprite = FlxGridOverlay.create(10, 10);
		gridBG.scrollFactor.set(0.5, 0.5);
		add(gridBG);

		dad = new Character(0, 0, daAnim);
		dad.screenCenter();
		dad.debugMode = true;

		dadBG = new Character(0, 0, daAnim);
		dadBG.screenCenter();
		dadBG.debugMode = true;
		dadBG.alpha = 0.75;
		dadBG.color = 0xFF000000;

		add(dadBG);
		add(dad);

		dad.flipX = flippedChars.contains(dad.curCharacter);
		dadBG.flipX = flippedChars.contains(dadBG.curCharacter);

		dumbTexts = new FlxTypedGroup<FlxText>();
		add(dumbTexts);

		textAnim = new FlxText(300, 16);
		textAnim.size = 26;
		textAnim.scrollFactor.set(0);
		textAnim.cameras = [camHUD];
		add(textAnim);

		genBoyOffsets();

		camFollow = new FlxObject(0, 0, 2, 2);
		camFollow.screenCenter();
		add(camFollow);

		FlxG.camera.follow(camFollow);

		#if android
		addVirtualPad(FULL, A_B);
		#end

		super.create();
	}

	function genBoyOffsets(pushList:Bool = true):Void
	{
		var daLoop:Int = 0;

		for (anim => offsets in dad.animOffsets)
		{
			var text:FlxText = new FlxText(10, 20 + (18 * daLoop), 0, anim + ": " + offsets, 15);
			text.scrollFactor.set(0);
			text.color = FlxColor.BLUE;
			text.cameras = [camHUD];
			dumbTexts.add(text);

			if (pushList)
				animList.push(anim);

			daLoop++;
		}
	}

	function updateTexts():Void
	{
		dumbTexts.forEach(function(text:FlxText)
		{
			text.kill();
			dumbTexts.remove(text, true);
		});
	}

	override function update(elapsed:Float)
	{
		textAnim.text = dad.animation.curAnim.name;

		if (FlxG.keys.pressed.E)
			FlxG.camera.zoom += 0.0025;
		if (FlxG.keys.pressed.Q)
			FlxG.camera.zoom -= 0.0025;

		if (FlxG.keys.pressed.I || FlxG.keys.pressed.J || FlxG.keys.pressed.K || FlxG.keys.pressed.L)
		{
			if (FlxG.keys.pressed.I)
				camFollow.velocity.y = -150;
			else if (FlxG.keys.pressed.K)
				camFollow.velocity.y = 150;
			else
				camFollow.velocity.y = 0;

			if (FlxG.keys.pressed.J)
				camFollow.velocity.x = -150;
			else if (FlxG.keys.pressed.L)
				camFollow.velocity.x = 150;
			else
				camFollow.velocity.x = 0;
		}
		else
		{
			camFollow.velocity.set();
		}

		if (FlxG.keys.justPressed.W || controls.ACCEPT)
		{
			curAnim -= 1;
		}

		if (FlxG.keys.justPressed.S || controls.BACK)
		{
			curAnim += 1;
		}

		if (curAnim < 0)
			curAnim = animList.length - 1;

		if (curAnim >= animList.length)
			curAnim = 0;

		if (FlxG.keys.justPressed.S || controls.BACK || FlxG.keys.justPressed.W || controls.ACCEPT || FlxG.keys.justPressed.SPACE)
		{
			dad.playAnim(animList[curAnim], true);

			if(animList[curAnim].endsWith("miss"))
				dadBG.playAnim(animList[curAnim].substring(0, animList[curAnim].length - 4), true);
			else
				dadBG.playAnim("idle", true);

			updateTexts();
			genBoyOffsets(false);
		}
		
		if (FlxG.keys.justPressed.ESCAPE #if android || FlxG.android.justReleased.BACK #end)
		{
			FlxG.switchState(new PlayState());
		}

		var upP = FlxG.keys.anyJustPressed([UP]);
		var rightP = FlxG.keys.anyJustPressed([RIGHT]);
		var downP = FlxG.keys.anyJustPressed([DOWN]);
		var leftP = FlxG.keys.anyJustPressed([LEFT]);

		var holdShift = FlxG.keys.pressed.SHIFT;
		var multiplier = 1;
		if (holdShift)
			multiplier = 10;

		if (upP || controls.UP || rightP || controls.RIGHT || downP || controls.DOWN || leftP || controls.LEFT)
		{
			updateTexts();
			if (upP || controls.UP)
				dad.animOffsets.get(animList[curAnim])[1] += 1 * multiplier;
			if (downP || controls.DOWN)
				dad.animOffsets.get(animList[curAnim])[1] -= 1 * multiplier;
			if (leftP || controls.LEFT)
				dad.animOffsets.get(animList[curAnim])[0] += 1 * multiplier;
			if (rightP || controls.RIGHT)
				dad.animOffsets.get(animList[curAnim])[0] -= 1 * multiplier;
 
			updateTexts();
			genBoyOffsets(false);
			dad.playAnim(animList[curAnim]);
		}

		super.update(elapsed);
	}
}
