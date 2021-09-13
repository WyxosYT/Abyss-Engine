package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxGroup.FlxTypedGroup;
import lime.app.Application;
import flixel.system.FlxSound;
import Data;

#if desktop
import Discord.DiscordClient;
#end

class SettingsMenu extends MusicBeatState
{
	var grpOptionsTexts:FlxTypedGroup<FlxText>;

	var buttonBG:FlxSprite;
	var middleButtonBG:FlxSprite;
	var rightButtonBG:FlxSprite;

	var menuName:FlxText;
	var gameplayCategory:FlxText;
	var customizeCategory:FlxText;
	var soundsCategory:FlxText;
	var abyss:FlxText;

	var gameplayButton:FlxButton;
	var customizeButton:FlxButton;
	var soundsButton:FlxButton;
	var backButton:FlxButton;
	var exitButton:FlxButton;

	var keybindsBG:FlxSprite;
	var keybindsTxt:FlxText;
	var openKB:FlxSprite;

	var gtappingBG:FlxSprite;
	var gtappingTxt:FlxText;
	var gtTrue:FlxButton;
	var gtFalse:FlxButton;

	#if android
	var pauseBG:FlxSprite;
	var pauseTxt:FlxText;
	var pauseTrue:FlxButton;
	var pauseFalse:FlxButton;
	#end

	var logoBG:FlxSprite;
	var logoTxt:FlxText;
	var logoFNF:FlxButton;
	var logoAbyss:FlxButton;
	var logoZombies:FlxButton;

	var nsBG:FlxSprite;
	var nsTxt:FlxText;
	var fnfNS:FlxButton;
	var circleNS:FlxButton;
	var triangleNS:FlxButton;

	var splashBG:FlxSprite;
	var splashTxt:FlxText;
	var splashTrue:FlxButton;
	var splashFalse:FlxButton;

	var bfBG:FlxSprite;
	var bfTxt:FlxText;
	var fnfBF:FlxButton;
	var dsidesBF:FlxButton;
	var genderswapGF:FlxButton;

	var gfBG:FlxSprite;
	var gfTxt:FlxText;
	var fnfGF:FlxButton;
	var dogeGF:FlxButton;
	var genderswapBF:FlxButton;

	var musicBG:FlxSprite;
	var musicTxt:FlxText;
	var freakyMusic:FlxButton;
	var damnedMusic:FlxButton;

	var hitsoundsBG:FlxSprite;
	var hitsoundsTxt:FlxText;
	var hitsoundsTrue:FlxButton;
	var hitsoundsFalse:FlxButton;

	var missBG:FlxSprite;
	var missTxt:FlxText;
	var	fnfMiss:FlxButton;
	var osuMiss:FlxButton;

	var data:Data = new Data();

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Settings Menu", null);
		#end

		FlxG.mouse.visible = true;

		if (!FlxG.sound.music.playing)
		{
			if (data.abyss.data.isfreakym)
			{
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}
			if (data.abyss.data.isdamnedm)
			{
				FlxG.sound.playMusic(Paths.music('damnedMenu'));
			}
			else
			{
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}
		}

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menu/weebBG', 'shared'));
		bg.setGraphicSize(Std.int(bg.width * 6));
		bg.screenCenter();
		add(bg);

		buttonBG = new FlxSprite(0, -100).makeGraphic(200, 1200);
		buttonBG.color = FlxColor.GRAY;
		buttonBG.alpha = 0.5;
		add(buttonBG);

		middleButtonBG = new FlxSprite(0, -100).makeGraphic(600, 1200);
		middleButtonBG.color = FlxColor.GRAY;
		middleButtonBG.alpha = 0.5;
		middleButtonBG.screenCenter(X);
		add(middleButtonBG);

		rightButtonBG = new FlxSprite(1115, -100).makeGraphic(200, 1200);
		rightButtonBG.color = FlxColor.GRAY;
		rightButtonBG.alpha = 0.5;
		add(rightButtonBG);

		keybindsBG = new FlxSprite(0, 120).makeGraphic(100, 50);
		keybindsBG.setGraphicSize(Std.int(keybindsBG.width * 2));
		keybindsBG.screenCenter(X);
		keybindsBG.color = FlxColor.BLACK;
		keybindsBG.alpha = 0.7;
		add(keybindsBG);

		keybindsTxt = new FlxText(0, 100, "Controls");
		keybindsTxt.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		keybindsTxt.screenCenter(X);
		add(keybindsTxt);

		openKB = new FlxButton(0, 40, "Open", function()
		{
			#if desktop
			openSubState(new KeyBindMenu());
			#end

			#if android
			FlxG.switchState(new android.CustomControlsState());
			#end
		});
		openKB.y += 100;
		openKB.x = 620;
		add(openKB);

		gtappingBG = new FlxSprite(0, 220).makeGraphic(100, 50);
		gtappingBG.setGraphicSize(Std.int(gtappingBG.width * 2));
		gtappingBG.screenCenter(X);
		gtappingBG.color = FlxColor.BLACK;
		gtappingBG.alpha = 0.7;
		add(gtappingBG);

		gtappingTxt = new FlxText(0, 200, "Ghost Tapping");
		gtappingTxt.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		gtappingTxt.screenCenter(X);
		add(gtappingTxt);

		gtTrue = new FlxButton(0, 40, "True", function()
		{
			data.abyss.data.isgtapping = true;
		});
		gtTrue.y += 200;
		gtTrue.x += 620;
		//gtTrue.screenCenter(X);
		add(gtTrue);

		gtFalse = new FlxButton(0, 40, "False", function()
		{
			data.abyss.data.isgtapping = false;
		});
		gtFalse.y += 220;
		gtFalse.x += 620;
		//gtFalse.screenCenter(X);
		add(gtFalse);

		#if android
		pauseBG = new FlxSprite(0, 320).makeGraphic(100, 50);
		pauseBG.setGraphicSize(Std.int(pauseBG.width * 2));
		pauseBG.screenCenter(X);
		pauseBG.color = FlxColor.BLACK;
		pauseBG.alpha = 0.7;
		add(pauseBG);

		pauseTxt = new FlxText(0, 300, "Pause Button");
		pauseTxt.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		pauseTxt.screenCenter(X);
		add(pauseTxt);

		pauseTrue = new FlxButton(0, 40, "True", function()
		{
			data.abyss.data.ispausebutton = true;
		});
		pauseTrue.y += 300;
		pauseTrue.x += 620;
		//pauseTrue.screenCenter(X);
		add(pauseTrue);

		pauseFalse = new FlxButton(0, 40, "False", function()
		{
			data.abyss.data.ispausebutton = false;
		});
		pauseFalse.y += 320;
		pauseFalse.x += 620;
		//pauseFalse.screenCenter(X);
		add(pauseFalse);
		#end

		logoBG = new FlxSprite(0, 120).makeGraphic(100, 50);
		logoBG.setGraphicSize(Std.int(logoBG.width * 2));
		logoBG.screenCenter(X);
		logoBG.color = FlxColor.BLACK;
		logoBG.alpha = 0.7;

		logoTxt = new FlxText(0, 100, "Logo");
		logoTxt.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		logoTxt.screenCenter(X);

		logoFNF = new FlxButton(0, 40, "FNF", function()
		{
			data.abyss.data.isfnflogo = true;
			data.abyss.data.isabysslogo = false;
			data.abyss.data.iszombieslogo = false;
		});
		logoFNF.y += 100;
		logoFNF.x += 620;
		//logoFNF.screenCenter(X);

		logoAbyss = new FlxButton(0, 40, "Abyss", function()
		{
			data.abyss.data.isabysslogo = true;
			data.abyss.data.isfnflogo = false;
			data.abyss.data.iszombieslogo = false;
		});
		logoAbyss.y += 120;
		logoAbyss.x += 620;
		//logoAbyss.screenCenter(X);

		logoZombies = new FlxButton(0, 40, "Zombies", function()
		{
			data.abyss.data.iszombieslogo = true;
			data.abyss.data.isfnflogo = false;
			data.abyss.data.isabysslogo = false;
		});
		logoZombies.y += 140;
		logoZombies.x += 620;
		//logoAbyss.screenCenter(X);

		nsBG = new FlxSprite(0, 220).makeGraphic(100, 50);
		nsBG.setGraphicSize(Std.int(nsBG.width * 2));
		nsBG.screenCenter(X);
		nsBG.color = FlxColor.BLACK;
		nsBG.alpha = 0.7;

		nsTxt = new FlxText(0, 200, "Noteskin");
		nsTxt.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		nsTxt.screenCenter(X);

		fnfNS = new FlxButton(0, 40, "FNF", function()
		{
			data.abyss.data.isfnfns = true;
			data.abyss.data.iscirclens = false;
			data.abyss.data.istrianglens = false;
		});
		fnfNS.y += 200;
		fnfNS.x += 620;
		//fnfNS.screenCenter(X);

		circleNS = new FlxButton(0, 40, "Circle", function()
		{
			data.abyss.data.iscirclens = true;
			data.abyss.data.isfnfns = false;
			data.abyss.data.istrianglens = false;
		});
		circleNS.y += 220;
		circleNS.x += 620;
		//circleNS.screenCenter(X);

		triangleNS = new FlxButton(0, 40, "Triangle", function()
		{
			data.abyss.data.istrianglens = true;
			data.abyss.data.isfnfns = false;
			data.abyss.data.iscirclens = false;
		});
		triangleNS.y += 240;
		triangleNS.x += 620;
		//triangleNS.screenCenter(X);

		splashBG = new FlxSprite(0, 320).makeGraphic(100, 50);
		splashBG.setGraphicSize(Std.int(splashBG.width * 2));
		splashBG.screenCenter(X);
		splashBG.color = FlxColor.BLACK;
		splashBG.alpha = 0.7;

		splashTxt = new FlxText(0, 300, "Notesplash");
		splashTxt.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		splashTxt.screenCenter(X);
		
		splashTrue = new FlxButton(0, 40, "True", function()
		{
			data.abyss.data.isnotesplash = true;
		});
		splashTrue.y += 300;
		splashTrue.x += 620;
		//splashTrue.screenCenter(X);

		splashFalse = new FlxButton(0, 40, "False", function()
		{
			data.abyss.data.isnotesplash = false;
		});
		splashFalse.y += 320;
		splashFalse.x += 620;
		//splashFalse.screenCenter(X);

		bfBG = new FlxSprite(0, 420).makeGraphic(100, 50);
		bfBG.setGraphicSize(Std.int(logoBG.width * 2));
		bfBG.screenCenter(X);
		bfBG.color = FlxColor.BLACK;
		bfBG.alpha = 0.7;

		bfTxt = new FlxText(0, 400, "Boyfriend");
		bfTxt.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		bfTxt.screenCenter(X);

		fnfBF = new FlxButton(0, 40, "FNF", function()
		{
			data.abyss.data.isfnfbf = true;
			data.abyss.data.isdsidesbf = false;
			data.abyss.data.isgenderswapgf = false;
		});
		fnfBF.y += 400;
		fnfBF.x += 620;
		//fnfBF.screenCenter(X);

		dsidesBF = new FlxButton(0, 40, "D-Sides", function()
		{
			data.abyss.data.isdsidesbf = true;
			data.abyss.data.isfnfbf = false;
			data.abyss.data.isgenderswapgf = false;
		});
		dsidesBF.y += 420;
		dsidesBF.x += 620;
		//dsidesBF.screenCenter(X);

		genderswapGF = new FlxButton(0, 40, "Genderswap GF", function()
		{
			data.abyss.data.isgenderswapgf = true;
			data.abyss.data.isfnfbf = false;
			data.abyss.data.isdsidesbf = false;
		});
		genderswapGF.y += 440;
		genderswapGF.x += 620;
		//genderswapGF.screenCenter(X);
		
		gfBG = new FlxSprite(0, 520).makeGraphic(100, 50);
		gfBG.setGraphicSize(Std.int(gfBG.width * 2));
		gfBG.screenCenter(X);
		gfBG.color = FlxColor.BLACK;
		gfBG.alpha = 0.7;

		gfTxt = new FlxText(0, 500, "Girlfriend");
		gfTxt.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		gfTxt.screenCenter(X);

		fnfGF = new FlxButton(0, 40, "FNF", function()
		{
			data.abyss.data.isfnfgf = true;
			data.abyss.data.isdogegf = false;
			data.abyss.data.isgenderswapbf = false;
		});
		fnfGF.y += 500;
		fnfGF.x += 620;
		//fnfGF.screenCenter(X);

		dogeGF = new FlxButton(0, 40, "Doge", function()
		{
			data.abyss.data.isdogegf = true;
			data.abyss.data.isfnfgf = false;
			data.abyss.data.isgenderswapbf = false;
		});
		dogeGF.y += 520;
		dogeGF.x += 620;
		//fnfGF.screenCenter(X);

		genderswapBF = new FlxButton(0, 40, "Genderswap BF", function()
		{
			data.abyss.data.isgenderswapbf = true;
			data.abyss.data.isfnfgf = false;
			data.abyss.data.isdogegf = false;
		});
		genderswapBF.y += 540;
		genderswapBF.x += 620;
		//genderswapBF.screenCenter(X);

		musicBG = new FlxSprite(0, 120).makeGraphic(100, 50);
		musicBG.setGraphicSize(Std.int(musicBG.width * 2));
		musicBG.screenCenter(X);
		musicBG.color = FlxColor.BLACK;
		musicBG.alpha = 0.7;

		musicTxt = new FlxText(0, 100, "Music");
		musicTxt.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		musicTxt.screenCenter(X);

		freakyMusic = new FlxButton(0, 40, "Freaky", function()
		{
			data.abyss.data.isfreakym = true;
			data.abyss.data.isdamnedm = false;
			FlxG.sound.music.stop();
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		});
		freakyMusic.y += 100;
		freakyMusic.x += 620;
		//freakyMusic.screenCenter(X);

		damnedMusic = new FlxButton(0, 40, "Damned", function()
		{
			data.abyss.data.isdamnedm = true;
			data.abyss.data.isfreakym = false;
			FlxG.sound.music.stop();
			FlxG.sound.playMusic(Paths.music('damnedMenu'));
		});
		damnedMusic.y += 120;
		damnedMusic.x += 620;
		//damnedMusic.screenCenter(X);

		hitsoundsBG = new FlxSprite(0, 220).makeGraphic(100, 50);
		hitsoundsBG.setGraphicSize(Std.int(hitsoundsBG.width * 2));
		hitsoundsBG.screenCenter(X);
		hitsoundsBG.color = FlxColor.BLACK;
		hitsoundsBG.alpha = 0.7;

		hitsoundsTxt = new FlxText(0, 200, "Hit Sounds");
		hitsoundsTxt.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		hitsoundsTxt.screenCenter(X);

		hitsoundsTrue = new FlxButton(0, 40, "True", function()
		{
			data.abyss.data.ishitsounds = true;
			var hitsound:FlxSound = new FlxSound().loadEmbedded(Paths.sound('hitsounds/osu', 'shared'));
			hitsound.volume = 0.5;
			hitsound.play();
		});
		hitsoundsTrue.y += 200;
		hitsoundsTrue.x += 620;
		//hitsoundsTrue.screenCenter(X);

		hitsoundsFalse = new FlxButton(0, 40, "False", function()
		{
			data.abyss.data.ishitsounds = false;
		});
		hitsoundsFalse.y += 220;
		hitsoundsFalse.x += 620;
		//hitsoundsFalse.screenCenter(X);

		missBG = new FlxSprite(0, 320).makeGraphic(100, 50);
		missBG.setGraphicSize(Std.int(missBG.width * 2));
		missBG.screenCenter(X);
		missBG.color = FlxColor.BLACK;
		missBG.alpha = 0.7;

		missTxt = new FlxText(0, 300, "Miss Sounds");
		missTxt.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		missTxt.screenCenter(X);

		fnfMiss = new FlxButton(0, 40, "FNF", function()
		{
			data.abyss.data.isfnfmiss = true;
			data.abyss.data.isosumiss = false;
			var fnfmiss:FlxSound = new FlxSound().loadEmbedded(Paths.sound('missnote1', 'shared'));
			fnfmiss.volume = 0.5;
			fnfmiss.play();
		});
		fnfMiss.y += 300;
		fnfMiss.x += 620;
		//fnfMiss.screenCenter(X);

		osuMiss = new FlxButton(0, 40, "Osu!", function()
		{
			data.abyss.data.isosumiss = true;
			data.abyss.data.isfnfmiss = false;
			var osumiss:FlxSound = new FlxSound().loadEmbedded(Paths.sound('misssounds/osu', 'shared'));
			osumiss.volume = 0.5;
			osumiss.play();
		});
		osuMiss.y += 320;
		osuMiss.x += 620;
		//osuMiss.screenCenter(X);

		menuName = new FlxText(0, 0, "Settings");
		menuName.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		menuName.screenCenter(X);
		add(menuName);

		gameplayCategory = new FlxText(0, 40, "Gameplay");
		gameplayCategory.setFormat("VCR OSD Mono", 50, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		gameplayCategory.screenCenter(X);
		gameplayCategory.alpha = 1;
		add(gameplayCategory);

		customizeCategory = new FlxText(0, 40, "Customize");
		customizeCategory.setFormat("VCR OSD Mono", 50, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		customizeCategory.screenCenter(X);
		customizeCategory.alpha = 0;
		add(customizeCategory);

		soundsCategory = new FlxText(0, 40, "Sounds & Music");
		soundsCategory.setFormat("VCR OSD Mono", 50, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		soundsCategory.screenCenter(X);
		soundsCategory.alpha = 0;
		add(soundsCategory);
		
		abyss = new FlxText(0, 700, "Abyss Engine - " + Application.current.meta.get('version'));
		abyss.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		abyss.screenCenter(X);
		add(abyss);

		gameplayButton = new FlxButton(50, 50, "");
		gameplayButton.loadGraphic(Paths.image('menu/gameplayButton', 'shared'));
		gameplayButton.setGraphicSize(Std.int(gameplayButton.width * 2));
		gameplayButton.color = FlxColor.GRAY;
		add(gameplayButton);

		customizeButton = new FlxButton(50, 250, "");
		customizeButton.loadGraphic(Paths.image('menu/customizeButton', 'shared'));
		customizeButton.setGraphicSize(Std.int(customizeButton.width * 2));
		add(customizeButton);

		soundsButton = new FlxButton(50, 450, "");
		soundsButton.loadGraphic(Paths.image('menu/soundsButton', 'shared'));
		soundsButton.setGraphicSize(Std.int(soundsButton.width * 2));
		add(soundsButton);

		backButton = new FlxButton(1165, 50, "");
		backButton.loadGraphic(Paths.image('menu/backButton', 'shared'));
		backButton.setGraphicSize(Std.int(backButton.width * 2));
		add(backButton);

		exitButton = new FlxButton(1165, 570, "");
		exitButton.loadGraphic(Paths.image('menu/exitButton', 'shared'));
		exitButton.setGraphicSize(Std.int(exitButton.width * 2));
		add(exitButton);

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (data.abyss.data.isgtapping)
		{
			gtTrue.color = FlxColor.LIME;
			gtFalse.color = FlxColor.WHITE;
		}
		else
		{
			gtFalse.color = FlxColor.LIME;
			gtTrue.color = FlxColor.WHITE;
		}

		#if android
		if (data.abyss.data.ispausebutton)
		{
			pauseTrue.color = FlxColor.LIME;
			pauseFalse.color = FlxColor.WHITE;
		}
		else
		{
			pauseFalse.color = FlxColor.LIME;
			pauseTrue.color = FlxColor.WHITE;
		}
		#end

		if (data.abyss.data.isfnflogo)
		{
			logoFNF.color = FlxColor.LIME;
			logoAbyss.color = FlxColor.WHITE;
			logoZombies.color = FlxColor.WHITE;
		}
		if (data.abyss.data.isabysslogo)
		{
			logoAbyss.color = FlxColor.LIME;
			logoFNF.color = FlxColor.WHITE;
			logoZombies.color = FlxColor.WHITE;
		}
		if (data.abyss.data.iszombieslogo)
		{
			logoZombies.color = FlxColor.LIME;
			logoFNF.color = FlxColor.WHITE;
			logoAbyss.color = FlxColor.WHITE;
		}

		if (data.abyss.data.isfnfbf)
		{
			fnfBF.color = FlxColor.LIME;
			dsidesBF.color = FlxColor.WHITE;
			genderswapGF.color = FlxColor.WHITE;
		}
		if (data.abyss.data.isdsidesbf)
		{
			dsidesBF.color = FlxColor.LIME;
			fnfBF.color = FlxColor.WHITE;
			genderswapGF.color = FlxColor.WHITE;
		}
		if (data.abyss.data.isgenderswapgf)
		{
			genderswapGF.color = FlxColor.LIME;
			fnfBF.color = FlxColor.WHITE;
			dsidesBF.color = FlxColor.WHITE;
		}

		if (data.abyss.data.isfnfns)
		{
			fnfNS.color = FlxColor.LIME;
			circleNS.color = FlxColor.WHITE;
			triangleNS.color = FlxColor.WHITE;
		}
		if (data.abyss.data.iscirclens)
		{
			circleNS.color = FlxColor.LIME;
			fnfNS.color = FlxColor.WHITE;
			triangleNS.color = FlxColor.WHITE;
		}
		if (data.abyss.data.istrianglens)
		{
			triangleNS.color = FlxColor.LIME;
			fnfNS.color = FlxColor.WHITE;
			circleNS.color = FlxColor.WHITE;
		}

		if (data.abyss.data.isnotesplash)
		{
			splashTrue.color = FlxColor.LIME;
			splashFalse.color = FlxColor.WHITE;
		}
		else
		{
			splashFalse.color = FlxColor.LIME;
			splashTrue.color = FlxColor.WHITE;
		}

		if (data.abyss.data.isfnfgf)
		{
			fnfGF.color = FlxColor.LIME;
			dogeGF.color = FlxColor.WHITE;
			genderswapBF.color = FlxColor.WHITE;
		}
		if (data.abyss.data.isdogegf)
		{
			dogeGF.color = FlxColor.LIME;
			fnfGF.color = FlxColor.WHITE;
			genderswapBF.color = FlxColor.WHITE;
		}
		if (data.abyss.data.isgenderswapbf)
		{
			genderswapBF.color = FlxColor.LIME;
			fnfGF.color = FlxColor.WHITE;
			dogeGF.color = FlxColor.WHITE;
		}

		if (data.abyss.data.isfreakym)
		{
			freakyMusic.color = FlxColor.LIME;
			damnedMusic.color = FlxColor.WHITE;
		}
		if (data.abyss.data.isdamnedm)
		{
			damnedMusic.color = FlxColor.LIME;
			freakyMusic.color = FlxColor.WHITE;
		}

		if (data.abyss.data.ishitsounds)
		{
			hitsoundsTrue.color = FlxColor.LIME;
			hitsoundsFalse.color = FlxColor.WHITE;
		}
		else
		{
			hitsoundsFalse.color = FlxColor.LIME;
			hitsoundsTrue.color = FlxColor.WHITE;
		}

		if (data.abyss.data.isfnfmiss)
		{
			fnfMiss.color = FlxColor.LIME;
			osuMiss.color = FlxColor.WHITE;
		}
		if (data.abyss.data.isosumiss)
		{
			osuMiss.color = FlxColor.LIME;
			fnfMiss.color = FlxColor.WHITE;
		}

		if (gameplayButton.justPressed)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			gameplayButton.color = FlxColor.GRAY;
			customizeButton.color = FlxColor.WHITE;
			soundsButton.color = FlxColor.WHITE;
			gameplayButton.setGraphicSize(Std.int(gameplayButton.width * 2));
			gameplayCategory.alpha = 1;
			customizeCategory.alpha = 0;
			soundsCategory.alpha = 0;
			add(keybindsBG);
			add(keybindsTxt);
			add(openKB);
			add(gtappingBG);
			add(gtappingTxt);
			add(gtTrue);
			add(gtFalse);
			#if android
			add(pauseBG);
			add(pauseTxt);
			add(pauseTrue);
			add(pauseFalse);
			#end
			remove(logoBG);
			remove(logoTxt);
			remove(logoFNF);
			remove(logoAbyss);
			remove(logoZombies);
			remove(nsBG);
			remove(nsTxt);
			remove(fnfNS);
			remove(circleNS);
			remove(triangleNS);
			remove(splashBG);
			remove(splashTxt);
			remove(splashTrue);
			remove(splashFalse);
			remove(bfBG);
			remove(bfTxt);
			remove(fnfBF);
			remove(dsidesBF);
			remove(genderswapGF);
			remove(gfBG);
			remove(gfTxt);
			remove(fnfGF);
			remove(dogeGF);
			remove(genderswapBF);
			remove(musicBG);
			remove(musicTxt);
			remove(freakyMusic);
			remove(damnedMusic);
			remove(hitsoundsBG);
			remove(hitsoundsTxt);
			remove(hitsoundsTrue);
			remove(hitsoundsFalse);
			remove(missBG);
			remove(missTxt);
			remove(fnfMiss);
			remove(osuMiss);
		}

		if (customizeButton.justPressed)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			customizeButton.color = FlxColor.GRAY;
			gameplayButton.color = FlxColor.WHITE;
			soundsButton.color = FlxColor.WHITE;
			customizeButton.setGraphicSize(Std.int(customizeButton.width * 2));
			customizeCategory.alpha = 1;
			gameplayCategory.alpha = 0;
			soundsCategory.alpha = 0;
			add(logoBG);
			add(logoTxt);
			add(logoFNF);
			add(logoAbyss);
			add(logoZombies);
			add(nsBG);
			add(nsTxt);
			add(fnfNS);
			add(circleNS);
			add(triangleNS);
			add(splashBG);
			add(splashTxt);
			add(splashTrue);
			add(splashFalse);
			add(bfBG);
			add(bfTxt);
			add(fnfBF);
			add(dsidesBF);
			add(genderswapGF);
			add(gfBG);
			add(gfTxt);
			add(fnfGF);
			add(dogeGF);
			add(genderswapBF);
			remove(keybindsBG);
			remove(keybindsTxt);
			remove(openKB);
			remove(gtappingBG);
			remove(gtappingTxt);
			remove(gtTrue);
			remove(gtFalse);
			#if android
			remove(pauseBG);
			remove(pauseTxt);
			remove(pauseTrue);
			remove(pauseFalse);
			#end
			remove(musicBG);
			remove(musicTxt);
			remove(freakyMusic);
			remove(damnedMusic);
			remove(hitsoundsBG);
			remove(hitsoundsTxt);
			remove(hitsoundsTrue);
			remove(hitsoundsFalse);
			remove(missBG);
			remove(missTxt);
			remove(fnfMiss);
			remove(osuMiss);
		}

		if (soundsButton.justPressed)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			soundsButton.color = FlxColor.GRAY;
			gameplayButton.color = FlxColor.WHITE;
			customizeButton.color = FlxColor.WHITE;
			soundsButton.setGraphicSize(Std.int(customizeButton.width * 2));
			soundsCategory.alpha = 1;
			gameplayCategory.alpha = 0;
			customizeCategory.alpha = 0;
			add(musicBG);
			add(musicTxt);
			add(freakyMusic);
			add(damnedMusic);
			add(hitsoundsBG);
			add(hitsoundsTxt);
			add(hitsoundsTrue);
			add(hitsoundsFalse);
			remove(keybindsBG);
			remove(keybindsTxt);
			remove(openKB);
			remove(gtappingBG);
			remove(gtappingTxt);
			remove(gtTrue);
			remove(gtFalse);
			#if android
			remove(pauseBG);
			remove(pauseTxt);
			remove(pauseTrue);
			remove(pauseFalse);
			#end
			remove(logoBG);
			remove(logoTxt);
			remove(logoFNF);
			remove(logoAbyss);
			remove(logoZombies);
			remove(nsBG);
			remove(nsTxt);
			remove(fnfNS);
			remove(circleNS);
			remove(triangleNS);
			remove(splashBG);
			remove(splashTxt);
			remove(splashTrue);
			remove(splashFalse);
			remove(bfBG);
			remove(bfTxt);
			remove(fnfBF);
			remove(dsidesBF);
			remove(genderswapGF);
			remove(gfBG);
			remove(gfTxt);
			remove(fnfGF);
			remove(dogeGF);
			remove(genderswapBF);
			add(missBG);
			add(missTxt);
			add(fnfMiss);
			add(osuMiss);
		}

		if (backButton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			backButton.color = FlxColor.GRAY;
			backButton.setGraphicSize(Std.int(backButton.width * 1.8));
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				backButton.color = FlxColor.WHITE;
				backButton.setGraphicSize(Std.int(backButton.width * 2));
				FlxG.switchState(new MenuState());
			});
		}

		if (exitButton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			exitButton.color = FlxColor.GRAY;
			exitButton.setGraphicSize(Std.int(exitButton.width * 1.8));
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				exitButton.color = FlxColor.WHITE;
				exitButton.setGraphicSize(Std.int(exitButton.width * 2));
				Sys.exit(0);
			});
		}

		super.update(elapsed);
	}
}