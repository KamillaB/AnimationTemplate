package gui
{
	import components.Button;
	
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.Regular;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import items.InfoButtonObject;
	import items.TitleFieldObject;
		
	public class InfoButton extends InfoButtonObject		
	{
		public static const ANIM_FINISHED : String = "InfoButton.ANIM_FINISHED";
		private var button : Button;
		
		public function InfoButton( pObject : InfoButtonObject )
		{
			super( pObject );
		}
		
		public function startAnim( ) : void
		{			
		  	infoButtonAnimation.apObj = this;
			infoButtonAnimation.apBegin = 0;
			infoButtonAnimation.apFinish = width;
			
			var tween : Tween = infoButtonAnimation.createTween( );
			
			tween.addEventListener(TweenEvent.MOTION_FINISH, onMotionFinish );
			
			function onMotionFinish( pEvent : TweenEvent )
			{
				dispatchEvent( new Event( InfoButton.ANIM_FINISHED) );
			}
		}
		
	}
}