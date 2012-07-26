package gui
{
	import components.Button;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import mx.core.IFlexAsset;
	
	import properties.Lesson;
	import properties.LessonUiProperties;
	
	import util.Column;
	import util.Row;

	/**
	 * The object is for the explanation. It sets the explanation to y = 0, the text is center aligned and the back button is under the text
	 * @author Kamesz
	 * 
	 */	
	public class ExplanationObject extends Sprite
	{
		public var isShowed : Boolean = false;
		public static const BACK_BUTTON_CLICKED : String = "ExplanationObject.BACK_BUTTON_CLICKED";
		
		private var explanationHolder : Sprite;
		
		//public var backBtn : Button;
		public var paddingLeft : int = 0;
		public var paddingRight : int = 0;
		public var paddingTop : int = 0;
		public var paddingBottom : int = 0;
		
		public var backBtn : *;
		
		public var explanation : Sprite;
		
		public var sprite : Sprite;
		
		public var button : Button;
		
		public var expHolder : Sprite;
		
	//	public function explanationHolder : Sprit;
		
		public function ExplanationObject( )
		{
			expHolder = new Sprite( );
			backBtn = new Lesson.backButtonClass( );
			
			(backBtn as Lesson.backButtonClass).removeChild( backBtn.hoverMc );
			
			sprite = new Sprite( );
			
			var sp : Sprite = new Sprite( );
			
			sp.graphics.beginFill(0xFFCC00,0);
			sp.graphics.drawRect(0, 0, backBtn.width, backBtn.height);
			sp.graphics.endFill();
			
			sprite.addChild( backBtn );
			
			var textField : TextField = new TextField();		
			textField.width = backBtn.width - 20;
			textField.autoSize = TextFieldAutoSize.CENTER;
			textField.text = LessonUiProperties.BACK_BUTTON_TEXT;
			textField.setTextFormat( LessonUiProperties.answerTextFormat );
			
			
			backBtn.width = (backBtn.width - textField.width )/2;
			backBtn.height =  (backBtn.height - textField.height )/2;
			
			
			
			if( textField.width < backBtn.width )
			{
				backBtn.x = 0;
				backBtn.y = 0;
				textField.x = (backBtn.width - textField.width )/2;
			}
			else
			{
				textField.x = 0;
				backBtn.x = (textField.width - backBtn.width )/2;
			}
			
			textField.y = (backBtn.height - textField.height )/2;
			textField.selectable = false;
			
			sp.width = backBtn.width;
			sp.height = backBtn.height;
			
			sprite.addChild( textField );
			sprite.addChild( sp );
			
			addChild( sprite );
							
			button = new Button( sprite );
			
			button.registerListeners();
			
			button.addEventListener( Button.CLICKED, onBackButtonClicked );
			sprite.addEventListener( MouseEvent.MOUSE_OVER, onBackButtonOver );
			sprite.addEventListener( MouseEvent.MOUSE_OUT, onBackButtonOut );
		}
		
		public function setExplanationObject( pObject : * ) : void
		{
			//var length : int = pArray.length;
			var actItem : *;
			var actTextField : TextField;
			var actLine : *;
			var startX : int = 0;
			var startY : int = 0;
			
			if( pObject is String )
			{
				actTextField = new TextField( );
			
				actTextField.width = LessonUiProperties.maxWidth - 20;
				//actTextField.autoSize = TextFieldAutoSize.CENTER;
			
				actTextField.text = pObject;
				
				if( actTextField.width > sprite.width )
				{
					actTextField.multiline = true;
					//actTextField.wordWrap = true;
					//actTextField.width  = sprite.width - 10;
				}
				actTextField.wordWrap = true;
				actTextField.setTextFormat( LessonUiProperties.questionTextFormat );
				actTextField.selectable = false;
				
				//trace("EXPLANATION", actTextField.width, actTextField.textWidth, sprite.width );
			
				
				expHolder.addChild( actTextField );
				actTextField.x = startX;
				actTextField.y = startY;
				
				startY += expHolder.height+2;
				
			} 
			else if( pObject is Row || pObject is Column)
			{
				//trace( "actItem is Line",startY);
			
				
				if( pObject is Row )
				{
					actLine = pObject as Row;
				}
				else
				{
					actLine = pObject as Column;
				}
				
				actLine.setLine();				
				
				expHolder.addChild( pObject );
				actLine.x= startY;
				actLine.y = startY;
				
				if( pObject.width > sprite.width )
				{
					
				}
				
				startY += expHolder.height+LessonUiProperties.spacing;
			}
			else
			{
				trace("invalid explanation", pObject);
			}
			
			addChild( expHolder );		
			
			expHolder.x = 0;
			sprite.x = expHolder.x + (expHolder.width - sprite.width )/2;
			sprite.y = expHolder.y + expHolder.height + LessonUiProperties.paddingTop;
		}
		
		private function onBackButtonClicked( pEvent : Event ) : void
		{
			dispatchEvent( new Event( ExplanationObject.BACK_BUTTON_CLICKED ) );
			isShowed = true;
		}
		
		private function onBackButtonOver( pEvent : MouseEvent ) : void
		{
			(backBtn as Lesson.backButtonClass).addChild( backBtn.hoverMc );
		}
		
		private function onBackButtonOut( pEvent : MouseEvent ) : void
		{
			(backBtn as Lesson.backButtonClass).removeChild( backBtn.hoverMc );
			
		}
		
		
	}
}