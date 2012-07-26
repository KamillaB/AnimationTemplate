package gui
{
	import components.Button;
	
	import fl.motion.easing.Linear;
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import items.AnswerObjectMath;
	import items.Exercise;
	
	import properties.Lesson;
	import properties.LessonUiProperties;
	
	import util.ArrayUtil;
	import util.Column;
	import util.Row;

	public class ExerciseChooseCorrectAnswerMath extends Exercise
	{		
		public var questionLine : Sprite;
		public var answers : Array;
		public var goodAnswer : int;
		
		public var explanationTexts : Array;
		
		public var questionUItems : Array;
		public var answerUiItems : Array;
		
		
		public function ExerciseChooseCorrectAnswerMath( )
		{
			question = new Array( );
			answers = new Array( );
			answerUiItems = new Array( );
			explanationTexts = new Array( );
			
			animationProperties.apObj = this;
			animationProperties.apDuration = 2;
			animationProperties.apUseSeconds = true;
			animationProperties.apFunc = Regular.easeOut;
			animationProperties.apProp = "alpha";
		}
		
		public function createQuestionObject( ) : void
		{
			var length : int = question.length;
			var actItem : *;
			var actTextField : TextField;
			var actLine : *;
			var startX : int = 0;
			var startY : int = 0;
			
			questionUItems = new Array( );
			
			questionLine = new Sprite();
			
		
			for( var i : int = 0; i < length; i++ )
			{
				actItem = question[i];
				
				if( actItem is String )
				{
					actTextField = new TextField( );
					actTextField.width = LessonUiProperties.maxWidth - 20;
					actTextField.text = actItem;
					actTextField.setTextFormat( LessonUiProperties.questionTextFormat );
					actTextField.autoSize = TextFieldAutoSize.CENTER;
					actTextField.selectable = false;
					questionLine.addChild( actTextField );
					
					actTextField.x = startX;
					actTextField.y = startY;
					
					questionUItems.push(actTextField);
					
					startY += questionLine.height+2;
				}
				else if( actItem is Row || actItem is Column)
				{
					
					actLine = actItem;
					
					actLine.setLine();				
					
					
					questionUItems.push(actLine);
					questionLine.addChild( actLine );
					
					actLine.x = 0;			
					actLine.y = startY;
					
					startY += questionLine.height+LessonUiProperties.spacing;
				}
				else
				{
					trace("invalid question");
				}
			}
			
			addChild( questionLine );
			
			if( length > 1 )
			{
				
				alignQuestionLineToCenter( )
			}
		
		}
		
		public function fadeIn( ) : void
		{
			animationProperties.apFinish = 1;
			animationProperties.apBegin = 0;
			
			var tween : Tween = animationProperties.createTween();
		}
		
		public function fadeOut( ) : void
		{
			animationProperties.apFinish = 0;
			animationProperties.apBegin = 1;
			
			var tween : Tween = animationProperties.createTween();
		}
		
		
		public function alignQuestionLineToCenter( ) : void
		{
		   		questionUItems.sortOn("width",Array.DESCENDING);
				
				var length : int = questionUItems.length;
				//var maxWidth : Number = questionUItems[length - 1].width;
				var actItem : *;
				var maxItem : * = questionUItems[0];
				
				for( var i : int = 0; i < length; i++ )
				{
					actItem = questionUItems[i];
					if( actItem != maxItem )
					{
						actItem.x = maxItem.x + (maxItem.width-actItem.width)/2;	
					}					
				}
				
		}
		
		
		public function createAnswerObject( ) : void
		{
			var length : int = answers.length;
			var actItem : *;
			var actTextField : TextField;
			var actLine : *;
		
			
			var actAnswerObj : AnswerObjectMath;
			var actAnswerButton : Button;
			var actExplanation : *;
			
			for( var i : int = 0; i < length; i++ )
			{
				actExplanation = explanationTexts[i];
				actItem = answers[i];
				
				actAnswerObj = new AnswerObjectMath( );
				actAnswerObj.id = i;
			/*	actAnswerButton = new Button( actAnswerObj );
				actAnswerButton.registerListeners( );*/
				
				if( actExplanation && i != goodAnswer )
				{
					actAnswerObj.explanationText = actExplanation;
					
					//trace("explan:",actExplanation);
				}				
				
				if( actItem is String )					
				{
					actTextField = new TextField( );
					
					actTextField.text = actItem;
					actTextField.setTextFormat( LessonUiProperties.answerTextFormat );
					actTextField.autoSize = TextFieldAutoSize.LEFT;
					actTextField.selectable = false;
					actAnswerObj.setItem( actTextField );
					//actAnswerObj.setTextField( actTextField );
					
					//trace("HUUUUUUUUUUU", act
				
				}
				else if( actItem is Row || actItem is Column)
				{
					actLine = actItem;
					
					actLine.setLine( );				
					
					actAnswerObj.setItem( actLine );
				}
				else
				{
					trace("invalid question");
				}
				
				//addChild( actAnswerObj );
				
				//actAnswerObj.addEventListener( AnswerEvent.ANSWER_CLICKED, onAnswerClicked );
				actAnswerObj.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
				actAnswerObj.addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
				
				answerUiItems.push( actAnswerObj );
				
			}
			
			setAnswerObjectsSize();
			showAnswers();
			alignToCenter();
			//setView();
		
		}
		
		public function showAnswers( ) : void
		{
			if( Lesson.shuffleAnswers == true )
			{
				answerUiItems = ArrayUtil.shuffle( answerUiItems );
			}
			
			var startX : int = 0;
			var startY : int = questionLine.y + questionLine.height + LessonUiProperties.paddingTop;
			var actAnswerObj : AnswerObjectMath;
			
			for( var i : int = 0; i < answerUiItems.length; i++ )
			{
				actAnswerObj = answerUiItems[i];
				
				addChild( actAnswerObj );
				
				actAnswerObj.y = startY;
				
				startY += actAnswerObj.height + LessonUiProperties.spacing;
				
			}
		}
		
		private function alignToCenter( ) : void
		{
			var actItem : AnswerObjectMath;
			
			for( var i : int = 0; i < answerUiItems.length; i++ )
			{			
				actItem = answerUiItems[i];
				
				if( questionLine.width > actItem.width )
				{
					//actItem.x = 0;
					actItem.x = (questionLine.width - actItem.width)/2;
				}
				else
				{
					//questionLine.x = 0;
					questionLine.x = (actItem.width - questionLine.width)/2;
				}
			}				
		}
		
		public function setView( ) : void
		{
			//trace("questionLine.x:", questionLine.x );
			questionLine.x = (width - questionLine.width)/2;
			
			//trace("questionLine.x:", questionLine.x, questionLine.width );
			
			var actItem : AnswerObjectMath = answerUiItems[answerUiItems.length-1];
			
			if(actItem.y + actItem.height > this.x + LessonUiProperties.maxHeight )
			{
				for( var i : int = 0; i < answerUiItems.length; i++ )
				{
					actItem =  answerUiItems[i];
					actItem.skin.height -= 10;
					actItem.y = questionLine.y + questionLine.height + LessonUiProperties.paddingTop - 10;
				}
				
			}
		}
		
		public function setAnswerObjectsSize( ) : void
		{
			var length : int = answerUiItems.length;
			
			var actItem : * = answerUiItems[0].object;
			var maxWidth : Number = actItem.width;
			var maxHeight : Number = actItem.height;
			
			for( var i : int = 1; i < length; i++ )
			{
				actItem =  answerUiItems[i].object;
				
				if( maxWidth < actItem.width )
				{
					maxWidth = actItem.width;
				}
				if( maxHeight < actItem.height )
				{
					maxHeight = actItem.height;
				}
				
				//actItem.y = questionLine.y + questionLine.height + LessonUiProperties.paddingTop - 10;
			}
			
			var actAnswer : AnswerObjectMath;
			for(i = 0; i < length; i++ )
			{
				actAnswer = answerUiItems[i];
				
				actAnswer.setSize( maxWidth, maxHeight );
			}
		}
		
		private function onMouseOver( pEvent : MouseEvent ) : void
		{
			
			pEvent.currentTarget.removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			pEvent.currentTarget.onOver( );
			//actAnswerObj.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			pEvent.currentTarget.addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
		}
		
		private function onMouseOut( pEvent : MouseEvent ) : void
		{
			//trace("hsbdflshgdblOOOOOOOOOOOOO",pEvent.currentTarget,pEvent.target);
			pEvent.currentTarget.onOut( );
			pEvent.currentTarget.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			pEvent.currentTarget.removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
		}
		
		/*private function onAnswerClicked( pEvent : AnswerEvent ) : void
		{
			trace("answered:",pEvent.target, pEvent.currentTarget );
			//pEvent.currentTargetdispatchEvent( new AnswerEvent( AnswerEvent.ANSWER_CLICKED, pEvent.id, pEvent.explanationText ));
			
			
		}*/
	}
}