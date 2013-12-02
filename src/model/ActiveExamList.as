package model
{
	import com.distriqt.extension.calendar.objects.EventObject;

	public class ActiveExamList
	{
		private var _examsVector:Vector.<EventObject>;
		
		public function ActiveExamList()
		{
			
		}
		
		

		public function get examsVector():Vector.<EventObject>
		{
			return _examsVector;
		}

		public function set examsVector(value:Vector.<EventObject>):void
		{
			_examsVector = value;
		}

	}
}