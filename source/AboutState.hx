/*
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

class AboutState extends MusicBeatState
{
	var buttonBG:FlxSprite;
	var rightButtonBG:FlxSprite;
	var logoBl:FlxSprite;

	var menuName:FlxText;
	var abyss:FlxText;
	var credit:FlxText;

	var aboutButton:FlxButton;
	var backButton:FlxButton;
	var discordButton:FlxButton;
	var exitButton:FlxButton;

	var data:Data = new Data();

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the About Menu", null);
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

		logoBl = new FlxSprite(0, 400).loadGraphic(Paths.image('abyssLogo'));
		logoBl.setGraphicSize(Std.int(logoBl.width * 0.2));
		logoBl.antialiasing = true;
		logoBl.updateHitbox();
		logoBl.screenCenter(X);
		// logoBl.color = FlxColor.BLACK;
		add(logoBl);

		var txt:FlxText = new FlxText(0, 200, FlxG.width,
			"Thanks for downloading my engine ^^"
			+ "\nContact me on Discord, Wyxos#6294, if you want to help!\nThanks for reading, and most importantly, Have a nice day :D", 24);
		txt.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		txt.screenCenter(X);
		add(txt);
		var bugsTxt = new FlxText(0, 400, FlxG.width);
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

		buttonBG = new FlxSprite(0, -100).makeGraphic(200, 1000);
		buttonBG.color = FlxColor.GRAY;
		buttonBG.alpha = 0.5;
		add(buttonBG);

		rightButtonBG = new FlxSprite(1115, -100).makeGraphic(200, 1000);
		rightButtonBG.color = FlxColor.GRAY;
		rightButtonBG.alpha = 0.5;
		add(rightButtonBG);

		menuName = new FlxText(0, 0, "About");
		menuName.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		menuName.screenCenter(X);
		add(menuName);
		
		abyss = new FlxText(0, 700, "Abyss Engine - " + Application.current.meta.get('version'));
		abyss.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		abyss.screenCenter(X);
		add(abyss);

		credit = new FlxText(0, 600, "Made by - " + Application.current.meta.get('company'));
		credit.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credit.screenCenter(X);
		add(credit);

		aboutButton = new FlxButton(50, 50, "");
		aboutButton.loadGraphic(Paths.image('menu/aboutButton', 'shared'));
		aboutButton.setGraphicSize(Std.int(aboutButton.width * 2));
		add(aboutButton);

		backButton = new FlxButton(1165, 50, "");
		backButton.loadGraphic(Paths.image('menu/backButton', 'shared'));
		backButton.setGraphicSize(Std.int(backButton.width * 2));
		add(backButton);

		discordButton = new FlxButton(1165, 250, "");
		discordButton.loadGraphic(Paths.image('menu/discordButton', 'shared'));
		discordButton.setGraphicSize(Std.int(discordButton.width * 2));
		add(discordButton);

		exitButton = new FlxButton(1165, 570, "");
		exitButton.loadGraphic(Paths.image('menu/exitButton', 'shared'));
		exitButton.setGraphicSize(Std.int(exitButton.width * 2));
		add(exitButton);
		
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (aboutButton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			aboutButton.color = FlxColor.GRAY;
			aboutButton.setGraphicSize(Std.int(aboutButton.width * 1.8));
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				aboutButton.color = FlxColor.WHITE;
				aboutButton.setGraphicSize(Std.int(aboutButton.width * 2));
				// FlxG.switchState(new AboutState());
			});
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
*/