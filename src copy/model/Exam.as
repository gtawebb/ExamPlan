package model
{
	public class Exam
	{
		private var _title:String;
		private var _board:String;
		private var _examCode:String;
		private var _examDuration:String;
		private var _date:String;
		private var _time:String;
		private var _notes:String;
		private var _session:String;
		
		
		
		public function Exam()
		{
		}

		public function get session():String
		{
			return _session;
		}

		public function set session(value:String):void
		{
			_session = value;
		}

		public function get notes():String
		{
			return _notes;
		}

		public function set notes(value:String):void
		{
			_notes = value;
		}

		public function get time():String
		{
			return _time;
		}

		public function set time(value:String):void
		{
			_time = value;
		}

		public function get date():String
		{
			return _date;
			
		}

		public function set date(value:String):void
		{
			if(value!=null)
			{
				var dateArray:Array=value.split(" ");
				dateArray[1]=String(dateArray[1]).substr(0,3)
				_date = dateArray.join(" ");
			}
			//trace("the date string ="+_date)
				
		}

		public function get examDuration():String
		{
			return _examDuration;
		}

		public function set examDuration(value:String):void
		{
			_examDuration = value;
		}

		public function get examCode():String
		{
			return _examCode;
		}

		public function set examCode(value:String):void
		{
			_examCode = value;
		}

		public function get board():String
		{
			return _board;
		}

		public function set board(value:String):void
		{
			_board = value;
		}

		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}

	}
}