package  {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	public class StartScreen extends MovieClip{

		public function StartScreen(startX:Number,startY:Number) {
			x=startX;
			y=startY;
			
			startButton.addEventListener( MouseEvent.CLICK, onClickStart );

		}

		public function onClickStart( mouseEvent:MouseEvent ):void{
			dispatchEvent( new NavigationEvent( NavigationEvent.START ) );
		}
	}
	
}
