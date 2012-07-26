package components
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
		
	public class Button extends EventDispatcher
	{
		public static const CLICKED : String = "Button.CLICKED";
		
		public var buttonSkin : *;
		public var isClicked : Boolean;
		
		public function Button( pSkin : * ) 
		{
		//	trace("Button: ", pSkin );
			buttonSkin = pSkin;
			
			buttonSkin.buttonMode = true;
		}
		
		public function registerListeners( ) : void
		{
			buttonSkin.addEventListener(MouseEvent.MOUSE_OVER, onOver );
			buttonSkin.addEventListener(MouseEvent.MOUSE_OUT, onOut );
			buttonSkin.addEventListener( MouseEvent.MOUSE_DOWN, onClick );
		}
		
		public function unregisterListeners( ) : void
		{
			buttonSkin.removeEventListener(MouseEvent.MOUSE_OVER, onOver );
			buttonSkin.removeEventListener(MouseEvent.MOUSE_OUT, onOut );
			buttonSkin.removeEventListener(MouseEvent.MOUSE_DOWN, onClick );
		}
		
		protected function onOver( pEvent : MouseEvent ) : void
		{
			//trace("onOver");		
		}
		
		protected function onOut( pEvent : MouseEvent ) : void
		{
			//trace("onOut");
		}
		
		protected function onClick( pEvent : MouseEvent ) : void
		{
			dispatchEvent( new Event( Button.CLICKED, true ) );
			isClicked = !isClicked;
			
			//trace("Click");
		}
		
		public function toggle( ) : void
		{
			isClicked = !isClicked;
		}
		
	}
	
}
