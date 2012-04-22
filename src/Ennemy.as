package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Krelix
	 */
	public class Ennemy extends FlxSprite 
	{
		public var isDead:Boolean;
		
		public function Ennemy(_x:int = 0, _y:int = 0)
		{
			super(_x, _y);
			isDead = false;
			addAnimationCallback(killIt);
		}
		
		public function killIt(s:String, frameNumer:uint, frameIndex:uint):void 
		{
			if(s == "death")
				isDead = true;
		}
		
	}

}