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
import lime.app.Application;

#if desktop
import Discord.DiscordClient;
#end

class MenuState extends MusicBeatState
{
	var buttonBG:FlxSprite;
	var rightButtonBG:FlxSprite;
	var logoBl:FlxSprite;

	var menuName:FlxText;
	var abyss:FlxText;

	var storymodeButton:FlxButton;
	var freeplayButton:FlxButton;
	var settingsButton:FlxButton;
	var discordButton:FlxButton;
	var aboutButton:FlxButton;
	var exitButton:FlxButton;

	var data:Data = new Data();

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Main Menu", null);
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
	
		if (data.abyss.data.isfnflogo)
		{
			logoBl = new FlxSprite();
			logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
			logoBl.antialiasing = true;
			logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
			logoBl.animation.play('bump');
			logoBl.updateHitbox();
			logoBl.screenCenter(X);
			// logoBl.color = FlxColor.BLACK;
			add(logoBl);
		}
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
		if (data.abyss.data.iszombieslogo)
		{
			logoBl = new FlxSprite().loadGraphic(Paths.image('zombiesLogo'));
			logoBl.setGraphicSize(Std.int(logoBl.width * 0.5));
			logoBl.antialiasing = true;
			logoBl.updateHitbox();
			logoBl.screenCenter(X);
			// logoBl.color = FlxColor.BLACK;
			add(logoBl);
		}

		buttonBG = new FlxSprite(0, -100).makeGraphic(200, 1000);
		buttonBG.color = FlxColor.GRAY;
		buttonBG.alpha = 0.5;
		add(buttonBG);

		rightButtonBG = new FlxSprite(1115, -100).makeGraphic(200, 1000);
		rightButtonBG.color = FlxColor.GRAY;
		rightButtonBG.alpha = 0.5;
		add(rightButtonBG);

		menuName = new FlxText(0, 0, "Main Menu");
		menuName.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		menuName.screenCenter(X);
		add(menuName);
		
		abyss = new FlxText(0, 700, "Abyss Engine - " + Application.current.meta.get('version'));
		abyss.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		abyss.screenCenter(X);
		add(abyss);

		storymodeButton = new FlxButton(50, 50, "");
		storymodeButton.loadGraphic(Paths.image('menu/storymodeButton', 'shared'));
		storymodeButton.setGraphicSize(Std.int(storymodeButton.width * 2));
		add(storymodeButton);

		freeplayButton = new FlxButton(50, 250, "");
		freeplayButton.loadGraphic(Paths.image('menu/freeplayButton', 'shared'));
		freeplayButton.setGraphicSize(Std.int(freeplayButton.width * 2));
		add(freeplayButton);

		settingsButton = new FlxButton(1165, 50, "");
		settingsButton.loadGraphic(Paths.image('menu/settingsButton', 'shared'));
		settingsButton.setGraphicSize(Std.int(settingsButton.width * 2));
		add(settingsButton);

		discordButton = new FlxButton(1165, 250, "");
		discordButton.loadGraphic(Paths.image('menu/discordButton', 'shared'));
		discordButton.setGraphicSize(Std.int(discordButton.width * 2));
		add(discordButton);

		aboutButton = new FlxButton(50, 570, "");
		aboutButton.loadGraphic(Paths.image('menu/aboutButton', 'shared'));
		aboutButton.setGraphicSize(Std.int(aboutButton.width * 2));
		add(aboutButton);

		exitButton = new FlxButton(1165, 570, "");
		exitButton.loadGraphic(Paths.image('menu/exitButton', 'shared'));
		exitButton.setGraphicSize(Std.int(exitButton.width * 2));
		add(exitButton);
		
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (storymodeButton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			storymodeButton.color = FlxColor.GRAY;
			storymodeButton.setGraphicSize(Std.int(storymodeButton.width * 1.8));
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				storymodeButton.color = FlxColor.WHITE;
				storymodeButton.setGraphicSize(Std.int(storymodeButton.width * 2));
				FlxG.switchState(new StoryMenuState());
			});
		}

		if (freeplayButton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			freeplayButton.color = FlxColor.GRAY;
			freeplayButton.setGraphicSize(Std.int(freeplayButton.width * 1.8));
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				freeplayButton.color = FlxColor.WHITE;
				freeplayButton.setGraphicSize(Std.int(freeplayButton.width * 2));
				FlxG.switchState(new FreeplayState());
			});
		}

		if (settingsButton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			settingsButton.color = FlxColor.GRAY;
			settingsButton.setGraphicSize(Std.int(settingsButton.width * 1.8));
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				settingsButton.color = FlxColor.WHITE;
				settingsButton.setGraphicSize(Std.int(settingsButton.width * 2));
				FlxG.switchState(new SettingsMenu());
			});
		}

		if (discordButton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			discordButton.color = FlxColor.GRAY;
			discordButton.setGraphicSize(Std.int(discordButton.width * 1.8));
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				discordButton.color = FlxColor.WHITE;
				discordButton.setGraphicSize(Std.int(discordButton.width * 2));
				FlxG.openURL('https://discord.gg/B6vBYc7Eyz');
			});
		}

		if (aboutButton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			aboutButton.color = FlxColor.GRAY;
			aboutButton.setGraphicSize(Std.int(aboutButton.width * 1.8));
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				aboutButton.color = FlxColor.WHITE;
				aboutButton.setGraphicSize(Std.int(aboutButton.width * 2));
				FlxG.openURL('https://github.com/WyxosYT/Abyss-Engine');
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