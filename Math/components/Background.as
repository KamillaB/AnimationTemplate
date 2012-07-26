package components
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import items.BackgroundObject;
	
	//[Embed(source='/AnimationTemplateMath.swf', symbol="Background")]
	public class Background extends BackgroundObject
	{
		public var backgroundSkin : DisplayObject;
		
		public function Background( pObject : BackgroundObject, pSkin : DisplayObject )
		{
			super( pObject );
			
			backgroundSkin = pSkin;
			
			addChild( backgroundSkin );		
		}
		
		public function resize( ) : void
		{
			
		}
		
		
	}
}