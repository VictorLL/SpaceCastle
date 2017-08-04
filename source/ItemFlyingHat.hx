package;

import flixel.FlxSprite;
import flixel.group.FlxGroup;

/**
 * @author galoyo
 */

class ItemFlyingHat extends FlxSprite 
{
	public function new(x:Float, y:Float) 
	{
		super(x, y);
		
		loadGraphic("assets/images/itemFlyingHat.png", false, Reg._tileSize, Reg._tileSize);
	
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	
}