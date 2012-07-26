package items
{
	import flash.display.Sprite;
	
	import properties.AnimationProperties;
	

	public class Exercise extends Sprite
	{
		
		public var question : *;
		
		/**
		 * How many answers are for the question 
		 */		
		public var answerNumber : int;
		
		/**
		 * The number of the correct answer 
		 */		
		public var correctAnswer : int;
		
		public var animationProperties : AnimationProperties = new AnimationProperties();
				
		public function Exercise( )
		{
			
		}
	}
}