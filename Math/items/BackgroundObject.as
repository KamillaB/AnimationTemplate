package items
{
	import flash.display.Sprite;
	
	import properties.FrameProperties;

	public class BackgroundObject extends Sprite
	{
		public var paddingLeft : int = 5;
		public var paddingRight : int = 5;
		public var paddingTop : int = 5;
		public var paddingBottom : int = 5;
		
		public var posX : int = paddingLeft;
		public var posY : int = paddingTop;
		
		public var autoFitToAnimSize : Boolean = false;
		public var usePadding : Boolean = false;
		public var instanceName = FrameProperties.backgroundMcSkinName;
		//public var useSettingsFromStage : Boolean = true;
		
		public var props : Array = new Array("posX","posY","paddingLeft","paddingRight","paddingTop","paddingBottom","autoFitToAnimSize","instanceName");
		
		//public var bgClass : Class;
		
		public function BackgroundObject( pObject : BackgroundObject = null )
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
			}//
		}
	}
}