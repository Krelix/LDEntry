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
		[Embed(source = "../resources/mainChar.png")] private var charPNG:Class;
		[Embed(source = "../resources/cursor.png")] private var cursorPNG:Class;
		[Embed(source = "../resources/StressBarBack.png")] private var stressBarPNG:Class;
		[Embed(source = "../resources/StressText.png")] private var stressTextPNG:Class;
		
		private var level:FlxTilemap;
		private var rail:FlxSprite;
		private var char:FlxSprite;
		private var stressBar:FlxSprite;
		private var stressText:FlxSprite;
		private var stressInside:FlxSprite;
		private var camera:FlxCamera;
		private var ennemies:FlxGroup;
		
		private var mapManager:MapManager;
		private var colors:Array;
		private var ennemyManager:EnnemyManager;
		
		public function PlayState() 
		{
			rail = new FlxSprite();
			char = new FlxSprite();
			stressBar = new FlxSprite();
			stressText = new FlxSprite();
			stressInside = new FlxSprite();
			//ennemies = new FlxGroup();
			mapManager = new MapManager();
			ennemyManager = new EnnemyManager();
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
			add(mapManager);
			
			// The main character
			rail.loadGraphic(railPNG);
			rail.y = FlxG.height - rail.height;
			FlxG.worldBounds = new FlxRect(0, 0, FlxG.width, FlxG.height);
			FlxG.camera.setBounds(0, 0, FlxG.width, FlxG.height);
			FlxG.camera.follow(rail, FlxCamera.STYLE_LOCKON);
			add(rail);
			
			char.loadGraphic(charPNG, true, false, 17, 27);
			char.x = 20;
			char.y = rail.y - char.height / 2 ;
			char.addAnimation("death", [1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 6], 10, false);
			add(char);
			
			ennemyManager.init();
			add(ennemyManager);
			
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
			stressInside.scale.x = 0;
			add(stressInside);
			
		}
		
		override public function update():void 
		{
			super.update();
				
			if (stressInside.scale.x < 64)
			{
				mapManager.update();
				ennemyManager.setCurrentMapIndex(mapManager.getCurrentIndex());
				ennemyManager.update();
				stressInside.scale.x += 1;
			}
			else {
				char.play("death", false);
				if(char.frame == 6)
					FlxG.switchState(new GameOverState);
			}
		}
	}
}
