package util
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import properties.Lesson;
	import properties.LessonUiProperties;
	
	public class Column extends Sprite
	{
		
		public var items : Array; 
		
		public var uiItems : Array;
		                                                                          
		public function Column()
		{
			items = new Array();
		}
		
		public function setLine( ) : void
		{
			var startX : int = 0;
			var startY : int = 0;
			
			var length : int = items.length;
			
			
			var actText : TextField;
			var actClass : *;
			//var actText : String;
			
			var actItem : *;
			
			uiItems = new Array();
			
			for( var i : int = 0; i < length; i++ )
			{
				actItem = items[i];
				
				if( actItem is String )
				{
					actText = new TextField( );
					
					addChild( actText );
					actText.text = actItem;
					
					//actText.width =Lesson.maxWidth - 2*LessonUiProperties.paddingLeft
					//actText.wordWrap = true;
					
					/*if( actText.width > Lesson.maxWidth - 2*LessonUiProperties.paddingLeft )
					{
						actText.wordWrap = true;
					}*/
					
					actText.setTextFormat( LessonUiProperties.questionTextFormat );
					actText.selectable = false;
					
					actText.autoSize = TextFieldAutoSize.CENTER;
					
					addChild( actText );
					actText.x = 0;
					actText.y = startY;
					
					startY += actText.height+5;						
					uiItems.push( actText );
				}
				else if( actItem is Class )
				{
					actClass = new actItem( );
					
					addChild( actClass );
					
					uiItems.push( actClass );
					actClass.y= startY;
					actClass.x = 0;
					startY += actClass.height+5;
				}
			}
			
			if( length > 1 )
			{
				updateLine( );
			}
			
			   
		}
		
		
		private function updateLine( ) : void
		{
			var maxWidth : Number;
			var actItem : *;
			
			var length : int = uiItems.length;
			
			var sortedA : Array = uiItems.sortOn("width", Array.DESCENDING);
			
			maxWidth = width;
			
			for( var i : int = 0; i < length; i++ )
			{
				actItem = uiItems[i];
			
				//if( actItem != maxWidth ) actItem.x = maxWidth.x+ (maxWidth.width - actItem.width)/2;
				
				actItem.x = (maxWidth - actItem.width)/2;
				
			
				
			}
			
		}
		
		public function resetItems( ) :  void
		{
			items = new Array();
		}
	}
}