package components
{
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class Title extends TextfieldSkin
	{		
		public function Title(  )
		{
			textfield.autoSize = TextFieldAutoSize.LEFT;
		}		
		
		public function setFormat( pFormat : TextFormat ) : void
		{
			textfield.setTextFormat( pFormat );
		}
	}
}