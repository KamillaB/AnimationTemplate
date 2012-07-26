package util
{
	import flash.display.DisplayObject;
	import flash.display.Stage;

	public class DisplayObjectUtil
	{
		public static var stage : Stage;
		
		public static function getObjectByInstanceName( pInstanceName : String ) : DisplayObject
		{
			var displayObject : DisplayObject = stage.getChildByName( pInstanceName );
			
			return displayObject;
		}
	}
}