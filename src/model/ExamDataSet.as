package model
{
	

	
	public class ExamDataSet
	{
		private var _exams:Vector.<Exam> = new Vector.<Exam>();
		
		
		public function ExamDataSet()
		{
			
		}

		public function get exams():Vector.<Exam>
		{
			return _exams;
		}

		public function set exams(value:Vector.<Exam>):void
		{
			_exams = value;
		}

	}
}