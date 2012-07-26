package components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	[Embed (source="/AnimationTemplateMath.swf" , symbol = "InfoFieldSkin" ) ]
	public class InfoFieldSkin extends Sprite
	{
		public var closeButtonSkin : MovieClip;
		public var infoFieldBackground : MovieClip;
		public var infoBackground : MovieClip;
		public var textfield : TextField;
		
		public function InfoFieldSkin()
		{
		}
	}
}