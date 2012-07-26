package items
{
	import components.Background;
	import components.TitlefieldSkin;
	
	import properties.AnimationProperties;

	public class TitleFieldObject extends TitlefieldSkin
	{
		public var titleAnimationProperties : AnimationProperties; 
		//public var containsLogo : Boolean;
		
		public var titleTexts : Array;
		
		public var resizeLogoWhenNeeded : Boolean = true;
		public var titlesPaddingLeft : int = 50;
		public var paddingTop : int = 20;
		public var autoFitToBackground : Boolean = true;
		public var autoFitToTitles : Boolean = true;
		public var titleSpacing : int = -1;
		
		public var maxHeight : int = 200;
		
		public var posX : int = 40;
		public var posY : int = paddingTop;
		
		//milyen idokozonkent inditja az animaciokat (secundumban);
		public var animationDelay : int = 1;
		
		private var props : Array = new Array("titleAnimationProperties","titleTexts","resizeLogoWhenNeeded","titlesPaddingLeft", "posX", 
											  "posY", "autoFitToBackground", "maxHeight","autoFitToTitles", "paddingTop","titleFieldTextFormats","titleSpacing","animationDelay");
		
		public var titleFieldTextFormats : Array;
		
		public function TitleFieldObject( pObject : TitleFieldObject = null )
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
						//trace("TitleFieldObject.as: ", actProperty, "nincs megadva");
					}
				}
			}//
			
		}
		
	}
}