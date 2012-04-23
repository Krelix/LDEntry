package  
{
	import org.flixel.FlxButton;
	import org.flixel.FlxState;
	import org.flixel.FlxText
	import org.flixel.FlxG
	
	/**
	 * ...
	 * @author Krelix
	 */
	public class CreditState extends FlxState 
	{
		private var myText:FlxText;
		private var gText:FlxText;
		private var bText:FlxText;
		private var sText:FlxText;
		private var returnMenu:FlxButton;
		
		public function CreditState() 
		{
			super();
		}
		
		override public function create():void 
		{
			myText = new FlxText(0, 20, FlxG.width, "Scrapped together by Adrien \" Krelix\".", true);
			myText.alignment = "center";
			add(myText);
			
			sText = new FlxText(0, 40, FlxG.width, "Special thanks to :", true);
			sText.alignment = "center";
			add(sText);
			
			gText = new FlxText(0, 60, FlxG.width, "Menu artwork and main character design by Greg \"PrefectGreg\".", true);
			gText.alignment = "center";
			add(gText);
			
			bText = new FlxText(0, 80,FlxG.width, "Help on Sprites by B. Joel \" BuZerK\".", true);
			bText.alignment = "center";
			add(bText);
			
			returnMenu = new FlxButton(0, 0, "Return to Menu", getMenu);
			returnMenu.x = FlxG.width / 2 - returnMenu.width / 2;
			returnMenu.y = 100;
			add(returnMenu);
			
			super.create();
		}
		
		public function getMenu():void
		{
			FlxG.switchState(new MenuState);
		}
		
	}

}