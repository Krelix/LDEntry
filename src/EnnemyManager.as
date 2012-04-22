package  
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
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
		[Embed(source = "../resources/guard.png")] private var guardPNG:Class;
		[Embed(source = "../resources/londonBus.png")] private var busPNG:Class;
		[Embed(source = "../resources/russian1.png")] private var russianPNG:Class;
		[Embed(source = "../resources/danceuse.png")] private var dancerPNG:Class;
		
		private var ennemies:Vector.<Ennemy>;
		private var previousMouseState:Mouse;
		private var maxEnnemies:int;
		private var prevMapIndex:int;
		private var currentMapIndex:int;
		private var currentMapCounter: int;
		private var stress:uint;
		private var _parent:PlayState;
		
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
			for (i = 0 ; i < 2; i++)
			{
				var fr:Ennemy = new Ennemy(FlxG.random() * 300 + 700, FlxG.random() * FlxG.height / 2);
				fr.velocity.x = -(FlxG.random() * 50 + 70);
				fr.loadGraphic(frenchie1PNG, false, false, 17, 40, false);
				fr.addAnimation("idle", [0]);
				fr.addAnimation("death", [1, 2], 3, false);
				ennemies.push(fr);
			}
			for ( i = 0; i < 2; i++)
			{
				var fr2:Ennemy = new Ennemy(FlxG.random() * 300 + 700, FlxG.random() * FlxG.height / 2);
				fr2.loadGraphic(cyclistePNG, false, false, 42, 40, false);
				fr2.velocity.x = -(FlxG.random() * 50 + 70);
				fr2.addAnimation("idle", [0]);
				fr2.addAnimation("death", [1, 2], 3, false);
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
					if(!item.isDead)
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
						item.y + item.height > mouseY
						&& !item.isDead)
					{
						item.play("death", false);
					}
				}
			}
			ennemies.forEach(updateObject);
			if (resetIndex > -1)
			{
				ennemies[resetIndex].reset(500, FlxG.random() * FlxG.height / 2);
				ennemies[resetIndex].velocity.x = -(FlxG.random() * 50 + 70);
				ennemies[resetIndex].isDead = false;
				ennemies[resetIndex].play("idle", true);
				if (prevMapIndex != currentMapIndex)
				{
					switch(currentMapIndex)
					{
						case 1:
							if(resetIndex % 2 == 0)
								ennemies[resetIndex].loadGraphic(guardPNG, false, false, 13, 40);
							else
								ennemies[resetIndex].loadGraphic(busPNG, false, false, 42, 40 );
							break;
						default :
							if (resetIndex % 2 == 0)
							{
								ennemies[resetIndex].loadGraphic(frenchie1PNG, false, false, 17, 40);
							}
							else
							{
								ennemies[resetIndex].loadGraphic(cyclistePNG, false, false, 42, 40);
							}
					}
				}
			}
			if (currentMapCounter * 4 > ennemies.length)
			{
				for (var i:int; i < 4; i++)
				{
					var newEn:Ennemy = new Ennemy(500, FlxG.random() * FlxG.height / 2);
					newEn.velocity.x = -(FlxG.random() * 50 + 70);
					newEn.addAnimation("idle", [0]);
					newEn.addAnimation("death", [1, 2], 3, false);
					switch(currentMapIndex)
					{
						case 1:
							if (i % 2 == 0)
								newEn.loadGraphic(guardPNG, false, false, 13, 40);
							else
								newEn.loadGraphic(busPNG, false, false, 42, 40);
							break;
						default :
							if(i % 2 == 0)
								newEn.loadGraphic(frenchie1PNG, false, false, 17, 40);
							else
								newEn.loadGraphic(cyclistePNG, false, false, 42, 40);
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