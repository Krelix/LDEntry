package  
{
	import org.flixel.*;
	import org.flixel.system.debug.Log;
	import org.flixel.system.FlxTile;
	import org.flixel.system.input.Mouse;
	
	/**
	 * The game state, where the player is actually gonna play !
	 * @author Krelix
	 */
	public class PlayState extends FlxState
	{
		[Embed(source = "../resources/rail.png")] private var railPNG:Class;
		[Embed(source = "../resources/cursor.png")] private var cursorPNG:Class;
		[Embed(source = "../resources/StressBarBack.png")] private var stressBarPNG:Class;
		[Embed(source = "../resources/StressText.png")] private var stressTextPNG:Class;
		[Embed(source = "../resources/frenchie1.png")] private var frenchie1PNG:Class;
		private var level:FlxTilemap;
		private var rail:FlxSprite;
		private var stressBar:FlxSprite;
		private var stressText:FlxSprite;
		private var stressInside:FlxSprite;
		private var camera:FlxCamera;
		private var ennemies:FlxGroup;
		private var previousMouseState:Mouse;
		private var manager:MapManager;
		private var colors:Array;
		
		public function PlayState() 
		{
			rail = new FlxSprite();
			stressBar = new FlxSprite();
			stressText = new FlxSprite();
			stressInside = new FlxSprite();
			ennemies = new FlxGroup();
			manager = new MapManager();
			colors = new Array("0xFFFF0000");
			colors.push("0xFF00FF00");
			colors.push("0xFF0000FF");
			FlxG.log("colors : " + colors.length);
		}
		
		override public function create():void
		{
			super.create();
			FlxG.debug = true;
			FlxG.mouse.load(cursorPNG, 1, -24, -25);
			FlxG.mouse.show();
			
			// The backgrounds :
			add(manager);
			
			// The main character
			rail.loadGraphic(railPNG);
			rail.y = FlxG.height - rail.height;
			FlxG.worldBounds = new FlxRect(0, 0, FlxG.width, FlxG.height);
			FlxG.camera.setBounds(0, 0, FlxG.width, FlxG.height);
			FlxG.camera.follow(rail, FlxCamera.STYLE_LOCKON);
			add(rail);
			
			// A few ennemies
			//FlxG.globalSeed = 20;
			for (var i:int = 0; i < 5; i++)
			{
				var ennemy:FlxSprite = new FlxSprite();
				ennemy.loadGraphic(frenchie1PNG);
				ennemy.x = 500;
				ennemy.y = uint( Number(FlxG.height / 40) * FlxG.random()) * ennemy.height;
				FlxG.log(ennemy.y);
				ennemy.velocity.x = -( FlxG.random() * 20 + 70);
				ennemies.add(ennemy);
			}
			
			add(ennemies);
			
			// Stress Bar
			stressBar.loadGraphic(stressBarPNG);
			stressBar.x = FlxG.width - stressBar.width - 1;
			stressBar.y = FlxG.height - stressBar.height - 1;
			
			add(stressBar);
			
			stressText.loadGraphic(stressTextPNG);
			stressText.x = stressBar.x + 4;
			stressText.y = stressBar.y - 3;
			
			add(stressText);
			
			stressInside.makeGraphic(1, 8, 0xFFFF2222);
			stressInside.x = stressBar.x + 2;
			stressInside.y = stressBar.y + 2;
			stressInside.scrollFactor.x = stressInside.scrollFactor.y = 0;
			stressInside.origin.x = stressInside.origin.y = 0;
			stressInside.scale.x = 32;
			add(stressInside);
			
			previousMouseState = FlxG.mouse;
		}
		
		override public function update():void 
		{
			super.update();
				
			if (stressInside.scale.x < 64)
			{
				manager.update();
				var mouseX:int = FlxG.mouse.screenX;
				var mouseY:int = FlxG.mouse.screenY;
				
				for (var key:String in ennemies.members)
				{
					var ennemy:FlxSprite = ennemies.members[key];
					// If the ennemy is no longer visible, we kill it
					if (ennemy.x + ennemy.width < 0)
						ennemy.kill();
					// If the mouse has been clicked
					if (previousMouseState.justPressed() &&
						FlxG.mouse.pressed())
					{
						if (ennemy.x < mouseX &&
							ennemy.x + ennemy.width > mouseX &&
							ennemy.y < mouseY &&
							ennemy.y + ennemy.height > mouseY)
						{
							ennemy.kill();
						}
					}
				}
				var existsEnnemy:FlxSprite = ennemies.getFirstAvailable() as FlxSprite;
				if (existsEnnemy != null)
				{
					existsEnnemy.reset(500, FlxG.random() * FlxG.height / 2);
					existsEnnemy.velocity.x = -(FlxG.random() * 20 + 70);
					FlxG.log("CurrentIndex: " + manager.getCurrentIndex() + " " + colors[manager.getCurrentIndex()]);
					existsEnnemy.makeGraphic(10, 10, uint(colors[manager.getCurrentIndex()]) );
				}
			}
			else {
				
			}
			
			previousMouseState = FlxG.mouse;
		}
	}
}