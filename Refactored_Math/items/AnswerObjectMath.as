package items
{
	import components.Button;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import properties.Lesson;

	public class AnswerObjectMath extends Answer
	{
		public var explanationText : *;
		
		public var skin : ExerciseButtonSkin;
		
		public var id : int;
		
		public var minWidth : int;
		public var minHeight : int;
		
		public var object : DisplayObject;
		
		public var button : Button;
		
		public var sprite : Sprite;
		
		public var textfield : TextField;
		
		public function AnswerObjectMath( )
		{
			skin = new ExerciseButtonSkin( );
			
			sprite = new Sprite( );
			
			sprite.graphics.beginFill(0xFFCC00,0);
			sprite.graphics.drawRect(0, 0, 10, 10);
			sprite.graphics.endFill();
			
	
			addChild( skin );
			
			skin.removeChild( skin.hoverMc );
			
			button = new Button( this );
			button.registerListeners();
			
			button.addEventListener( Button.CLICKED, onAnswerClicked );
			//addEventListener( MouseEvent.MOUSE_OVER, onOver );
			//addEventListener( MouseEvent.MOUSE_OUT, onOut );
		}
		
		public function onAnswerClicked( pEvent : Event )
		{
			//trace("buttonClick");
			dispatchEvent( new AnswerEvent(AnswerEvent.ANSWER_CLICKED, id, explanationText ) );
		}
		
		public function setItem( pItem : DisplayObject ) : void
		{
			//textfield = pTextField;
			//trace("setItem:", pItem, object);
			if( pItem.width > skin.width )
			{
				//trace("Szelesebb a szoveg a background-nal");
			}
			else
			{
				pItem.x = (skin.hoverMc.width - pItem.width)/2;
				//trace("Keskenyebb a szoveg a background-nal",pItem.x);
			}
			
			if( pItem.height > skin.height )
			{
				//trace("Magasabb a szoveg a background-nal");
			}
			else
			{
				pItem.y = (skin.hoverMc.height - pItem.height)/2; 
				//trace("Alacsonyabb szoveg a background-nal",pItem.y);
			}
			
			object = pItem;
			
			addChild( pItem );
		
			
			addChild( sprite );
			
			sprite.width = width;
			sprite.height = height;
		}
	
		
		override public function set height(value:Number):void
		{
			skin.height = value;
			
			object.y = (skin.height - object.height)/2;
		}
		
		public function setSize( pWidth : Number, pHeight : Number ) : void
		{
			skin.width = pWidth+20
			sprite.width = pWidth+20;
			
			skin.height = pHeight+20;
			sprite.height= pHeight+20;
			
			object.x =  skin.hoverMc.x +(skin.width-object.width)/2;
			object.y = skin.y + (skin.height-object.height)/2;
		}
		
		public function onOver( ) : void
		{
		//	trace("onOver ", pEvent.target, pEvent.currentTarget);
			skin.addChild(skin.hoverMc);
		}
		
		public function onOut(  ) : void
		{
			//trace("onOver ", pEvent.target, pEvent.currentTarget);
			skin.removeChild(skin.hoverMc);
		}
	}
}