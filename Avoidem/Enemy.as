package  {
	import flash.display.MovieClip;
	public class Enemy extends MovieClip{
		public static var spdX:Number;
		public static var spdY:Number;
	 
		public function Enemy(startX:Number,startY:Number) {
			x=startX;
			y=startY;
			
			spdX = 4;
			spdY = 5;
			
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
		private var frameNum:Number = 0;
		public function tick():void{
			if(Math.random()<0.75){
				this.nextFrame();
				frameNum++;
			}
			if(frameNum>30){
				this.gotoAndPlay(1);
				frameNum = 0;
			}
			moveDown();
			rotation+=-10+Math.random()*20;
			
		}
	}
	
}
