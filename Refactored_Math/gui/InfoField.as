package gui
{
	import components.Button;
	
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import items.InfoFieldObject;
	
	import properties.FrameProperties;
	
	import util.DisplayObjectUtil;

	public class InfoField extends InfoFieldObject
	{	
		public static const FADEOUT_FINISHED : String = "InfoField.FADEOUT_FINISHED";
		public static const FADEIN_FINISHED : String = "InfoField.FADEIN_FINISHED";
		public static const CLOSEBUTTON_CLICKED : String = "InfoField.CLOSEBUTTON_CLICKED";
		
		private var closeButton : Button;
		private var tween : Tween;
		
		public function InfoField( pObject : InfoFieldObject )
		{
			super( pObject );
			
			closeButton = new Button( closeButtonSkin );
			
			infoFieldBackground.width  -= 5;
			infoFieldBackground.height -= 5;
			
			textfield.width = infoFieldBackground.width - 2* textPaddingLeft;
			textfield.height = infoBackground.height - 2*textPaddingTop;
			
			textfield.x = infoFieldBackground.x + textPaddingLeft;
			textfield.y = infoFieldBackground.y + textPaddingTop;
		}
		
		public function setTextFormat( ) : void
		{
			textfield.setTextFormat( textFormat );
		}
		
		
		public function setText( ) : void
		{
			textfield.text = infoText;
			
			updateView();
		}
		
		public function updateView( ) : void
		{
			
			
			switch( smallBackgroundAlignedToAnim )
			{
				case FrameProperties.BOTTOM_RIGHT:
					infoFieldBackground.x = infoBackground.width - infoFieldBackground.width-5;
					infoFieldBackground.y = infoBackground.height - infoFieldBackground.height-5;
				break;
			}
			
			if( smallBAckgroundAutoFitToText == true )
			{
				
			}
		}
		
		public function startFadeIn( ) : void
		{
			fadeInProperties.apObj = this;
			tween = fadeInProperties.createTween( );
			
			tween.addEventListener( TweenEvent.MOTION_FINISH, onFadeInFinished );
			
			
		}
		
		
		
		public function startFadeOut( ) : void
		{
			fadeOutProperties.apObj = this;
			tween = fadeOutProperties.createTween( );
			tween.addEventListener( TweenEvent.MOTION_FINISH, onFadeOutFinished );
			
		}
		
		public function onFadeInFinished( pEvent : TweenEvent ) : void
		{
			closeButton.registerListeners( );
			tween.removeEventListener( TweenEvent.MOTION_FINISH, onFadeInFinished );
			closeButton.registerListeners( );
			closeButton.addEventListener( Button.CLICKED, onCloseButtonClicked );
			
			dispatchEvent( new Event( InfoField.FADEIN_FINISHED ) );
		}
		
		public function onFadeOutFinished( pEvent : TweenEvent ) : void
		{
			tween.removeEventListener( TweenEvent.MOTION_FINISH, onFadeOutFinished );
			
			dispatchEvent( new Event( InfoField.FADEOUT_FINISHED ) );
		}
		
		public function onCloseButtonClicked( pEvent : Event ) : void
		{
			closeButton.unregisterListeners();
			dispatchEvent( new Event( InfoField.CLOSEBUTTON_CLICKED ) );
		}
	}
}