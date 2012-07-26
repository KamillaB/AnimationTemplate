package util
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import properties.LessonUiProperties;

	public class Row extends Sprite
	{
		public var items : Array; 
		
		public var uiItems : Array;
		
		public function Row( )
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
					actText.text = actItem;
					actText.setTextFormat( LessonUiProperties.questionTextFormat );
					actText.selectable = false;
					
					actText.autoSize = TextFieldAutoSize.CENTER;
					
					addChild( actText );
					
					actText.x = startX;
					
					startX += actText.width+5;						
					uiItems.push( actText );
				}
				else if( actItem is Class )
				{
					actClass = new actItem( );
					
					addChild( actClass );
					
					uiItems.push( actClass );
					actClass.x = startX;
					startX += actClass.width+5;
				}
			}
			
			if( length > 1 )
			{
				updateLine( );
			}			
		}
		
		private function updateLine( ) : void
		{
			var maxHeight : DisplayObject;
			var actItem : *;
			
			var length : int = uiItems.length;

			uiItems.sortOn("height");
		
		//	maxHeight = (uiItems[ length - 1 ] as DisplayObject);
			
			for( var i : int = 0; i < length; i++ )
			{
				actItem = uiItems[i];
				actItem.y = (height - actItem.height)/2;		
			}
		
		}
		
		public function resetItems( ) :  void
		{
			items = new Array();
		}
	}
}