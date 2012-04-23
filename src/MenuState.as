package  
{
	import org.flixel.*;
	/**
	 * The starting state, show the game mennu with a big start button and no title.
	 * @author Krelix
	 */
	public class MenuState extends FlxState
	{
		[Embed(source = "../resources/menubackground.png")] private var bgPNG:Class;
		private var startButton:FlxButton;
		private var creditButton:FlxButton;
		private var gameTitle:FlxText;
		private var backGround:FlxSprite;
		
		public function MenuState() 
		{
		}
		
		override public function create():void
		{
			FlxG.mouse.show();
			backGround = new FlxSprite();
			backGround.loadGraphic(bgPNG);
			backGround.origin.x = 0;
			backGround.origin.y = 0;
			backGround.scale.x = 0.5;
			backGround.scale.y = 0.5;
			add(backGround);
			
			// Creating a new title for the game.
			gameTitle = new FlxText(0, 0, FlxG.width, "It's a crazy tiny world after all !");
			// Centering it (because it look better)
			gameTitle.setFormat(null, 15, 0xDD0000, "center", 0xFF000000);
			gameTitle.y = 2;
			
			// Creating the start button
			// (to start the actual game, because the title screen isn't everything)
			startButton = new FlxButton(0, 0, "Start Game", startGame);
			startButton.x = 10;
			startButton.y = FlxG.height - startButton.height * 4;
			add(startButton);
			
			// Credits button
			creditButton = new FlxButton(0, 0, "Credits", showCredit);
			creditButton.x = 10;
			creditButton.y = FlxG.height - startButton.height * 2;
			add(creditButton);
			
			add(gameTitle);
			FlxG.debug = true;
		}
		
		private function startGame():void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new PlayState);
		}
		
		private function showCredit():void
		{
			FlxG.switchState(new CreditState);
		}
	}
}