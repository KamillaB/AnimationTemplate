package items
{
	public class QuestionObjectMath
	{
		public static const FORMULA_ONLY : String = "QuestionObjectMath.FORMULA_ONLY";
		public static const FORMULA_AND_TEXT_IN_THE_SAME_LINE : String = "QuestionObjectMath.FORMULA_AND_TEXT_IN_THE_SAME_LINE";
		public static const FORMULA_BELOW_TEXT : String = "QuestionObjectMath.FORMULA_BELOW_TEXT";
		public static const FORMULA_ABOVE_TEXT : String = "QuestionObjectMath.FORMULA_ABOVE_TEXT";
		public static const FORMULAS_IN_THE_SAME_LINE : String= "QuestionObjectMath.FORMULAS_IN_THE_SAME_LINE";
		
		public var type : String;
		
		public var containsFormula : Boolean;
		public var texts : Array;
		
		public var formulaAligned : String;
		
		public function QuestionObjectMath( )
		{
			
		}
	}
}