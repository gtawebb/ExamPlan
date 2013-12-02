package model
{
	import controller.FatController;

	public class ExamData
	{
		public var _fatController:FatController;
		private var myHttp:HTTPService;
		private var _populatetimeTable:Function=null;
		
		
		public function ExamData(fatC)
		{
			_fatController=fatC;
			myHttp = _fatController.httpService;
			myHttp.addEventListener(HTTPService.GOT_TIMETABLE, dataRecieved);
		}
		
		private function returnData():void
		{
			if(_populatetimeTable!=null)
			{
				_populatetimeTable();
			}
		}
		
		public function getTimetable(populatetimeTable:Function=null):void
		{
			_populatetimeTable=populatetimeTable;
			if(_fatController.examData)
			{
				trace("we already have the data")
				returnData();
			}
			else
			{
				trace("there is no data")
				makeHHTPCall()
			}
			
		
		}
		
		private function makeHHTPCall():void
		{
			
			myHttp.makeGetTimeTableCall();
			
		}
		
		private function dataRecieved():void
		{
			trace("data recieved")
			myHttp.removeEventListener(HTTPService.GOT_TIMETABLE, dataRecieved);
			getDataPersistenceManager().saveData(_fatController.examData, "EXAM_DATA");
			returnData();
		}
		
		private function getDataPersistenceManager():DataPersistence
		{
			return _fatController.dataPersistence;
		}
		
	}
}