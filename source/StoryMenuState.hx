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
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;

#if desktop
import Discord.DiscordClient;
#end

class StoryMenuState extends MusicBeatState
{
	var scoreText:FlxText;

	var weekData:Array<Dynamic> = [
		['Tutorial'],
		['Bopeebo', 'Fresh', 'Dadbattle'],
		['Spookeez', 'South', "Monster"],
		['Pico', 'Philly', "Blammed"],
		['Satin-Panties', "High", "Milf"],
		['Cocoa', 'Eggnog', 'Winter-Horrorland'],
		['Senpai', 'Roses', 'Thorns']
	];
	var curDifficulty:Int = 1;

	public static var weekUnlocked:Array<Bool> = [true, true, true, true, true, true, true];

	var weekCharacters:Array<Dynamic> = [
		['dad', 'bf', 'gf'],
		['dad', 'bf', 'gf'],
		['spooky', 'bf', 'gf'],
		['pico', 'bf', 'gf'],
		['mom', 'bf', 'gf'],
		['parents-christmas', 'bf', 'gf'],
		['senpai', 'bf', 'gf']
	];

	var weekNames:Array<String> = [
		"",
		"Daddy Dearest",
		"Spooky Month",
		"PICO",
		"MOMMY MUST MURDER",
		"RED SNOW",
		"hating simulator ft. moawling"
	];


	var txtWeekTitle:FlxText;

	var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var buttonBG:FlxSprite;
	var rightButtonBG:FlxSprite;

	var menuName:FlxText;

	var storymodeButton:FlxButton;
	var backButton:FlxButton;
	var exitButton:FlxButton;

	var data:Data = new Data();

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Storymode Menu", null);
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

		scoreText = new FlxText(800, 50, "SCORE: 49324858", 32);
		scoreText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT);
		scoreText.alpha = 0.7;

		//txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle = new FlxText(200, 50, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		txtWeekTitle.alpha = 0.7;
		//txtWeekTitle.screenCenter(X);

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		var yellowBG:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 400, 0xFF800080);

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);
		
		var blackBarThingie:FlxSprite = new FlxSprite(0, -10).makeGraphic(FlxG.width, 100, FlxColor.BLACK);
		//blackBarThingie.alpha = 0.5;
		add(blackBarThingie);

		var blackBarThingie2:FlxSprite = new FlxSprite(0, 600).makeGraphic(FlxG.width, 200, FlxColor.BLACK);
		//blackBarThingie2.alpha = 0.5;
		add(blackBarThingie2);

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		for (i in 0...weekData.length)
		{
			var weekThing:MenuItem = new MenuItem(0, yellowBG.y + yellowBG.height + 10, i);
			weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			grpWeekText.add(weekThing);

			weekThing.screenCenter(X);
			weekThing.antialiasing = true;
			// weekThing.updateHitbox();

			// Needs an offset thingie
			if (!weekUnlocked[i])
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = true;
				grpLocks.add(lock);
			}
		}

		for (char in 0...3)
		{
			var weekCharacterThing:MenuCharacter = new MenuCharacter((FlxG.width * 0.25) * (1 + char) - 150, weekCharacters[curWeek][char]);
			weekCharacterThing.y += 70;
			weekCharacterThing.antialiasing = true;
			switch (weekCharacterThing.character)
			{
				case 'dad':
					weekCharacterThing.setGraphicSize(Std.int(weekCharacterThing.width * 0.5));
					weekCharacterThing.updateHitbox();
					//weekCharacterThing.screenCenter(X);
				case 'bf':
					weekCharacterThing.setGraphicSize(Std.int(weekCharacterThing.width * 0.9));
					weekCharacterThing.updateHitbox();
					weekCharacterThing.x += 220;
					//weekCharacterThing.x -= 2000;
				case 'gf':
					weekCharacterThing.setGraphicSize(Std.int(weekCharacterThing.width * 0.5));
					weekCharacterThing.updateHitbox();
					weekCharacterThing.x -= 2000;
				case 'parents-christmas':
					weekCharacterThing.setGraphicSize(Std.int(weekCharacterThing.width * 0.9));
					weekCharacterThing.updateHitbox();
			}

			grpWeekCharacters.add(weekCharacterThing);
		}

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);
		
		leftArrow = new FlxSprite(420, 620);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		difficultySelectors.add(leftArrow);

		sprDifficulty = new FlxSprite(580, 620);
		sprDifficulty.frames = ui_tex;
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.play('easy');
		//sprDifficulty.screenCenter(X);
		changeDifficulty();

		difficultySelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(850, 620);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		difficultySelectors.add(rightArrow);

		trace("Line 150");

		add(yellowBG);
		add(grpWeekCharacters);

		txtTracklist = new FlxText(400, 100, "Tracks", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFFe55777;
		add(txtTracklist);
		// add(rankText);
		add(scoreText);
		add(txtWeekTitle);

		buttonBG = new FlxSprite(0, -100).makeGraphic(200, 1000);
		buttonBG.color = FlxColor.GRAY;
		buttonBG.alpha = 0.5;
		add(buttonBG);

		rightButtonBG = new FlxSprite(1115, -100).makeGraphic(200, 1000);
		rightButtonBG.color = FlxColor.GRAY;
		rightButtonBG.alpha = 0.5;
		add(rightButtonBG);

		menuName = new FlxText(0, 0, "Story Mode Menu");
		menuName.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		menuName.screenCenter(X);
		add(menuName);

		storymodeButton = new FlxButton(50, 50, "");
		storymodeButton.loadGraphic(Paths.image('menu/storymodeButton', 'shared'));
		storymodeButton.setGraphicSize(Std.int(storymodeButton.width * 2));
		add(storymodeButton);

		backButton = new FlxButton(1165, 50, "");
		backButton.loadGraphic(Paths.image('menu/backButton', 'shared'));
		backButton.setGraphicSize(Std.int(backButton.width * 2));
		add(backButton);

		exitButton = new FlxButton(1165, 570, "");
		exitButton.loadGraphic(Paths.image('menu/exitButton', 'shared'));
		exitButton.setGraphicSize(Std.int(exitButton.width * 2));
		add(exitButton);

		updateText();

		#if android
		addVirtualPad(FULL, NONE);
		#end
		
		super.create();
	}

	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		scoreText.text = "SCORE:" + lerpScore;

		txtWeekTitle.text = weekNames[curWeek].toUpperCase();
		//txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		// FlxG.watch.addQuick('font', scoreText.font);

		difficultySelectors.visible = weekUnlocked[curWeek];

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
		});

		if (!movedBack)
		{
			if (!selectedWeek)
			{
				if (controls.UP_P)
				{
					changeWeek(-1);
				}

				if (controls.DOWN_P)
				{
					changeWeek(1);
				}
				
				if (controls.RIGHT)
					rightArrow.animation.play('press')
				else
					rightArrow.animation.play('idle');

				if (controls.LEFT)
					leftArrow.animation.play('press');
				else
					leftArrow.animation.play('idle');

				if (controls.RIGHT_P)
					changeDifficulty(1);
				if (controls.LEFT_P)
					changeDifficulty(-1);
			}
		}

		if (storymodeButton.justPressed)
		{
			selectWeek();
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

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (weekUnlocked[curWeek])
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				storymodeButton.color = FlxColor.GRAY;
				storymodeButton.setGraphicSize(Std.int(storymodeButton.width * 1.8));

				grpWeekText.members[curWeek].startFlashing();
				grpWeekCharacters.members[1].animation.play('bfConfirm');
				stopspamming = true;
			}

			PlayState.storyPlaylist = weekData[curWeek];
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = "";

			switch (curDifficulty)
			{
				case 0:
					diffic = '-easy';
				case 2:
					diffic = '-hard';
			}

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.storyWeek = curWeek;
			PlayState.campaignScore = 0;
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState(), true);
				storymodeButton.color = FlxColor.WHITE;
				storymodeButton.setGraphicSize(Std.int(storymodeButton.width * 2));
			});
		}
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		sprDifficulty.offset.x = 0;

		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('easy');
				sprDifficulty.offset.x = 20;
			case 1:
				sprDifficulty.animation.play('normal');
				sprDifficulty.offset.x = 70;
			case 2:
				sprDifficulty.animation.play('hard');
				sprDifficulty.offset.x = 20;
		}

		sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		sprDifficulty.y = leftArrow.y - 15;
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end

		FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= weekData.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = weekData.length - 1;

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && weekUnlocked[curWeek])
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		FlxG.sound.play(Paths.sound('scrollMenu'));

		updateText();
	}

	function updateText()
	{
		grpWeekCharacters.members[0].animation.play(weekCharacters[curWeek][0]);
		grpWeekCharacters.members[1].animation.play(weekCharacters[curWeek][1]);
		grpWeekCharacters.members[2].animation.play(weekCharacters[curWeek][2]);
		txtTracklist.text = "Tracks\n";

		switch (grpWeekCharacters.members[0].animation.curAnim.name)
		{
			case 'dad':
				grpWeekCharacters.members[0].offset.set(100, 200);
				grpWeekCharacters.members[0].setGraphicSize(Std.int(grpWeekCharacters.members[0].width * 0.8));
				grpWeekCharacters.members[0].flipX = false;

			case 'spooky':
				grpWeekCharacters.members[0].offset.set(100, 100);
				grpWeekCharacters.members[0].setGraphicSize(Std.int(grpWeekCharacters.members[0].width * 1));
				grpWeekCharacters.members[0].flipX = false;
			
			case 'pico':
				grpWeekCharacters.members[0].offset.set(100, 100);
				grpWeekCharacters.members[0].setGraphicSize(Std.int(grpWeekCharacters.members[0].width * 1));
				grpWeekCharacters.members[0].flipX = true;

			case 'mom':
				grpWeekCharacters.members[0].offset.set(100, 200);
				grpWeekCharacters.members[0].setGraphicSize(Std.int(grpWeekCharacters.members[0].width * 0.8));
				grpWeekCharacters.members[0].flipX = false;

			case 'parents-christmas':
				grpWeekCharacters.members[0].offset.set(100, 200);
				grpWeekCharacters.members[0].setGraphicSize(Std.int(grpWeekCharacters.members[0].width * 0.99));
				grpWeekCharacters.members[0].flipX = false;

			case 'senpai':
				grpWeekCharacters.members[0].offset.set(0, 50);
				grpWeekCharacters.members[0].setGraphicSize(Std.int(grpWeekCharacters.members[0].width * 0.99));
				grpWeekCharacters.members[0].flipX = false;

			default:
				grpWeekCharacters.members[0].offset.set(100, 100);
				grpWeekCharacters.members[0].setGraphicSize(Std.int(grpWeekCharacters.members[0].width * 1));
				// grpWeekCharacters.members[0].updateHitbox();
		}

		var stringThing:Array<String> = weekData[curWeek];

		for (i in stringThing)
		{
			txtTracklist.text += "\n" + i;
		}

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		//txtTracklist.x -= 300;

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end
	}
}