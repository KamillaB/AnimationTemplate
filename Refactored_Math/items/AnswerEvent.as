package items
{
	import flash.events.Event;
	
	public class AnswerEvent extends Event
	{
		public static const ANSWER_CLICKED : String = "AnswerEvent.ANSWER_CLICKED";
		
		public var id : int;
		public var explanationText : *;
		
		public function AnswerEvent(type:String, pId : int, pExplanationText : * )
		{
			super(type,true);
			
			id = pId;
			explanationText = pExplanationText;
		}
	}
}