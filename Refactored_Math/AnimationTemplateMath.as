package
{
	import components.Background;
	import components.Button;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import flashx.textLayout.tlf_internal;
	
	import gui.EndAnimation;
	import gui.ExerciseChooseCorrectAnswerMath;
	import gui.ExplanationObject;
	import gui.InfoButton;
	import gui.InfoField;
	import gui.Titlefield;
	
	import items.AnswerEvent;
	import items.AnswerObjectMath;
	
	import properties.AnimationProperties;
	import properties.FrameProperties;
	import properties.Lesson;
	import properties.LessonUiProperties;
	
	import util.DisplayObjectUtil;
	
	
	public class AnimationTemplateMath extends Sprite
	{
		private var frameProperties : FrameProperties;
		
		private var titleField : Titlefield;
		private var background : Background;
		private var infoButton : InfoButton;
		private var infoField : InfoField;
		private var endAnimation : EndAnimation;
		
		private var buttonInfo : Button;
		
		private var lesson : Lesson;
		
		private var actExerciseNumber : int = 0;
		private var actExercise : ExerciseChooseCorrectAnswerMath;
		
		private var exerciseObjects : Array;
		
		private var actExplanation : ExplanationObject;
		
		private var goodAnswerNumber : int = 0;
		private var badAnswerNumber : int = 0;
		private var timer : Timer;
		
		public function AnimationTemplateMath()
		{			
			var lessonUiProperties : LessonUiProperties = new LessonUiProperties();
			frameProperties = new FrameProperties( );
			exerciseObjects = new Array( );
			
			createBackground( );	
			createTitleField( );
			createInfoButton( );
			createInfoField( );
			
			if( !Lesson.needAnimationFrameAnimation )
			{
				createLesson();
			}
		
		}
		
		public function createBackground( ) : void
		{
			//trace( getChildByName( FrameProperties.backGroundMcSkinName ) );
			//background = 
			
			var mc : DisplayObject = getChildByName( FrameProperties.backgroundMcSkinName );
			
			if( !frameProperties.backgroundMc )
			{
				if( !mc )
				{
					//trace("There is not background set");
					
					return;
				}
				
			}
			else if( !mc  )
			{
				//trace("No Background on the stage, creating one");
				
				mc = new FrameProperties.backgroundMcSkinClass();	
				background = new Background( frameProperties.backgroundMc, mc );
				
				addChild( background );
				
				if( background.autoFitToAnimSize == true )
				{				
					background.width = (this.stage.stageWidth - 2*background.paddingLeft );
					background.height = (this.stage.stageHeight - 2*background.paddingTop );
					
				}
				
				if( background.usePadding == true )
				{				
					background.x = background.paddingLeft;
					background.y = background.paddingTop;		
				}
				else
				{				
					background.x = background.posX;
					background.y = background.posY;
				}
				
			} 
			else					
			{	
				//this.removeChild( mc );
				//trace("Background found on stage, no change will applied");									
			}	
			
		}
		
		public function createTitleField( ) : void
		{
			var mc : DisplayObject = getChildByName( FrameProperties.titleFieldSkinName );
			
			if( !frameProperties.titleFieldMc )
			{
				if( !mc )
				{
					//trace("There is not titleField set");
					
					return;
				}
				
			}
			else if( !mc  )
			{
				//trace("No titleField on the stage, creating one");
				mc = new FrameProperties.titleFieldSkinClass();	
				
				titleField = new Titlefield( frameProperties.titleFieldMc );
				if( titleField.autoFitToBackground )
				{
					titleField.x = background.width - titleField.width;
				}
				
				titleField.y = titleField.paddingTop;
				
				titleField.createTitles();
				
				titleField.addEventListener( AnimationProperties.ANIM_FINISHED, onTitleAnimFinished );
				titleField.startAnim( );
				
				addChild( titleField );				
			} 
			else					
			{	
				//trace("titleField found on stage, its settings will be apllied");									
			}		
		}	
		
		public function createInfoButton( ) : void
		{
			var mc : DisplayObject = getChildByName( FrameProperties.infoButtonSkinName );
			
			if( !frameProperties.infoButtonMc )
			{
				if( !mc )
				{
					//trace("There is not infoButton set");
					
					return;
				}
				
			}
			else if( !mc  )
			{
				//trace("No infoButton on the stage, creating one");
				mc = new FrameProperties.infoButtonClassName( );	
				
				infoButton = new InfoButton( frameProperties.infoButtonMc );	
				buttonInfo = new Button( infoButton );
				
				infoButton.x = infoButton.posX;
				infoButton.y = infoButton.posY;
				
			} 
			else					
			{	
				buttonInfo = new Button( mc as Sprite );
				//trace("infoButton found on stage, its settings will be apllied");									
			}		
			
			
			buttonInfo.registerListeners( );			
			buttonInfo.addEventListener( Button.CLICKED, onInfoButtonClicked );
			
			//createLesson( );
		}
		
		private function createInfoField( ) : void
		{
			var mc : DisplayObject = getChildByName( FrameProperties.infoFieldSkinName );
			
			if( !frameProperties.infoFieldMc )
			{
				if( !mc )
				{
					trace("There is not infoButton set");
					
					return;
				}
				
			}
			else if( !mc  )
			{
				trace("No infoButton on the stage, creating one");
				mc = new FrameProperties.infoFieldSkinClass( );	
				
				infoField = new InfoField( frameProperties.infoFieldMc );	
				
				infoField.setText( );
				infoField.setTextFormat( );
				
				infoField.addEventListener( InfoField.FADEOUT_FINISHED, onInfoFieldFadedOut );
				infoField.addEventListener( InfoField.FADEIN_FINISHED, onInfoFieldFadedIn );
				infoField.addEventListener( InfoField.CLOSEBUTTON_CLICKED, onInfoCloseButtonClicked );
			} 
			else					
			{	
				trace("infoButton found on stage, its settings will be apllied");									
			}
			
		}
		
		public function createLesson( ) : void
		{
			LessonUiProperties.maxWidth = width-infoButton.x - infoButton.width;
			LessonUiProperties.maxHeight = height - titleField.y - titleField.height - LessonUiProperties.paddingTop;
			
			lesson = new Lesson( );
			lesson.setLesson();
			
			lesson.setExercises( );
			createExercises();
			
			showExercise( );
			//trace("Exercises: ", exercises );
		}
		
		private function onTitleAnimFinished( pEvent : Event ) : void
		{			
			addChild( infoButton );	
			infoButton.addEventListener(InfoButton.ANIM_FINISHED, onInfoButtonAnimationFinished );
			infoButton.startAnim( );		
		}
		
		private function onInfoButtonAnimationFinished( pEvent : Event ) : void
		{			
			if( !lesson )
			{			
				createLesson( );
			
			}
			
			
		
		}
		
		private function createExercises( ) : void
		{
			var length : int = lesson.exercises.length;
			
			var actEx : ExerciseChooseCorrectAnswerMath;
			
			for (var i : int = 0; i < length; i++ )
			{
				actEx = lesson.exercises[i];
					
				actEx.createQuestionObject( );
				
				actEx.createAnswerObject( );
				
				actEx.addEventListener( AnswerEvent.ANSWER_CLICKED, onAnswerClicked );
			
				exerciseObjects.push( actEx );
				
			}	

		}
		
		private function showExercise( ) : void
		{
			actExercise =  exerciseObjects[actExerciseNumber];
			
			actExercise.fadeIn( );			
			
			trace("LessonUiProperties.maxWidth: ", LessonUiProperties.maxWidth );
			actExercise.x = infoButton.x + infoButton.width + (LessonUiProperties.maxWidth - actExercise.width )/2;
			actExercise.y = titleField.y + titleField.height + LessonUiProperties.paddingTop;
			
			//if( actExercise.y + actExercise.height < 
			
			addChild( actExercise );	
			
			
			if( actExerciseNumber == 0 && Lesson.needAnimationFrameAnimation )
			{
				infoField.startFadeIn();
				addChild( infoField );
				removeChild( infoButton );
			}
			
			
		}
			
		
		private function onAnswerClicked( pEvent : AnswerEvent) : void
		{
			if( pEvent.id == actExercise.goodAnswer )
			{
				trace("JO VALASZ");
				removeChild( actExercise );
				
				actExerciseNumber++;	
			
				goodAnswerNumber++;
				
				if( actExplanation )
				{
					actExplanation = null;
				}
				
				actExercise.removeEventListener( AnswerEvent.ANSWER_CLICKED, onAnswerClicked );
				actExercise = null;
				
				if( actExerciseNumber < exerciseObjects.length )
				{					
					showExercise( );
				}
				else
				{
					endAnimation = Lesson.endAnimation;
					
					endAnimation.setEndanim();
					
					addChild( endAnimation );
				}
			}
			else
			{
				badAnswerNumber++;
				
				trace("ROSSZ VALASZ");
				if( !actExplanation || actExplanation.isShowed == false )
				{
					actExplanation = new ExplanationObject( );
					
					actExplanation.setExplanationObject( pEvent.explanationText );
				}
				
				
				removeChild( actExercise );
				
				
				
				addChild( actExplanation );
				
				actExplanation.x = infoButton.x + infoButton.width + (LessonUiProperties.maxWidth - actExplanation.width )/2;
				actExplanation.y = titleField.y + titleField.height + (LessonUiProperties.maxHeight - actExplanation.height)/2;
				
				actExplanation.addEventListener( ExplanationObject.BACK_BUTTON_CLICKED, onBackButtonClicked );
			}
			
		}
		
		private function onBackButtonClicked( pEvent : Event ) : void
		{
			actExplanation.removeEventListener( ExplanationObject.BACK_BUTTON_CLICKED, onBackButtonClicked );
			removeChild( actExplanation );
			
			addChild( actExercise );
		}

		private function onInfoButtonClicked( pEvent : Event ) : void
		{
			if( buttonInfo.isClicked == true )
			{
				/*addChild( infoButton );
				infoButton.startAnim( );*/
			}
			else
			{
				removeChild( infoButton );
				infoField.startFadeIn();
				addChild( infoField );
				
			}
		}
		
		private function onInfoFieldFadedOut( pEvent : Event ) : void
		{
			infoButton.startAnim( );
			addChild( infoButton );
			removeChild( infoField );
		}
		
		private function onInfoFieldFadedIn( pEvent : Event ) : void
		{
			timer = new Timer(4000,1 );
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete );
			
			timer.start();
			
			
			
		}
		
		private function onTimerComplete( pEvent : TimerEvent ) : void
		{
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete );
			
			infoField.removeEventListener( InfoField.FADEIN_FINISHED, onInfoFieldFadedIn );
			
			
			infoField.startFadeOut();
		}
		
		private function onInfoCloseButtonClicked( pEvent : Event ) : void
		{
			infoField.startFadeOut( );
			buttonInfo.toggle( );
			
			if( timer.running ) 
			{
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete );
				timer.stop();
			}
		}
	
	}
}