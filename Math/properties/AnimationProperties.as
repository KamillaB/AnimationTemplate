package properties
 {
	import fl.transitions.Tween;
	
	public class AnimationProperties
	{		
		public static const ANIM_FINISHED : String = "AnimationProperties.ANIM_FINISHED";
		
		public static const RIGHT_TO_LEFT : String = "AnimationProperties.RIGHT_TO_LEFT";
		public static const LEFT_TO_RIGHT : String = "AnimationProperties.LEFT_TO_RIGHT";
		
		public var apObj : Object;
		public var apProp : String;
		public var apFunc : Function;
		public var apBegin : Number;
		public var apFinish : Number;
		public var apDuration : Number;
		public var apUseSeconds : Boolean;
		
		public var apType : String;
		
		public function AnimationProperties( )
		{
			// constructor code
			
		}
		
		public function createTween( ) : Tween
		{
			var tween : Tween = new Tween( apObj, apProp, apFunc, apBegin, apFinish, apDuration, apUseSeconds );
			
			return tween;
		}
		
	}
	
}
