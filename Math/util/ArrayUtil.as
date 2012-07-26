package util
{
	public class ArrayUtil
	{
		public static function shuffle( pOrigArray : Array ) : Array
		{
			var swap : uint;
			var temp : *;
			
			if( pOrigArray.length == 2 )
			{
				var j : Number = Math.random()*100;
			
				if( j < 50 )
				{
					temp = pOrigArray[0];
					pOrigArray[0] = pOrigArray[1];
					pOrigArray[1] = temp;
				}
				
				return pOrigArray;
			}
			
			for( var i : int = pOrigArray.length-1; i > 0; i-- )
			{
				swap = Math.floor( Math.random()*i );
				temp = pOrigArray[i];
				
				pOrigArray[i] = pOrigArray[swap];
				pOrigArray[swap] = temp;
			}	
			
			return pOrigArray;
		}
	}
}