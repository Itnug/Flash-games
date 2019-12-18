package  {
	
	import flash.display.MovieClip;
	
	
	public class Bonus extends MovieClip {
		
		public var speed:Number;
		public var rotateSpeed:Number;
		public static var vx:Number;
		public static var vy:Number;
	 
	 	public var value:Number;
		
		public function Bonus() {
			x=Math.random()*550;
			y=Math.random()*400;
			vx =0;
			vy =0;
			speed = Math.random();
			rotateSpeed = -5+ Math.floor(Math.random()*11);
			
			value = 250;
		}
		
		public function degreesToRadians(degrees:Number) : Number{
			return degrees * Math.PI / 180;
		}
		
		public function tick():void{
			value--;
			this.nextFrame();
			
			vy = Math.sin(degreesToRadians(rotation)) * speed;
			vx = Math.cos(degreesToRadians(rotation)) * speed;
			y = y + vy;
			x = y + vx;
			rotation += rotateSpeed;
			
			if(x<0||x>550){
				vx *= -1;
			}
			if(y<0||y>400){
				vy *= -1;
			}
		}
	}
	
}
