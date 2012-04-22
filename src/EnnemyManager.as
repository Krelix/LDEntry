package  
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.system.input.Mouse;
	
	/**
	 * ...
	 * @author Krelix
	 */
	public class EnnemyManager extends FlxBasic 
	{
		/**
		 * Add the sprites for every type of ennemies.
		 */
		[Embed(source = "../resources/frenchie1.png")] private var frenchie1PNG:Class;
		[Embed(source = "../resources/cycliste.png")] private var cyclistePNG:Class;
		[Embed(source = "../resources/russian1.png")] private var russianPNG:Class;
		[Embed(source = "../resources/danceuse.png")] private var dancerPNG:Class;
		
		private var ennemies:Vector.<Ennemy>;
		private var previousMouseState:Mouse;
		private var maxEnnemies:int;
		private var prevMapIndex:int;
		private var currentMapIndex:int;
		private var currentMapCounter: int;
		private var stress:uint;
		
		public function EnnemyManager() 
		{
			super();
			stress = 0;
			prevMapIndex = 0;
			maxEnnemies = 10;
			currentMapCounter = 0;
			ennemies = new Vector.<Ennemy>();			
		}
		
		public function init():void
		{
			previousMouseState = FlxG.mouse;
			var i:int = 0 ;
			// FOUND IT !!!!!!!!!!!!
			for (i = 0 ; i < 4; i++)
			{
				var fr:Ennemy = new Ennemy(500, FlxG.random() * FlxG.height / 2);
				fr.velocity.x = -(FlxG.random() * 50 + 70);
				fr.loadGraphic(frenchie1PNG,false, false, 17, 40, false);
				ennemies.push(fr);
			}
			for ( i = 0; i < 4; i++)
			{
				var fr2:Ennemy = new Ennemy(500, FlxG.random() * FlxG.height / 2);
				fr2.loadGraphic(cyclistePNG);
				FlxG.log("x : " + i +" " + fr2.x + " " + fr2.active );
				fr2.velocity.x = -(FlxG.random() * 50 + 70);
				ennemies.push(fr2);
			}
		}
		
		public function setCurrentMapCounter(count:int):void
		{
			currentMapCounter = count;
		}
		
		public function setCurrentMapIndex(index:int):void
		{
			currentMapIndex = index;
		}
		
		override public function preUpdate():void 
		{
			super.preUpdate();
			var preUpdateObject:Function = function(item:Ennemy, index:int, vector:Vector.<Ennemy>):void {
				item.preUpdate();
			}
			ennemies.forEach(preUpdateObject);
		}
		
		override public function update():void
		{
			var resetIndex:int = -1;
			super.update();
			var updateObject:Function = function(item:Ennemy, index:int, vector:Vector.<Ennemy>):void {
				item.update();
				var mouseX:int = FlxG.mouse.screenX;
				var mouseY:int = FlxG.mouse.screenY;
				
				// If the ennemy is no longer visible, we kill it
				if (item.x + item.width < 0 && item.exists) {
					stress += 5;
					resetIndex = index;
					item.kill();
				}
				// If the mouse has been clicked
				if (previousMouseState.justPressed() &&
					FlxG.mouse.pressed())
				{
					if (item.x < mouseX &&
						item.x + item.width > mouseX &&
						item.y < mouseY &&
						item.y + item.height > mouseY)
					{
						item.kill();
						resetIndex = index;
					}
				}
			}
			ennemies.forEach(updateObject);
			if (resetIndex > -1)
			{
				ennemies[resetIndex].reset(500, FlxG.random() * FlxG.height / 2);
				ennemies[resetIndex].velocity.x = -(FlxG.random() * 50 + 70);
				if (prevMapIndex != currentMapIndex)
				{
					FlxG.log(currentMapIndex);
					switch(currentMapIndex)
					{
						case 1:
							if(resetIndex % 2 == 0)
								ennemies[resetIndex].loadGraphic(russianPNG);
							else
								ennemies[resetIndex].loadGraphic(dancerPNG);
							break;
						default :
							if(resetIndex % 2 == 0)
								ennemies[resetIndex].loadGraphic(frenchie1PNG);
							else
								ennemies[resetIndex].loadGraphic(cyclistePNG);
					}
				}
			}
			if (currentMapCounter * 4 > ennemies.length)
			{
				for (var i:int; i < 4; i++)
				{
					var newEn:Ennemy = new Ennemy(500, FlxG.random() * FlxG.height / 2);
					newEn.velocity.x = -(FlxG.random() * 50 + 70);
					switch(currentMapIndex)
					{
						case 1:
							if(resetIndex % 2 == 0)
								newEn.loadGraphic(russianPNG);
							else
								newEn.loadGraphic(dancerPNG);
							break;
						default :
							if(resetIndex % 2 == 0)
								newEn.loadGraphic(frenchie1PNG);
							else
								newEn.loadGraphic(cyclistePNG);
					}
					ennemies.push(newEn);
				}
			}
			previousMouseState = FlxG.mouse;
		}
		
		override public function postUpdate():void
		{
			super.postUpdate();
			var postUpdateObject:Function = function(item:Ennemy, index:int, vector:Vector.<Ennemy>):void {
				item.postUpdate();
			}
			ennemies.forEach(postUpdateObject);
		}
		
		override public function draw():void
		{
			super.draw();
			var drawObject:Function = function(item:Ennemy, index:int, vector:Vector.<Ennemy>):void {
				item.draw();
			}
			ennemies.forEach(drawObject);
		}
		
		public function getStress():uint
		{
			return stress;
		}
		
	}

}