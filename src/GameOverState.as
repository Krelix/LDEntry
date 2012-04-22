package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Krelix
	 */
	public class GameOverState extends FlxState 
	{
		[Embed(source = "../resources/rail.png")] private var railPNG:Class;
		[Embed(source = "../resources/mainChar.png")] private var charPNG:Class;
		private var gameOverText:FlxText;
		private var killText:FlxText;
		private var killCount:uint;
		private var rail:FlxSprite;
		private var char:FlxSprite;
		
		public function GameOverState() 
		{
			super();
			rail = new FlxSprite();
			char = new FlxSprite();
			FlxG.bgColor = 0xFFAADDAA;
		}
		
		override public function create():void 
		{
			super.create();
			gameOverText = new FlxText(0, 50, 320, "You failed. The dolls will rule the world !", true);
			gameOverText.alignment = "center";
			
			killText = new FlxText(0, 100, 320, "But you manage to take " + killCount + " of them.", true);
			killText.alignment = "center";
			add(killText);
			
			rail.loadGraphic(railPNG);
			rail.y = FlxG.height - rail.height;
			add(rail);
			
			char.loadGraphic(charPNG, true, false, 17, 27);
			char.x = 20;
			char.y = rail.y - char.height / 2 ;
			char.addAnimation("death", [1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 6], 7, false);
			char.play("death", false);
			add(char);
			add(gameOverText);
		}
		
		public function setKillCount(kills:uint):void
		{
			killCount = kills;
		}
		
	}

}