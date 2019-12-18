package
{
	import flash.text.TextField;
	public class Score extends Counter
	{
		public function Score()
		{
 			super();
		}
		public override function updateDisplay():void
		{	
 			super.updateDisplay();
			scoreDisplay.text = currentValue.toString();
		}
	}
}