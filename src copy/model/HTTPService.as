package model
{
	
	
	import com.adobe.serialization.json.JSON;
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import controller.FatController;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	


	public class HTTPService extends EventDispatcher
	{
		
		private const GATEWAY:String = "http://www.gtawebb.co.uk/revisionBuddies/bin-debug/gateway.php";
		private var connection:NetConnection;
		
		private var getTimeTableResponder:Responder;
		private var _fatcontroller:FatController;
		
		private var timeTableRequestInProgress:Boolean = false;
		
		public static const GOT_TIMETABLE:String = "GOT_TIMETABLE";

		public function get fatcontroller():FatController
		{
			return _fatcontroller;
		}

		public function set fatcontroller(value:FatController):void
		{
			_fatcontroller = value;
		}

		public function setUp():void
		{
			loader = new URLLoader();
			configureListeners(loader);
			
			loader.dataFormat=URLLoaderDataFormat.TEXT;
			
			var request:URLRequest = new URLRequest("https://itunes.apple.com/search?term=revisionbuddies&country=us&entity=software");
			trace("try to load app data")
			try {
				loader.load(request);
			} catch (error:Error) {
				trace("Unable to load requested document.");
			}
			
			
			trace("setup monster")
			
			if(connection == null)
			{
				connection = new NetConnection;
				connection.httpIdleTimeout = 5000;
				connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				connection.connect(GATEWAY);
			}
			trace("!!!!!!!!!!!!!!!!!!!!      CONNECTION = "+connection);
			getTimeTableResponder = new Responder(getTimeTableResponder_resultHandler, onFault);
			MonsterDebugger.trace(this,getTimeTableResponder,"test");
		}
		
		
		private function netStatusHandler(event:NetStatusEvent):void {
			trace("!  event = "+event.info.code);
			switch (event.info.code) {
				case "NetConnection.Connect.Failed":
				case "NetConnection.Connect.Closed":
				case "NetConnection.Call.Failed":
				case "NetConnection.Call.BadVersion":
					//showNoConnectionPage();
					break;
			}
		}
		
		
		public function makeGetTimeTableCall():void
		{
			if(!timeTableRequestInProgress)
			{
				connection.call(Constants.SERVICE+".getTimeTable", getTimeTableResponder);
				timeTableRequestInProgress=true;
			}
			else
			{
				trace("-------------THERE'S ALREADY A CALL IN PROGRESS!-------------");
			}
		}
		
		protected function getTimeTableResponder_resultHandler(object:Object):void
		{
			
			//_fatController.detail = object[0].DESCRIPTION;
			trace("!!!!!!!!  POPULATE_DETAILS  dispatching the event")
			//dispatchEvent(new Event(POPULATE_DETAILS));
			var examData:ExamDataSet = new ExamDataSet();
			
			for (var i:int = 0; i < object.length; i++) 
			{
				var exam:Exam = new Exam();
				exam.board = object[i].Awarding_Body;
				exam.session = object[i].Session;
				exam.date = object[i].The_Date;
				exam.examCode = object[i].Exam_Code;
				exam.title = object[i].Title;
				exam.time = object[i].Start_Time;
				exam.examDuration = object[i].Duration;
				examData.exams.push(exam);
				
			
			}
			MonsterDebugger.trace(this, examData, "monster");
			_fatcontroller.examData = examData;
			
			dispatchEvent(new starling.events.Event(GOT_TIMETABLE));
			
			timeTableRequestInProgress=false;

		}
		
		
		public function onFault(object:Object):void
		{
			MonsterDebugger.trace(this,object,"monster");
			trace("we have a fault")
			trace(" !!!!  "+object);
			timeTableRequestInProgress=false;

		}
		
		
		private var loader:URLLoader;
		
		
		
		private function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(flash.events.Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(flash.events.Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		private function completeHandler(event:flash.events.Event):void {
			//var loader:URLLoader = URLLoader(event.target);
			trace("completeHandler: " + loader.data);
			var myData:Object = com.adobe.serialization.json.JSON.decode(loader.data);
			_fatcontroller.revisionApps=myData;
			
			//trace("encoded="+com.adobe.serialization.json.JSON.encode(myData))
		}
		
		private function openHandler(event:flash.events.Event):void {
			trace("openHandler: " + event);
		}
		
		private function progressHandler(event:ProgressEvent):void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
			timeTableRequestInProgress=false;
		}
		
		private function httpStatusHandler(event:HTTPStatusEvent):void {
			trace("httpStatusHandler: " + event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
			timeTableRequestInProgress=false;
		}
	}
}