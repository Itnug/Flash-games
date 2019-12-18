package  {
	
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	public class LoadingProgress extends Counter {
			
		public function LoadingProgress() {
			super();
		}
		
		override public function updateDisplay():void{
			super.updateDisplay();
			percentDisplay.text = currentValue.toString()+"%";
		}
	}
	
}
