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
import flixel.math.FlxMath;
import flixel.group.FlxGroup.FlxTypedGroup;
import lime.app.Application;
import flixel.util.FlxAxes;
import flixel.group.FlxGroup;

#if desktop
import Discord.DiscordClient;
#end

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];
	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<HealthIcon> = [];

	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	var curSelected:Int = 0;
	var curDifficulty:Int = 1;
	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var buttonBG:FlxSprite;
	var rightButtonBG:FlxSprite;

	var menuName:FlxText;

	var playButton:FlxButton;
	var backButton:FlxButton;
	var exitButton:FlxButton;

	var data:Data = new Data();

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Freeplay Menu", null);
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

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));

		for (i in 0...initSonglist.length)
		{
			songs.push(new SongMetadata(initSonglist[i], 1, 'gf'));
		}

		if (StoryMenuState.weekUnlocked[2] || isDebug)
			addWeek(['Bopeebo', 'Fresh', 'Dadbattle'], 1, ['dad']);

		if (StoryMenuState.weekUnlocked[2] || isDebug)
			addWeek(['Spookeez', 'South', 'Monster'], 2, ['spooky']);

		if (StoryMenuState.weekUnlocked[3] || isDebug)
			addWeek(['Pico', 'Philly', 'Blammed'], 3, ['pico']);

		if (StoryMenuState.weekUnlocked[4] || isDebug)
			addWeek(['Satin-Panties', 'High', 'Milf'], 4, ['mom']);

		if (StoryMenuState.weekUnlocked[5] || isDebug)
			addWeek(['Cocoa', 'Eggnog', 'Winter-Horrorland'], 5, ['parents-christmas', 'parents-christmas', 'monster-christmas']);

		if (StoryMenuState.weekUnlocked[6] || isDebug)
			addWeek(['Senpai', 'Roses', 'Thorns'], 6, ['senpai', 'senpai', 'spirit']);

		addWeek(['CoconutMalled'], 0, ['dad']);

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menu/weebBG', 'shared'));
		bg.setGraphicSize(Std.int(bg.width * 6));
		bg.screenCenter();
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			songText.screenCenter(X); 
			grpSongs.add(songText);

			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

		var blackBarThingie:FlxSprite = new FlxSprite(0, -80).makeGraphic(FlxG.width, 200, FlxColor.BLACK);
		add(blackBarThingie);

		//scoreBG = new FlxSprite(0, 660).makeGraphic(915, 200);
		scoreBG = new FlxSprite(0, 600).makeGraphic(FlxG.width, 200, FlxColor.BLACK);
		add(scoreBG);

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		
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

		scoreText = new FlxText(200, 50, "", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		//scoreText.screenCenter(X);
		add(scoreText);

		buttonBG = new FlxSprite(0, -100).makeGraphic(200, 1200);
		buttonBG.color = FlxColor.GRAY;
		buttonBG.alpha = 0.5;
		add(buttonBG);

		rightButtonBG = new FlxSprite(1115, -100).makeGraphic(200, 1200);
		rightButtonBG.color = FlxColor.GRAY;
		rightButtonBG.alpha = 0.5;
		add(rightButtonBG);

		menuName = new FlxText(0, 0, "Free Play Menu");
		menuName.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		menuName.screenCenter(X);
		add(menuName);

		playButton = new FlxButton(50, 50, "");
		playButton.loadGraphic(Paths.image('menu/freeplayButton', 'shared'));
		playButton.setGraphicSize(Std.int(playButton.width * 2));
		add(playButton);

		backButton = new FlxButton(1165, 50, "");
		backButton.loadGraphic(Paths.image('menu/backButton', 'shared'));
		backButton.setGraphicSize(Std.int(backButton.width * 2));
		add(backButton);

		exitButton = new FlxButton(1165, 570, "");
		exitButton.loadGraphic(Paths.image('menu/exitButton', 'shared'));
		exitButton.setGraphicSize(Std.int(exitButton.width * 2));
		add(exitButton);

		changeSelection();
		changeDifficulty();
		
		#if android
		addVirtualPad(FULL, NONE);
		#end

		super.create();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter));
	}

	public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);

			if (songCharacters.length != 1)
				num++;
		}
	}
	
	override function update(elapsed:Float)
	{
		var upP = controls.UP_P;
		var downP = controls.DOWN_P;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.LEFT)
			leftArrow.animation.play('press');
		else
			leftArrow.animation.play('idle');
		if (controls.RIGHT)
			rightArrow.animation.play('press')
		else
			rightArrow.animation.play('idle');

		if (controls.RIGHT_P)
			changeDifficulty(1);
		if (controls.LEFT_P)
			changeDifficulty(-1);

		if (playButton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			playButton.color = FlxColor.GRAY;
			playButton.setGraphicSize(Std.int(playButton.width * 1.8));
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				playButton.color = FlxColor.WHITE;
				playButton.setGraphicSize(Std.int(playButton.width * 2));
				var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);

				trace(poop);
	
				PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = curDifficulty;
	
				PlayState.storyWeek = songs[curSelected].week;
				trace('CUR WEEK' + PlayState.storyWeek);
				LoadingState.loadAndSwitchState(new PlayState());
			});
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.4));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "SCORE:" + lerpScore;

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
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		#end

		FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07);
	}

	function changeSelection(change:Int = 0)
	{
		#if desktop
		#if !switch
		NGio.logEvent('Fresh');
		#end
		#end

		// NGio.logEvent('Fresh');
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		// lerpScore = 0;
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";

	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
	}
}
