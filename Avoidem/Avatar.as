package  {
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	
	public class Avatar extends MovieClip{
		
		private var downKeyPressed:Boolean;
		private var upKeyPressed:Boolean;
		private var leftKeyPressed:Boolean;
		private var rightKeyPressed:Boolean;
		
		private var baseSpeed:Number;
		
		public function Avatar() {
			gotoAndStop(1);
			x= 0;
			y= 0;
			
			downKeyPressed = false;
			upKeyPressed = false;
			leftKeyPressed = false;
			rightKeyPressed = false;
			
			baseSpeed = 2;
			//addEventListener(Event.ADDED_TO_STAGE, onAddAvatarToStage);
		}
		
		public function useKeyControl():void{
			if(downKeyPressed) y += baseSpeed;
			if(upKeyPressed) y -= baseSpeed;
			if(leftKeyPressed) x -= baseSpeed;
			if(rightKeyPressed) x += baseSpeed;
			
		}
		
		public function onKeyPress( keyboardEvent:KeyboardEvent ):void
		{ //trace(">>onkeyPress<<");
 			if(keyboardEvent.keyCode == Keyboard.DOWN){
				downKeyPressed = true;
			}
			if(keyboardEvent.keyCode == Keyboard.UP){
				upKeyPressed = true;
			}
			if(keyboardEvent.keyCode == Keyboard.LEFT){
				leftKeyPressed = true;
			}
			if(keyboardEvent.keyCode == Keyboard.RIGHT){
				rightKeyPressed = true;
			}
			
		}
		public function onKeyRelease( keyboardEvent:KeyboardEvent ):void
		{
			if(keyboardEvent.keyCode == Keyboard.DOWN){
				downKeyPressed = false;
				trace("dreleased");
			}
			if(keyboardEvent.keyCode == Keyboard.UP){
				upKeyPressed = false;
			}
			if(keyboardEvent.keyCode == Keyboard.LEFT){
				leftKeyPressed = false;
			}
			if(keyboardEvent.keyCode == Keyboard.RIGHT){
				rightKeyPressed = false;
			}
		}
		
		public function onAddAvatarToStage(event:Event):void{
			//trace("staged");
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
	}
}
