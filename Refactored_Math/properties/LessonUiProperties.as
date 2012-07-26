package properties
{
	import flash.text.TextFormat;

	public class LessonUiProperties
	{
		public static var questionTextFormat : TextFormat;
		public static var answerTextFormat : TextFormat;
		
		public static var BACK_BUTTON_TEXT : String = "Visszalépés";
		
		public static var maxWidth : Number;
		public static var maxHeight : Number;
		
		public static var paddingTop : int = 20;
		public static var paddingLeft : int = 5;
		public static var spacing : int = 20;
		public static var minSpacing : int = 10;
						
		public function LessonUiProperties()
		{
			questionTextFormat = new TextFormat( );
			
			questionTextFormat.font = "Tahoma";
			questionTextFormat.align = "center";
			questionTextFormat.color = 0x666666;
			questionTextFormat.size = 12;
			
			answerTextFormat = questionTextFormat;
		}
	}
}