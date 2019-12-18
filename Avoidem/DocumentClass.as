package  {
	import flash.display.MovieClip;
	import flash.events.*
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	
	public class DocumentClass extends MovieClip 
	{
		public var startScreen:StartScreen;
		public var playScreen:AvoiderGame;
 		public var gameOverScreen:GameOverScreen;
		public var loadingProgress:LoadingProgress;
		public function DocumentClass() {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
			
			loadingProgress = new LoadingProgress();
			loadingProgress.x = stage.stageWidth/2;
			loadingProgress.y = stage.stageHeight/2;
			addChild(loadingProgress);
			loaderInfo.addEventListener(Event.COMPLETE, onCompletelyDownloaded)
			loaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgressMade );
			stage.stageFocusRect = false;
		}
		
		public function onProgressMade( progressEvent:ProgressEvent ):void{
 			loadingProgress.setValue(Math.floor(100*loaderInfo.bytesLoaded/loaderInfo.bytesTotal));
		}
		
		public function onCompletelyDownloaded( event:Event ):void {
			gotoAndStop(3);
			showStartScreen();
		}
		
		public function showStartScreen():void{
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
			stage.focus = playScreen;
			
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
			gameOverScreen.setFinalScore(playScreen.finScore);
			gameOverScreen.addEventListener( NavigationEvent.RESTART, onRequestRestart );
			gameOverScreen.addEventListener( NavigationEvent.MAINMENU, onRequestMainMenu );
			addChild( gameOverScreen );
 			
			
		}
		
		public function onKeyPress( keyboardEvent:KeyboardEvent ):void{
 			if(keyboardEvent.keyCode == Keyboard.P){
				if(playScreen!=null){
					playScreen.togglePause();
				}
			}
		}
		
		public function onKeyRelease( keyboardEvent:KeyboardEvent ):void{
			
		}
	}
}
