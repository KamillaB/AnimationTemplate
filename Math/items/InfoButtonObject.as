package items
{
	import components.InfoButtonSkin;
	
	import flash.display.Sprite;
	
	import properties.AnimationProperties;

	public class InfoButtonObject extends InfoButtonSkin
	{
		public var posX : int = 5;
		public var posY : int = 355;
		
		public var infoButtonAnimation : AnimationProperties;
		
		private var props : Array = new Array( "posX","posY", "infoButtonAnimation");
			
		public function InfoButtonObject( pObject : InfoButtonObject = null )
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