package  {
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.*;
	import flash.ui.Mouse;
	import flash.ui.Keyboard;
	import flash.media.SoundChannel;
	
	public class AvoiderGame extends MovieClip{

		private var isPaused:Boolean;
		public var pauseText:PauseButton;
		public var MouseControl:Boolean;
		
		public var backgroundMusic:BackgroundMusic;
		public var bgmSoundChannel:SoundChannel;
		public var enemyAppearSound:EnemyAppearSound;
		public var sfxSoundChannel:SoundChannel;
		
		public var level:Number;
		public var enemyFrequency:Number = 0.15;
		public var bonusFrequency:Number = 0.05;
		
		public var army:Array;
		public var enemy:Enemy;
		public var treasure:Array;
		public var bonus:Bonus;
		public var avatar:Avatar;
		public var gameTimer:Timer;
		public var finScore:Number;
		
		public function AvoiderGame() {
			isPaused = false;
			pauseText = new PauseButton();
			MouseControl = true;
			Mouse.hide();
			
			backgroundMusic = new BackgroundMusic();
			bgmSoundChannel = backgroundMusic.play();
			bgmSoundChannel.addEventListener( Event.SOUND_COMPLETE, onBackgroundMusicFinished );
			enemyAppearSound = new EnemyAppearSound();
			
			level = 1;
			
			army = new Array();
			var newEnemy = new Enemy(100,-20);
			army.push(newEnemy);
			addChild(newEnemy);
			
			treasure = new Array();
			
			avatar = new Avatar();
			addChild(avatar);
			avatar.x = mouseX;
			avatar.y = mouseY;
			
			gameTimer = new Timer(25);
			gameTimer.addEventListener(TimerEvent.TIMER, onTick);
			gameTimer.start();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddGameToStage);
			
			
		}
		
		public function onAddGameToStage(event:Event):void{
			trace("staged");
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
			//stage.dispatchEvent( new MouseEvent( MouseEvent.CLICK,true, false, mouseX, mouseY ) );
		}
		
		public function onKeyPress( keyboardEvent:KeyboardEvent ):void
		{ 	trace(">>onkeyPress<<");
 			if(keyboardEvent.keyCode == Keyboard.P){
				if(isPaused) {
					isPaused = false;
					removeChild(pauseText);
				}else {
					isPaused = true;
					addChild(pauseText);
					pauseText.x = stage.stageWidth/2;
					pauseText.y = stage.stageHeight/2;
				}
			}
			
			if(keyboardEvent.keyCode == Keyboard.SPACE){
				avatar.gotoAndStop(2);
			}
			
		}
		public function onKeyRelease( keyboardEvent:KeyboardEvent ):void
		{
			if(keyboardEvent.keyCode == Keyboard.SPACE){
				avatar.gotoAndStop(1);
			}
		}

		
		
		public function onTick(timerEvent:TimerEvent):void{
			if(!isPaused){
				if (stage.focus != this ) {
					stage.focus = this;
					//trace('reset');
				}
				if ( Math.random() < enemyFrequency ){
					if( Math.random() < bonusFrequency){
						var newBonus:Bonus = new Bonus();
						treasure.push(newBonus);
						addChild( newBonus );
						sfxSoundChannel = enemyAppearSound.play();
					}else{
						var newEnemy:Enemy = new Enemy(Math.random() * stage.stageWidth, 0 );
						army.push( newEnemy );
						addChild( newEnemy );
						sfxSoundChannel = enemyAppearSound.play();
				
						gameScore.addToValue( Math.floor(10*(1+1/level)));
					}
					if(gameScore.currentValue/(1000*(1+level)) > level){
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
				if ( avatar.y > stage.stageHeight- avatar.height/2 ) avatar.y = stage.stageHeight-avatar.height/2;
				if ( avatar.x < avatar.width/2 ) avatar.x = avatar.width/2;
				if ( avatar.y < 0 ) avatar.y = 0;
			
				for each(var enemy:Enemy in army){
			 		enemy.tick();
					if ( enemy.x > stage.stageWidth- enemy.width/2) enemy.x = stage.stageWidth-enemy.width/2;
					if ( enemy.x < enemy.width/2 ) enemy.x = enemy.width/2;
					
					var avatarHasBeenHit:Boolean = false;
					if(PixelPerfectCollisionDetection.isColliding(avatar,enemy,this,true)){
						gameTimer.stop();
						avatarHasBeenHit = true;
					}if(avatarHasBeenHit){
						finScore = gameScore.currentValue;
						bgmSoundChannel.stop();
						dispatchEvent( new AvatarEvent( AvatarEvent.DEAD ) );
					}
					
					if ( enemy.y > stage.stageHeight) {
						removeChild(enemy);
						army.splice(army.indexOf(enemy,0),1);
					}
				}
				
				for each(var bonus:Bonus in treasure){
			 		bonus.tick();
					if(bonus.value==0){
						removeChild(bonus);
						treasure.splice(treasure.indexOf(bonus,0),1);
					}
					if(PixelPerfectCollisionDetection.isColliding(avatar,bonus,this,true)){
						//sfxSoundChannel = bonusSoundEffect.play();
						gameScore.addToValue(bonus.value);
					
						removeChild(bonus);
						treasure.splice(treasure.indexOf(bonus,0),1);
					}
				}
			}  
		}
		
		public function onBackgroundMusicFinished( event:Event ):void{
			bgmSoundChannel = backgroundMusic.play();
			bgmSoundChannel.addEventListener( Event.SOUND_COMPLETE, onBackgroundMusicFinished );
		}
	}
}
