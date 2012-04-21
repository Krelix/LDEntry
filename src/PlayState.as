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
		[Embed(source = "../resources/background1.png")] private var bg1PNG:Class;
		[Embed(source = "../resources/background2.png")] private var bg2PNG:Class;
		[Embed(source = "../resources/cursor.png")] private var cursorPNG:Class;
		[Embed(source = "../resources/StressBarBack.png")] private var stressBarPNG:Class;
		[Embed(source = "../resources/StressText.png")] private var stressTextPNG:Class;
		private var level:FlxTilemap;
		private var rail:FlxSprite;
		private var bg1:FlxSprite;
		private var bg2:FlxSprite;
		private var stressBar:FlxSprite;
		private var stressText:FlxSprite;
		private var stressInside:FlxSprite;
		private var camera:FlxCamera;
		private var ennemies:FlxGroup;
		private var previousMouseState:Mouse;
		
		public function PlayState() 
		{
			rail = new FlxSprite();
			bg1 = new FlxSprite();
			bg2 = new FlxSprite();
			stressBar = new FlxSprite();
			stressText = new FlxSprite();
			stressInside = new FlxSprite();
			ennemies = new FlxGroup();
		}
		
		override public function create():void
		{
			super.create();
			FlxG.debug = true;
			FlxG.mouse.load(cursorPNG, 1, -24, -25);
			FlxG.mouse.show();
			// The first scrolling background.
			bg1.loadGraphic(bg1PNG, false, false, 480, 320);
			bg1.velocity.x = -50;
			add(bg1);

			// The second background
			bg2.loadGraphic(bg2PNG, false, false, 480, 320);
			// Place it after the first backgound.
			// Could probably use a group...
			// Or FlxScrollZone. Needs some refactoring anyway.
			bg2.x = bg1.width;
			bg2.y = 0;
			bg2.velocity.x = -50;
			add(bg2);
			
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
				ennemy.makeGraphic(10, 10, 0xFFFF8888);
				ennemy.x = FlxG.random() * (bg1.width / 2) + 100;
				ennemy.y = FlxG.random() * (bg1.height / 2);
				ennemy.velocity.x = -( FlxG.random() * 10 + 50);
				FlxG.log("ennemy " + i + " : " + ennemy.x + " " + ennemy.y);
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

			if (bg1.x <= -bg1.width)
				bg1.x = bg2.x + bg2.width;
			if (bg2.x <= -bg2.width)
				bg2.x = bg1.x + bg1.width;
				
			if (stressInside.scale.x < 64)
			{
				// Check if the mouse click 
				if (previousMouseState.justPressed() &&
					FlxG.mouse.pressed())
				{
					var mouseX:int = FlxG.mouse.screenX;
					var mouseY:int = FlxG.mouse.screenY;
					for (var key:String in ennemies.members)
					{
						var ennemy:FlxSprite = ennemies.members[key];
						if (ennemy.x < mouseX &&
							ennemy.x + ennemy.width > mouseX &&
							ennemy.y < mouseY &&
							ennemy.y + ennemy.height > mouseY)
							ennemy.kill();
					}
				}
			}
			else {
				
			}
			
			previousMouseState = FlxG.mouse;
		}
	}
}