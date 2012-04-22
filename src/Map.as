package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * Extension of FlxSprite to m
	 * @author Krelix
	 */
	public class Map extends FlxSprite 
	{
		private var count:uint;
		
		public function Map(_x:int = 0, _y:int=0 ) 
		{
			super(_x, _y)
			count = 1;
			velocity.x = -50;
		}
		
		public function setCount(c:int):void
		{
			count = c;
		}
		
		public function getCount():uint
		{
			return this.count;
		}
		
		override public function draw():void 
		{
			super.draw();
		}
	}

}