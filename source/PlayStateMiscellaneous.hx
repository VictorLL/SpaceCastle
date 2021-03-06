package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

/**
 * ...
 * @author galoyo
 */
class PlayStateMiscellaneous
{
	// this function is called from other classes.
	public static function gameOver(?t:FlxTimer):Void
	{
		FlxG.switchState(new GameOver());
	}
	
	public static function winState(?t:FlxTimer):Void
	{
		FlxG.switchState(new WinState());
	}
	
	/**
	 * play a short music before playing the longer music.
	 */
	public static function playMusicIntro():Void
	{
		if (Reg._inHouse == "")
		{
			var _randomMusicNumber:Int = FlxG.random.int(20, 24); // random var for random music.

			if (Reg._musicEnabled == true)
			{
				if (FlxG.sound.music.playing == false)
				{
					if ( _randomMusicNumber == 20) 
						FlxG.sound.playMusic("20", 0.40, false);
					if ( _randomMusicNumber == 21) 
						FlxG.sound.playMusic("21", 0.40, false);
					if ( _randomMusicNumber == 22) 
						FlxG.sound.playMusic("22", 0.40, false);
					if ( _randomMusicNumber == 23) 
						FlxG.sound.playMusic("23", 0.40, false);
					if ( _randomMusicNumber == 24) 
						FlxG.sound.playMusic("24", 0.40, false);
				}
				
				FlxG.sound.music.persist = true;
			}
		}
	}
	
	/**
	 * Play a long 1 minute+ music.
	 */
	public static function playMusic():Void
	{
		// play random music.
		
		var _randomMusicNumber:Int = FlxG.random.int(1, 8); // random var for random music.

		if (Reg._musicEnabled == true)
		{
			if ( _randomMusicNumber == 1) 
			FlxG.sound.playMusic("1", 0.40, false);
			if ( _randomMusicNumber == 2) 
			FlxG.sound.playMusic("2", 0.40, false);
			if ( _randomMusicNumber == 3) 
			FlxG.sound.playMusic("3", 0.40, false);
			if ( _randomMusicNumber == 4) 
			FlxG.sound.playMusic("4", 0.40, false);
			if ( _randomMusicNumber == 5) 
			FlxG.sound.playMusic("5", 0.40, false);
			if ( _randomMusicNumber == 6) 
			FlxG.sound.playMusic("6", 0.40, false);
			if ( _randomMusicNumber == 7) 
			FlxG.sound.playMusic("7", 0.40, false);
			if ( _randomMusicNumber == 8) 
			FlxG.sound.playMusic("8", 0.40, false);
			
			FlxG.sound.music.persist = true;
		} 
		
	}
	
	/**
	 * leave the map and go to another map.
	 */
	public static function leaveMap(player:Player):Void
	{
		player.getCoords();
		Reg.beginningOfGame = false;
		
		// east door.
		if (Reg.playerXcoords > 13)
		{
			Reg.mapXcoords++; // used to change the map when player walks in a door.
		} 
				
		// north door.
		else if(Reg.playerYcoords < 7)
		{
			Reg.mapYcoords--;
		}
				
		// west door.
		else if(Reg.playerXcoords < 11)
		{
			Reg.mapXcoords--;
		}
				
		// south door.
		else if(Reg.playerYcoords > 9)
		{
			Reg.mapYcoords++;
		}

		Reg._dogOnMap = false;
		Reg._playerAirLeftInLungsCurrent = Reg._playerAirLeftInLungs;

		FlxG.switchState(new PlayState());
	}
	
	/**
	 * The guideline above the player head refers to the higher area that a jump can accur. The middle guideline refer to minimum player damage if player falls to that line, while the last line refers to player death.
	 */	
	public static function guidelines():Void
	{
		// the player will receive small health damage one tile below this line.
		Reg.state.warningFallLine = new FlxSprite(0, 0);
		Reg.state.warningFallLine.loadGraphic("assets/images/guideline.png", false);
		Reg.state.warningFallLine.visible = false;
		Reg.state.add(Reg.state.warningFallLine);
		
		// lets the player know where the death fall line is. feet touching this line is instant death.		
		Reg.state.deathFallLine = new FlxSprite(0, 0);
		Reg.state.deathFallLine.loadGraphic("assets/images/guideline.png", false);
		Reg.state.deathFallLine.visible = false;
		Reg.state.add(Reg.state.deathFallLine);
		
		// this line refers to a maximum height that the player is able to jump.
		Reg.state.maximumJumpLine = new FlxSprite(0, 0);
		Reg.state.maximumJumpLine.loadGraphic("assets/images/guideline.png", false);
		Reg.state.maximumJumpLine.visible = false;
		Reg.state.add(Reg.state.maximumJumpLine);

	}
}