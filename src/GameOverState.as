package  
{
	import org.flixel.FlxButton;
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
		private var killText2:FlxText;
		private var killCount:uint;
		private var prevKillCount:int; 
		private var rail:FlxSprite;
		private var char:FlxSprite;
		private var replayButton:FlxButton;
		
		public function GameOverState() 
		{
			super();
			rail = new FlxSprite();
			char = new FlxSprite();
			killCount = 0;
			prevKillCount = -1;
			FlxG.bgColor = 0xFFAADDAA;
			replayButton = new FlxButton(0, 0, "Replay!", newGame);
			replayButton.x = FlxG.width / 2 - replayButton.width / 2;
			replayButton.y = 150;
		}
		
		override public function create():void 
		{
			super.create();
			gameOverText = new FlxText(0, 50, 320, "You failed. The dolls will rule the world !", true);
			gameOverText.alignment = "center";
			
			killText = new FlxText(0, 100, 320, "But you manage to take " + killCount + " of them.", true);
			killText.alignment = "center";
			add(killText);
			
			if (prevKillCount > 0)
			{
				if(prevKillCount > killCount)
					killText2 = new FlxText(0, 120, 320, "But you've done better.", true);
				else
					killText2 = new FlxText(0, 120, 320, "Setting a new record !", true);
				killText2.alignment = "center";
				add(killText2);
			}
			
			rail.loadGraphic(railPNG);
			rail.y = FlxG.height - rail.height;
			add(rail);
			
			add(replayButton);
			
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
		
		public function setPreviousKillCount(count:int):void
		{
			prevKillCount = count;
		}
		
		public function newGame():void
		{
			var newG:PlayState = new PlayState();
			newG.setPreviousKillCount(killCount);
			FlxG.switchState(newG);
		}	
	}
}