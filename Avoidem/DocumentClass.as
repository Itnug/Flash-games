package  {
	import flash.display.MovieClip;
	public class DocumentClass extends MovieClip 
	{
		public var startScreen:StartScreen;
		public var playScreen:AvoiderGame;
 		public var gameOverScreen:GameOverScreen;
		
		public function DocumentClass() 
		{
			startScreen = new StartScreen(0,0);
			startScreen.addEventListener( NavigationEvent.START, onRequestStart );
			addChild( startScreen );
		}
		
		public function onRequestStart( navigationEvent:NavigationEvent ):void{
			playScreen = new AvoiderGame();
			playScreen.addEventListener( AvatarEvent.DEAD, onAvatarDeath );
			playScreen.x = 0;
			playScreen.y = 0;
			addChild( playScreen );
 			removeChild(startScreen);
			startScreen = null;
		}

		public function restartGame():void{
			removeChild(playScreen);
			playScreen = null;
			
			playScreen = new AvoiderGame();
			playScreen.addEventListener( AvatarEvent.DEAD, onAvatarDeath );
			addChild( playScreen );
 			
			removeChild(gameOverScreen);
			gameOverScreen = null;
		}
		public function onRequestRestart( navigationEvent:NavigationEvent ):void{
			restartGame();
		}
		
		public function initGame():void{
			
			startScreen = new StartScreen(0,0);
			startScreen.addEventListener( NavigationEvent.START, onRequestStart );
			addChild( startScreen );
			removeChild(playScreen);
			playScreen = null;
 			removeChild(gameOverScreen);
			gameOverScreen = null;
		}
		public function onRequestMainMenu( navigationEvent:NavigationEvent ):void{
			initGame();
		}
		
		public function onAvatarDeath( avatarEvent:AvatarEvent ):void{
			gameOverScreen = new GameOverScreen(275,200);
			gameOverScreen.addEventListener( NavigationEvent.RESTART, onRequestRestart );
			gameOverScreen.addEventListener( NavigationEvent.MAINMENU, onRequestMainMenu );
			addChild( gameOverScreen );
 			
			
		}
	}
}
