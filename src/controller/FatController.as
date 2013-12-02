package controller
{
	import model.ActiveExamList;
	import model.DataPersistence;
	import model.Exam;
	import model.ExamData;
	import model.ExamDataSet;
	import model.HTTPService;

	public class FatController
	{
		
		private var _dataPersistence:DataPersistence;
		private var _examData:ExamDataSet;
		private var _revisionApps:Object;
		private var _selectedExam:Exam;
		private var _getExamData:ExamData;
		private var _httpService:HTTPService;
		private var _activeExamList:ActiveExamList;
		private var _tipsIndex:int;
		
		
		//private var _names:ArrayCollection = new ArrayCollection();

		public function FatController():void
		{
			_dataPersistence = new DataPersistence();
			_httpService = new HTTPService();
			_httpService.fatcontroller = this;
			_httpService.setUp();
			_getExamData = new ExamData(this);
			_activeExamList= new ActiveExamList();
			
			
		}
		
		

		public function get tipsIndex():int
		{
			return _tipsIndex;
		}

		public function set tipsIndex(value:int):void
		{
			_tipsIndex = value;
		}

		public function get activeExamList():ActiveExamList
		{
			return _activeExamList;
		}

		public function get httpService():HTTPService
		{
			return _httpService;
		}

		public function get getExamData():ExamData
		{
			return _getExamData;
		}

		public function get selectedExam():Exam
		{
			return _selectedExam;
		}

		public function set selectedExam(value:Exam):void
		{
			_selectedExam = value;
		}

		public function get revisionApps():Object
		{
			return _revisionApps;
		}

		public function set revisionApps(value:Object):void
		{
			_revisionApps = value;
		}

		public function get dataPersistence():DataPersistence
		{
			return _dataPersistence;
		}

		public function set dataPersistence(value:DataPersistence):void
		{
			_dataPersistence = value;
		}

		/*public function get names():ArrayCollection
		{
			return _names;
		}

		public function set names(value:ArrayCollection):void
		{
			_names = value;
		}*/

		public function get examData():ExamDataSet
		{
			return _examData;
		}

		public function set examData(value:ExamDataSet):void
		{
			_examData = value;
		}

	}
}