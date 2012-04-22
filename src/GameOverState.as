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
		private var rail:FlxSprite;
		private var char:FlxSprite;
		
		public function GameOverState() 
		{
			super();
			rail = new FlxSprite();
			char = new FlxSprite();
			
			gameOverText = new FlxText(0, 50, 320, "You failed. The dolls will rule the world !", true);
			gameOverText.alignment = "center";
			FlxG.bgColor = 0xFFAADDAA;
		}
		
		override public function create():void 
		{
			super.create();
			rail.loadGraphic(railPNG);
			rail.y = FlxG.height - rail.height;
			add(rail);
			
			char.loadGraphic(charPNG, true, false, 17, 27);
			char.x = 20;
			char.y = rail.y - char.height / 2 ;
			char.frame = 6;
			add(char);
			add(gameOverText);
		}
		
	}

}