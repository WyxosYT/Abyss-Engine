package;

#if desktop
import Discord.DiscordClient;
import sys.thread.Thread;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
#if desktop
import io.newgrounds.NG;
#end
import lime.app.Application;
import openfl.Assets;

using StringTools;

class TitleState extends MusicBeatState
{
	static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;

	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;

	var stepShit:Bool = true;

	var data:Data = new Data();

	override public function create():Void
	{
		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

		#if polymod
		polymod.Polymod.init({modRoot: "mods", dirs: ['introMod']});
		#end

		PlayerSettings.init();

		curWacky = FlxG.random.getObject(getIntroTextShit());

		// DEBUG BULLSHIT

		super.create();

		#if desktop
		NGio.noLogin(APIStuff.API);
		#end

		#if ng
		var ng:NGio = new NGio(APIStuff.API, APIStuff.EncKey);
		trace('NEWGROUNDS LOL');
		#end

		FlxG.save.bind('abyss', 'wyxos');

		Highscore.load();

		if (FlxG.save.data.weekUnlocked != null)
		{
			// FIX LATER!!!
			// WEEK UNLOCK PROGRESSION!!
			// StoryMenuState.weekUnlocked = FlxG.save.data.weekUnlocked;

			if (StoryMenuState.weekUnlocked.length < 4)
				StoryMenuState.weekUnlocked.insert(0, true);

			// QUICK PATCH OOPS!
			if (!StoryMenuState.weekUnlocked[0])
				StoryMenuState.weekUnlocked[0] = true;
		}

		#if FREEPLAY
		FlxG.switchState(new FreeplayState());
		#elseif CHARTING
		FlxG.switchState(new ChartingState());
		#else
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			startIntro();
		});
		#end

		#if desktop
		DiscordClient.initialize();
		
		Application.current.onExit.add (function (exitCode) {
			DiscordClient.shutdown();
		 });
		#end
	}

	var logoBl:FlxSprite;
	var gfDance:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;

	function startIntro()
	{
		if (!initialized)
		{
			var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));

			//transIn = FlxTransitionableState.defaultTransIn;
			//transOut = FlxTransitionableState.defaultTransOut;

			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('freakyMenu'));
			// FlxG.sound.list.add(music);
			// music.play();

			//FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);

			if (data.abyss.data.isfreakym)
			{
				FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			}
			if (data.abyss.data.isdamnedm)
			{
				FlxG.sound.playMusic(Paths.music('damnedMenu'), 0);
			}
			else
			{
				FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			}

			FlxG.sound.music.fadeIn(4, 0, 0.7);
		}

		Conductor.changeBPM(102);
		persistentUpdate = true;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		// bg.antialiasing = true;
		// bg.setGraphicSize(Std.int(bg.width * 0.6));
		// bg.updateHitbox();
		add(bg);

		if (data.abyss.data.isfnflogo)
		{
			logoBl = new FlxSprite(-150, -100);
			logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
			logoBl.antialiasing = true;
			logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
			logoBl.animation.play('bump');
			logoBl.updateHitbox();
			// logoBl.screenCenter();
			// logoBl.color = FlxColor.BLACK;
		}
		if (data.abyss.data.isabysslogo)
		{
			if (data.abyss.data.isabysslogo)
			{
				logoBl = new FlxSprite(-150, -100);
				logoBl.frames = Paths.getSparrowAtlas('abyssLogo');
				logoBl.antialiasing = true;
				logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
				logoBl.animation.play('bump');
				logoBl.updateHitbox();
				// logoBl.screenCenter();
				// logoBl.color = FlxColor.BLACK;
			}
		}
		if (data.abyss.data.iszombieslogo)
		{
			logoBl = new FlxSprite(0, -50).loadGraphic(Paths.image('zombiesLogo'));
			logoBl.setGraphicSize(Std.int(logoBl.width * 0.5));
			logoBl.antialiasing = true;
			logoBl.updateHitbox();
			// logoBl.screenCenter();
			// logoBl.color = FlxColor.BLACK;
		}

		gfDance = new FlxSprite(FlxG.width * 0.4, FlxG.height * 0.07);
		gfDance.frames = Paths.getSparrowAtlas('gfDanceTitle');
		gfDance.animation.addByIndices('danceLeft', 'gfDance', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		gfDance.animation.addByIndices('danceRight', 'gfDance', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		gfDance.antialiasing = true;
		add(gfDance);
		add(logoBl);

		titleText = new FlxSprite(100, FlxG.height * 0.8);
		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.antialiasing = true;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		// titleText.screenCenter(X);
		add(titleText);

		var logo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('logo'));
		logo.screenCenter();
		logo.antialiasing = true;
		// add(logo);

		// FlxTween.tween(logoBl, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		// FlxTween.tween(logo, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		credTextShit = new Alphabet(0, 0, "ninjamuffin99\nPhantomArcade\nkawaisprite\nevilsk8er", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		ngSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('newgrounds_logo'));
		add(ngSpr);
		ngSpr.visible = false;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.8));
		ngSpr.updateHitbox();
		ngSpr.screenCenter(X);
		ngSpr.antialiasing = true;

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		FlxG.mouse.visible = false;

		if (initialized)
			skipIntro();
		else
			initialized = true;

		// credGroup.add(credTextShit);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	function getFreakyText():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('freakyIntro'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	function getFreshText():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('freshIntro'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	function getDamnedText():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('damnedIntro'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}
	
	var transitioning:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}

		if (pressedEnter && !transitioning && skippedIntro)
		{
			#if desktop
			#if !switch
			NGio.unlockMedal(60960);

			// If it's Friday according to da clock
			if (Date.now().getDay() == 5)
				NGio.unlockMedal(61034);
			#end
			#end

			titleText.animation.play('press');

			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

			transitioning = true;
			// FlxG.sound.music.stop();

			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				FlxG.switchState(new MenuState());
			});
			// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
		}

		if (pressedEnter && !skippedIntro)
		{
			skipIntro();
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.screenCenter(X);
			money.y += (i * 60) + 200;
			credGroup.add(money);
			textGroup.add(money);
		}
	}

	function addMoreText(text:String)
	{
		var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
		coolText.screenCenter(X);
		coolText.y += (textGroup.length * 60) + 200;
		credGroup.add(coolText);
		textGroup.add(coolText);
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	override function beatHit()
	{
		super.beatHit();

		if (data.abyss.data.isfnflogo)
		{
			logoBl.animation.play('bump');
		}
		if (data.abyss.data.isabysslogo)
		{
			// nothin
		}
		if (data.abyss.data.iszombieslogo)
		{
			// nothin
		}
		danceLeft = !danceLeft;

		if (danceLeft)
			gfDance.animation.play('danceRight');
		else
			gfDance.animation.play('danceLeft');

		FlxG.log.add(curBeat);
		FlxG.log.add(curStep);

		trace(curStep);

		/*switch (curBeat)
		{
			case 3:
				deleteCoolText();
			// credTextShit.visible = false;
			// credTextShit.text = 'In association \nwith';
			// credTextShit.screenCenter();
			case 4:
				createCoolText(['The One And Only', 'Wyxos']);
			case 5:
				addMoreText('presents');
				ngSpr.visible = true;
			// credTextShit.text += '\nNewgrounds';
			case 6:
				deleteCoolText();
				ngSpr.visible = false;
			// credTextShit.visible = false;

			// credTextShit.text = 'Shoutouts Tom Fulp';
			// credTextShit.screenCenter();
			case 7:
				createCoolText([curWacky[0]]);
			// credTextShit.visible = true;
			case 8:
				addMoreText(curWacky[1]);
			// credTextShit.text += '\nlmao';
			case 9:
				deleteCoolText();
			// credTextShit.visible = false;
			// credTextShit.text = "Friday";
			// credTextShit.screenCenter();
			case 10:
				addMoreText('The');
			// credTextShit.visible = true;
			case 11:
				addMoreText('Abyss');
			// credTextShit.text += '\nNight';
			case 12:
				addMoreText('Engine'); // credTextShit.text += '\nFunkin';

			case 13:
				deleteCoolText();
				createCoolText(['GUR', 'NOLFF', 'RATVAR']);

			case 14:
				skipIntro();
		}*/
	}

	override function stepHit():Void
	{
		if (stepShit)
		{
			if (curStep % 5 == 0)
				beatHit();
		}
		else
		{
			// fix
		}

		super.stepHit();

		/*
		switch (curStep)
		{
			case 5:
				deleteCoolText();
			case 10:
				createCoolText(['The One And Only', 'Wyxos']);
			case 15:
				addMoreText('presents');
				ngSpr.visible = true;
			case 20:
				deleteCoolText();
				ngSpr.visible = false;
				createCoolText(['An engine', 'made for fun']);
			case 25:
				deleteCoolText();
				createCoolText([curWacky[0]]);
			case 30:
				addMoreText(curWacky[1]);
			case 35:
				deleteCoolText();
			case 40:
				addMoreText('The');
			case 45:
				addMoreText('Abyss');
			case 50:
				addMoreText('Engine');
			case 51:
				deleteCoolText();
				createCoolText(['Gur', 'Nolff', 'Ratvar']);
			case 52:
				deleteCoolText();
				createCoolText(['The', 'Abyss', 'Engine']);
			case 53:
				deleteCoolText();
				createCoolText(['Jlkbf', 'cerfragf', 'Gur Nolff Ratvar']);
			case 54:
				deleteCoolText();
				createCoolText(['Wyxos', 'presents', 'The Abyss Engine']);
			case 55:
				skipIntro();
		}*/

		switch (curStep)
		{
			case 5:
				deleteCoolText();
			case 10:
				createCoolText(['The One And Only', 'Wyxos']);
			case 15:
				addMoreText('presents');
			case 20:
				deleteCoolText();
				createCoolText(['An engine', 'made for fun']);
			case 23:
				ngSpr.visible = true;
				addMoreText('yeah');
			case 30:
				ngSpr.visible = false;
				deleteCoolText();
			case 35:
				deleteCoolText();
				createCoolText([curWacky[0]]);
			case 40:
				addMoreText(curWacky[1]);
			case 45:
				deleteCoolText();
			case 50:
				addMoreText('The');
			case 55:
				addMoreText('Abyss');
			case 60:
				addMoreText('Engine');
			case 65:
				skipIntro();
		}
	}

	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(ngSpr);

			FlxG.camera.flash(FlxColor.WHITE, 4);
			remove(credGroup);
			skippedIntro = true;
			stepShit = false;
		}
	}
}
