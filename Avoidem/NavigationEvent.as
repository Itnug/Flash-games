package  {
	import flash.events.Event;	
	public class NavigationEvent extends Event {

		public static const RESTART:String = "restart";
		public static const START:String = "start";
		public static const MAINMENU:String = "mainMenu";
		
		public function NavigationEvent(type:String )
		{
			super( type );
		}

	}
	
}
