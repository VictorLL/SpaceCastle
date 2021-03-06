package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.effects.chainable.FlxShakeEffect;
import flixel.util.FlxSpriteUtil;

/**
 * @author galoyo
 */

class ObjectSpikeFalling extends FlxSprite 
{
	public var ticksSpike:Int;
	private var ra:Int;

	private var _startY:Float;
	
	public function new(x:Float, y:Float) 
	{
		super(x, y);		
		
		loadGraphic("assets/images/objectSpikeFalling.png", true, 18, 54);
		
		animation.add("spikeFalled", [0,1,2,3,4], 40, false);			
		
		_startY = y;
		
		allowCollisions = FlxObject.FLOOR;
		ra = FlxG.random.int(-100, 100);
	}
	
	override public function update(elapsed:Float):Void 
	{		
		
		if (isOnScreen() == true)
		{
			
			// make the spike fall if spike is within the x range of the player.
			if (ticksSpike == 0 && Reg.state.player.x > x - ra && Reg.state.player.x < x + ra && y == _startY) velocity.y = 950 + (ra * 1.5);
			
			// spike not yet fallen to the ground.
			if (ticksSpike == 0)
			{
				// player and enemy damage taken, if spike hits them.
				if (FlxG.overlap(Reg.state.player, this))
				{
					Reg.state.player.hurt(3);		
					
				}
				FlxG.overlap(Reg.state.enemies, this, spikeFallingEnemy);
			}
		
			
			// stop the spike if collides with tilemap, then play the animation so that it appears that the spike is goes into the tilemap just a bit.
			if (y != _startY && justTouched(FlxObject.FLOOR))
			{
				
				if (ticksSpike == 0) 
				{ 
					// if spike collides with slope then set spike offset so that the bottom tip of the spike stops at the slope not above the slope.
					if ( Reg.state.overlays.getTile(Std.int(x / 32), Std.int(y / 32)) == 22
						|| Reg.state.overlays.getTile(Std.int(x / 32), Std.int(y / 32)) == 30
						|| Reg.state.overlays.getTile(Std.int(x / 32), Std.int(y / 32)) == 38 
						|| Reg.state.overlays.getTile(Std.int(x / 32), Std.int(y / 32)) == 46)
					{					
						offset.set(0, -20);
					}	
				
					velocity.y = 0;
					if (ticksSpike == 0) animation.play("spikeFalled"); 
					ticksSpike = 1; 
					alpha = 0.5;				
				}
			}
						
			super.update(elapsed);
		}
	}	
	
	// enemy hurt damage if hit by this spike
	private function spikeFallingEnemy(e:FlxSprite, s:FlxSprite):Void
	{
		if (FlxSpriteUtil.isFlickering(e) == false)
		{
			e.hurt(3);
		}
	}	
}