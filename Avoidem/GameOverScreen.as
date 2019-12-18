package  {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	public class GameOverScreen extends MovieClip{

		public function GameOverScreen(startX:Number,startY:Number) {
			Mouse.show();
			x=startX;
			y=startY;
			
			restartButton.addEventListener( MouseEvent.CLICK, onClickRestart );
			mainMenuButton.addEventListener( MouseEvent.CLICK, onClickMainMenu );

		}

		public function onClickRestart( mouseEvent:MouseEvent ):void{
			dispatchEvent( new NavigationEvent( NavigationEvent.RESTART ) );
		}
		public function onClickMainMenu( mouseEvent:MouseEvent ):void{
			dispatchEvent( new NavigationEvent( NavigationEvent.MAINMENU ) );
		}
	}
	
}
