package gui
{
	import components.Title;
	import components.TitlefieldSkin;
	
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.Regular;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import items.TitleFieldObject;
	
	import properties.AnimationProperties;
	import properties.FrameProperties;

	//[Embed(source='/AnimationTemplateMath.swf', symbol="Titlefield")]
	public class Titlefield extends TitleFieldObject
	{ 		
		private var titles : Array;
				
		public function Titlefield( pObject : TitleFieldObject )
		{
			super(pObject);
			
			/*if( !contains( logo ) )
			{
				trace("NINCS LOGO a TitleFieldSkinben, vagy nincs jol elnevezve a TitleFieldSkin - ben, adj meg ott egy instance nevet es a TitleFieldSkin.as-ben is ird be a logo helyere, de a legegyszerubb, ha logonak nevezed el ");				
			}
			else
			{				
				logo.gotoAndStop("TitleLogo.FIRST");
				logo.visible = false;
			}
			
			if( !contains( backgroundMc ) )
			{
				trace("NINCS backgroundMc a TitleFieldSkinben, vagy nincs jol elnevezve a TitleFieldSkin - ben, adj meg ott egy instance nevet es a TitleFieldSkin.as-ben is ird be a backgroundMc helyere, de a legegyszerubb, ha backgroundMc nevezed el ");				
			}
			else
			{
				backgroundMc.gotoAndStop("TitleBackground.FIRST");
				backgroundMc.visible = false;
			}*/
			
			logoShape.visible = false;
		
		}
		
		public function createTitles( ) : void
		{
			var formatsLength : int = titleFieldTextFormats.length;
			var length : int = titleTexts.length;
			titles = new Array( );
			
			var actFormat : TextFormat;
			var actText : String;
			var actTitle : Title;
			
			var startY : int = 0;
			var startX : int = titlesPaddingLeft;
			
			for( var i : int = 0; i < length; i++ )
			{
				actTitle = new Title();
				
				actText = titleTexts[i];
				
				if( i < formatsLength )
				{
					actFormat = titleFieldTextFormats[i];
				}
				
				actTitle.textfield.text = actText;
				
				actTitle.setFormat( actFormat );
				
				actTitle.textfield.autoSize = TextFieldAutoSize.LEFT;
				
				actTitle.x = this.width;
				actTitle.y = startY;			
				
				startY = actTitle.y+actTitle.height+titleSpacing;
				
				titles.push( actTitle );
				
				//trace("actTile.height: " , actTitle.height );
				
				//addChild( actTitle );
				
			}
		
			if( titleTexts[0])
			{
				
				if( !contains( title1 ) )
				{
					//trace("NINCS title1 a TitleFieldSkinben, vagy nincs jol elnevezve a TitleFieldSkin - ben, adj meg ott egy instance nevet es a TitleFieldSkin.as-ben is ird be a title1 helyere, de a legegyszerubb, ha title1 nevezed el ");
				}
				else
				{
					removeChild( title1 );
				}
			}
			
			if( titleTexts[1])
			{				
				if( !contains( title2 ) )
				{
					//trace("NINCS title2 a TitleFieldSkinben, vagy nincs jol elnevezve a TitleFieldSkin - ben, adj meg ott egy instance nevet es a TitleFieldSkin.as-ben is ird be a title2 helyere, de a legegyszerubb, ha title2 nevezed el ");
				}
				else
				{
					removeChild( title2 );
				}
			}
	
			
			if( startY > backgroundShape.height  )
			{
				trace("startY: ", startY, "backgroundShape.height ",backgroundShape.height );
				
				backgroundShape.height = startY - titleSpacing;
			}
			
		}
	
		public function startAnim( ) : void
		{
			var length : int = titles.length;

			var actTween : Tween// = titleAnimationProperties.createTween();
			var actTitle : Title;
			var timer : Timer;
			
			var bgWidth : Number = backgroundShape.width;
			
			var tweenWidth : Tween = new Tween( backgroundShape, "width", Regular.easeOut, 0, bgWidth, 4, true );
			var tweenX : Tween = new Tween( backgroundShape, "x", Regular.easeOut, bgWidth+logoShape.width, logoShape.width, 4, true );
			
			tweenX.addEventListener( TweenEvent.MOTION_FINISH, onMotionFinish );
			
			function onMotionFinish( pEvent : TweenEvent )
			{
				tweenX.removeEventListener( TweenEvent.MOTION_FINISH, onMotionFinish );
				
				logoShape.visible = true;
				bgWidth = logoShape.width;
								
				tweenWidth= new Tween( logoShape, "width", Regular.easeOut, 0, bgWidth, 1, true );
				tweenX = new Tween( logoShape, "x", Regular.easeOut, backgroundShape.x, 0, 1, true );
				
				tweenWidth.addEventListener( TweenEvent.MOTION_FINISH, onUIElementsFinish );
			}
			
			function onUIElementsFinish( pEvent : TweenEvent ) 
			{
				tweenWidth.removeEventListener( TweenEvent.MOTION_FINISH, onUIElementsFinish );
				timer  = new Timer(animationDelay*1000, titleTexts.length);
				timer.start( );
				timer.addEventListener( TimerEvent.TIMER, onTimerComplete );
				
				actTitle = titles[0];
				
				actTween = new Tween( actTitle, "x", Regular.easeOut, backgroundShape.width, titlesPaddingLeft, 2, true );
				
				addChild( actTitle );
			}
			
			function onTimerComplete( pEvent : TimerEvent )
			{
				
				if( timer.currentCount == titleTexts.length )
				{
					timer.stop();
					timer.removeEventListener( TimerEvent.TIMER, onTimerComplete );
					
					timer = null;
				}
				else
				{
					actTitle = titles[timer.currentCount];
					addChild( actTitle );
					
					var tween = new Tween( actTitle, "x", Regular.easeOut, backgroundShape.width, titlesPaddingLeft, 2, true );
					
					if( timer.currentCount == titleTexts.length - 1 )
					{
						tween.addEventListener( TweenEvent.MOTION_FINISH, onLastTitleShown );
					}
					
					function onLastTitleShown( pEvent : TweenEvent )
					{
						tween.removeEventListener( TweenEvent.MOTION_FINISH, onLastTitleShown );
						
						dispatchEvent( new Event( AnimationProperties.ANIM_FINISHED, true ) );
					}
					
				}
			}	
			
			
		}
	
	}
}