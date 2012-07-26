package gui
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import properties.LessonUiProperties;
	
	import util.Column;
	import util.Row;

	public class EndAnimation extends EndAnimationSkin
	{
		private var uiItems : Array;
		
		public var items : Array;
		
		public var itemHolder : Sprite;
		
		//public var backgroundMc : MovieClip;
		
		public function EndAnimation( )
		{
			uiItems = new Array( );
			items = new Array( );
			
			itemHolder = new Sprite( );
		}
		
		private function updateItems(  ) : void
		{			
			if( itemHolder.width > backgroundMc.width )
			{
				backgroundMc.width = itemHolder.width + 10;
				backgroundMc.x = (width - backgroundMc.width)/2;
			}
			
			if( itemHolder.height > backgroundMc.height - 10 )
			{
				backgroundMc.height = itemHolder.height +10;
				backgroundMc.y = (height - backgroundMc.height)/2;
			}
			
			itemHolder.x = backgroundMc.x + (backgroundMc.width - itemHolder.width)/2;
			itemHolder.y = backgroundMc.y + (backgroundMc.height - itemHolder.height)/2;;
		}
		
	public function setEndanim( ) : void
	{
		var length : int = items.length;
		var actItem : *;
		var actTextField : TextField;
		var actLine : *;
		var startX : int = 0;
		var startY : int = 0;
		
		for( var i : int = 0; i < length; i++ )
		{
			actItem = items[i];
			
			if( actItem is String )
			{
				actTextField = new TextField( );
				
				actTextField.text = actItem;
				actTextField.setTextFormat( LessonUiProperties.questionTextFormat );
				actTextField.autoSize = TextFieldAutoSize.LEFT;
				actTextField.selectable = false;
				itemHolder.addChild( actTextField );
				
				actTextField.x = startX;
				actTextField.y = startY;
				
				items.push(actTextField);
				
				startY += items.height+2;
			}
			else if( actItem is Row || actItem is Column)
			{
				
				actLine = actItem;
				
				actLine.setLine();				
				items.push(actTextField);
				itemHolder.addChild( actLine );
				
				actLine.x = 0;			
				actLine.y = startY;
				
				startY += LessonUiProperties.spacing;
			}
			else
			{
				trace("invalid question");
			}
		}
		
		addChild( itemHolder );
		
		updateItems();
		
		}
	}	
}