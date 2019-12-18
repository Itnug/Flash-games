package  {
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.*;
	import flash.ui.Mouse;
	import flash.ui.Keyboard;
	
	public class AvoiderGame extends MovieClip{

		public var army:Array;
		public var enemy:Enemy;
		public var avatar:Avatar;
		public var gameTimer:Timer;
		
		public var avatarRadius:Number;
		public var level:Number;
		
		private var pKeyPressed:Boolean;
		
		public var MouseControl:Boolean;
		public function AvoiderGame() {
			Mouse.hide();
			
			army = new Array();
			var newEnemy = new Enemy(100,-20);
			army.push(newEnemy);
			addChild(newEnemy);
			
			avatar = new Avatar();
			avatarRadius = (avatar.width+avatar.height)/2;
			addChild(avatar);
			
			pKeyPressed = false;
			
			MouseControl = false;
			if(MouseControl){
				avatar.x = mouseX;
				avatar.y = mouseY;
			}else{
				avatar.x = mouseX;
				avatar.y = mouseY;
			}
			level = 1;
			
			gameTimer = new Timer(25);
			gameTimer.addEventListener(TimerEvent.TIMER, onTick);
			gameTimer.start();
			
		}

		public function onTick(timerEvent:TimerEvent):void{
			if ( Math.random() < 0.15 ){
				var randomX:Number = -50+Math.random() * stage.width;
				var newEnemy:Enemy = new Enemy( randomX, -15 );
		
				army.push( newEnemy );
				addChild( newEnemy );
				gameScore.addToValue( 10 );
				
				if(gameScore.currentValue/1000 > level){
					Enemy.increaseLevel();
					level=level+1;
				}
			}
			
			if(MouseControl){
				avatar.x = mouseX;
				avatar.y = mouseY;
			}else{
				avatar.useKeyControl();
			}
				
			if ( avatar.x > stage.stageWidth- avatar.width/2) avatar.x = stage.stageWidth-avatar.width/2;
			if ( avatar.y > stage.stageHeight ) avatar.y = stage.stageHeight;
			if ( avatar.x < avatar.width/2 ) avatar.x = avatar.width/2;
			if ( avatar.y < 0 ) avatar.y = 0;
			
			for each(var enemy:Enemy in army){
				//if(enemy.active){
			 		enemy.tick();
				
					
				trace(army.length+"");
					var avatarHasBeenHit:Boolean = false;
					if(PixelPerfectCollisionDetection.isColliding(avatar,enemy,this,true)){
						gameTimer.stop();
						avatarHasBeenHit = true;
					}if(avatarHasBeenHit){
						dispatchEvent( new AvatarEvent( AvatarEvent.DEAD ) );
					}
					
					if ( enemy.y > stage.stageHeight + 60 ) army.splice(army.indexOf(enemy,0),1);
				//}
			}
		}
	}
}
