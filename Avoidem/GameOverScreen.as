package  {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.net.SharedObject;
	
	public class GameOverScreen extends MovieClip{
		
		public var sharedObject:SharedObject;
		
		public function GameOverScreen(startX:Number,startY:Number) {
			
			Mouse.show();
			x=startX;
			y=startY;
			
			restartButton.addEventListener( MouseEvent.CLICK, onClickRestart );
			mainMenuButton.addEventListener( MouseEvent.CLICK, onClickMainMenu );
			
			sharedObject = SharedObject.getLocal( "HiScores" );
			
		}

public function setFinalScore( scoreValue:Number ):void
{
	finalScore.text = scoreValue.toString();
	try{
		if ( sharedObject.data.bestScore == null ){
			sharedObject.data.bestScore = scoreValue;
		}else if ( scoreValue > sharedObject.data.bestScore ){
	     	sharedObject.data.bestScore = scoreValue;
		}
	bestScore.text = sharedObject.data.bestScore.toString();
	sharedObject.flush();
	}catch ( sharedObjectError:Error )
	{
		trace( "Caught this error:", sharedObjectError.name, sharedObjectError.message );
		bestScore.text = "???";
	}
}
		public function onClickRestart( mouseEvent:MouseEvent ):void{
			dispatchEvent( new NavigationEvent( NavigationEvent.RESTART ) );
		}
		public function onClickMainMenu( mouseEvent:MouseEvent ):void{
			dispatchEvent( new NavigationEvent( NavigationEvent.MAINMENU ) );
		}
	}
	
}
