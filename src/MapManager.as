package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	
	/**
	 * ...
	 * @author Krelix
	 */
	public class MapManager extends FlxBasic
	{
		[Embed(source = "../resources/Paris.png")] private var parisPNG:Class;
		[Embed(source = "../resources/London.png")] private var londonPNG:Class;
		[Embed(source = "../resources/Moscow.png")] private var moscowPNG:Class;
		[Embed(source = "../resources/Tokyo.png")] private var tokyoPNG:Class;
		//[Embed(source = "../resources/background3.png")] private var bg3PNG:Class;
		private var listMap:Vector.<Map>;
		private var currentIndex:int;
		private static var MAP_WIDTH:int = 580;
		private var mapCount:int;
		
		public function MapManager() 
		{
			super();
			listMap = new Vector.<Map>();
		}
		
		public function init():void {
			currentIndex = 0;
			// Create a new Map with set velocity.
			var map:Map = new Map(MAP_WIDTH, 0);
			map.loadGraphic(parisPNG);
			listMap.push(map);
			// Create a second map, and set it's X to be right after the first one.
			map = new Map((listMap.length + 1) * MAP_WIDTH );
			map.loadGraphic(londonPNG);
			listMap.push(map);
			
			map = new Map((listMap.length + 1) * MAP_WIDTH );
			map.loadGraphic(moscowPNG);
			listMap.push(map);
			
			map = new Map((listMap.length + 1) * MAP_WIDTH );
			map.loadGraphic(tokyoPNG);
			listMap.push(map);
			/*map = new Map((listMap.length) * MAP_WIDTH + 1);
			map.loadGraphic(bg3PNG);
			listMap.push(map);*/
		}
		
		
		// Get the current background index for ennemy instantiation.
		public function getCurrentIndex():int
		{
			return currentIndex;
		}
		
		public function getMapCount():int
		{
			return mapCount;
		}
		
		override public function preUpdate():void 
		{
			super.preUpdate();
			var preUpdateObject:Function = function(item:Map, index:int, vector:Vector.<Map>):void {
				item.preUpdate();
			}
			listMap.forEach(preUpdateObject);
		}
		
		override public function update():void
		{
			super.update();
			var updateObject:Function = function(item:Map, index:int, vector:Vector.<Map>):void {
				
				if (item.x <= MAP_WIDTH / 2
					&& item.x >= MAP_WIDTH / 4)
				{
					currentIndex = index;
				}
				if (item.x <= -item.width) {
					mapCount++;
					item.x = (listMap.length - 1 ) * MAP_WIDTH;
				}
				item.update();
			}
			listMap.forEach(updateObject);
		}
		
		override public function postUpdate():void
		{
			super.postUpdate();
			var postUpdateObject:Function = function(item:Map, index:int, vector:Vector.<Map>):void {
				item.postUpdate();
			}
			listMap.forEach(postUpdateObject);
		}
		
		override public function draw():void
		{
			super.draw();
			var drawObject:Function = function(item:Map, index:int, vector:Vector.<Map>):void {
				item.draw();
			}
			listMap.forEach(drawObject);
		}
	}
}