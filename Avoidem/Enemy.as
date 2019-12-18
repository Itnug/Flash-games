package  {
	import flash.display.MovieClip;
	public class Enemy extends MovieClip{
		public static var spdX:Number;
		public static var spdY:Number;
		public var active:Boolean; 
		public function Enemy(startX:Number,startY:Number) {
			x=startX;
			y=startY;
			
			spdX = 4;
			spdY = 5;
			
			active = true;
		}
		
		public function moveDown():void
		{
			x= x-spdX/2+Math.random()*spdX;
			y= y+Math.random()*spdY;
			
		}

		public static function increaseLevel():void{
			if(Math.random() < 0.3){
				spdX= spdX+1;
			}else{
				spdY=spdY+1;
			}
		}
		
		public function tick():void{
			moveDown();
			rotation+=-10+Math.random()*20;
			
		}
	}
	
}
