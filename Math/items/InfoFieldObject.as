package items
{
	import components.InfoFieldSkin;
	
	import properties.AnimationProperties;
	import properties.FrameProperties;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class InfoFieldObject extends InfoFieldSkin
	{
		public var fadeInProperties : AnimationProperties;
		public var fadeOutProperties : AnimationProperties;
		
		public var textPaddingLeft : int = 5;
		public var textPaddingTop : int = 20;
		public var posX : int = textPaddingLeft;
		public var posY : int = textPaddingTop;
		public var smallBackgroundAlignedToAnim : String = FrameProperties.BOTTOM_RIGHT;
		public var smallBAckgroundAutoFitToText : Boolean = true;
		public var textAlignedToCenter : Boolean = false;
		
		public var infoText : String;
		public var textFormat : TextFormat;
		
		private var props : Array = new Array( "fadeInProperties", "fadeOutProperties", "posX", "posY", "smallBackgroundAlignedToAnim", 
											   "smallBAckgroundAutoFitToText", "textPaddingLeft","textPaddingLeft","textAlignedToCenter", "infoText", "textFormat" );
		
		
		public function InfoFieldObject( pObject : InfoFieldObject = null )
		{
			if( pObject )
			{
				var actProperty : String;
				var length : int = props.length;
				
				for( var i : int = 0; i < length; i++ ) 
				{
					actProperty = props[i];
					
					if( pObject[actProperty] )
					{
						this[actProperty] = pObject[actProperty]
					}
					else
					{
						//trace("BackgroundObject.as: ", actProperty, "nincs megadva");
					}
				}
			}
			
			textfield.autoSize = TextFieldAutoSize.CENTER;
		}
	
	}
}