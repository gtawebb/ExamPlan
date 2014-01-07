package 
{
	
	
	import com.adobe.utils.DateUtil;
	import com.distriqt.extension.calendar.Calendar;
	import com.distriqt.extension.calendar.events.CalendarStatusEvent;
	import com.distriqt.extension.calendar.objects.EventAlarmObject;
	import com.distriqt.extension.calendar.objects.EventObject;
	import com.distriqt.extension.dialog.Dialog;
	
	import flash.net.registerClassAlias;
	import flash.text.ReturnKeyLabel;
	
	import controller.FatController;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.TabBar;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	
	import model.Exam;
	import model.ExamDataSet;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.text.BitmapFont;
	
	import themes.SpurnTheme;
	
	public class SearchSubjects extends Screen
	{
		
		
		
		public static const SearchSubjects:String = "SearchSubjects";
		protected var _fatController:FatController;
		private var myArrayCollection:ListCollection;
		private var list:List = new List();
		private var _font:BitmapFont;
		private var searchTextInput:TextInput;
		private var detailText:TextInput;
		private var filteredVector:Vector.<Exam>;
		private var examBoardsTabs:feathers.controls.TabBar;
		private var _mainTab:feathers.controls.TabBar;
		private var calBut:Button = new Button();

		
		private var _exam:Exam;
		private var filterBoard:String = "AQA";
		private var filterText:String = "";
		private var header:Header;
		private var backButton:Button;
		//private var myHttp:HTTPService;
		
		protected var theme:SpurnTheme;
		private var leaving:Boolean=false;
		private var e:EventObject;


		
		public function SearchSubjects()
		{
			super();
			//init();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, init);
			registerClassAlias("ExamDataSet", ExamDataSet);
			registerClassAlias("Exam", Exam);
			Calendar.service.addEventListener( CalendarStatusEvent.UI_SAVE, 	calendar_uiHandler, false, 0, true );
			Calendar.service.addEventListener( CalendarStatusEvent.UI_CANCEL,  	calendar_uiHandler, false, 0, true );
			Calendar.service.addEventListener( CalendarStatusEvent.UI_DELETE,  	calendar_uiHandler, false, 0, true );
		
			
		}
		
		private function destroy():void
		{
			this.owner.removeEventListener( FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );
			removeChild(header);
			removeChild(calBut);
			removeChild(detailText);
			removeChild(examBoardsTabs);
			removeChild(_mainTab);
			removeChild(list);
			removeChild(searchTextInput);
			searchTextInput=null;
			_mainTab=null;
			examBoardsTabs=null;
			detailText=null;
			calBut=null;
			header=null;
			backButton = null;
			myArrayCollection=null;
			filteredVector=null;
			list=null;
			myArrayCollection=null;
			e=null;
		}
		
		public function createCalendarBut():void
		{
			calBut = new Button();
			calBut.nameList.add( SpurnTheme.MY_CUSTOM_NORMAL_BUTTON);
			calBut.label = "Add";
			addChild( calBut );
			calBut.width = 80;
			calBut.height = 30;
			calBut.addEventListener(Event.TRIGGERED, checkIfExamIsAlreadyInCalendar);
			calBut.x = int((Constants.STAGE_WIDTH/100) *70);
			calBut.y = Constants.STAGE_HEIGHT * 0.80;
			calBut.validate();
		}
		
		
		
		private function checkIfExamIsAlreadyInCalendar():void
		{
			var isThere:Boolean = false;
			var event2:Vector.<EventObject> = _fatController.activeExamList.examsVector
			var title:String="EXAM: "+_exam.title+" : "+_exam.examCode;
			for (var J:int = event2.length-1; J >=0; J--) 
			{
				var evt2:EventObject=event2[J];
				if (evt2.title == title)
				{
					
					trace(" ---------------------ITEM IS ALREADY IN CALENDAR--------------------------");
					
					Dialog.service.showAlertDialog( 1, "Duplicate Exam!", "You've already added this exam, try adding a different one")
					isThere=true
				}
				
			}
			if(!isThere)
			{
				addToCalendar();
			}
		}
		
		
		private function addToCalendar():void
		{
			
			var calendarId:String = "";
			
			e = new EventObject();
		
			var myDate:Array = _exam.date.split(" ");
			
			var theDate:Date = new Date(int(myDate[2]),DateUtil.getShortMonthIndex(myDate[1]),int(myDate[0])) 
			
			e.title = "EXAM: "+_exam.title+" : "+_exam.examCode;
			e.startDate = theDate ;
			e.endDate = theDate ;
			e.notes = "Time: "+_exam.time+"\nDuration: "+_exam.examDuration+"\nCode: "+_exam.examCode+"\nBoard: "+_exam.board;
			var a:EventAlarmObject = new EventAlarmObject();
			a.offset = -561600;
			e.alarms.push( a );
			e.allDay=true;
			e.id="exam_"+_exam.examCode;
			
			e.calendarId = calendarId;
			
			trace( "ADDING: "+e.startDateString + " :: " + e.title );
			Calendar.service.addEventWithUI( e );
			
		}
		
		private function calendar_uiHandler( event:CalendarStatusEvent ):void
		{
			switch (event.type)
			{
								case CalendarStatusEvent.UI_SAVE:
									_fatController.activeExamList.examsVector.push(e);
									Dialog.service.showAlertDialog( 1, "Success", "The exam has now been added to your calendar as well as the My Exams section of this app.")
								case CalendarStatusEvent.UI_CANCEL:
								case CalendarStatusEvent.UI_DELETE:
									break;
				
				default:
					trace( event.type );
			}
		}
		
		
	
		private function editButton_changeHandler():void
		{
			var myArray:Array = ["AQA","EDEXCEL", "OCR", "WJEC" ]
			filterBoard = myArray[examBoardsTabs.selectedIndex];
			filteredVector = _fatController.examData.exams.filter(filterExam)
			//list.dataProvider = myArrayCollection = new ListCollection(_fatController.examData.exams);
			list.dataProvider = myArrayCollection = new ListCollection(filteredVector);
			trace(filterBoard);
			list.dispatchEvent(new starling.events.Event(starling.events.Event.CHANGE))
		}
		
		
		private function addHeader():void
		{
			header = new Header();
			header.width = Constants.STAGE_WIDTH;
			//header.height = (Constants.STAGE_HEIGHT/100)*10;
			header.title = "Search";
			
			this.addChild( header );
			backButton = new Button();
			backButton.label="Back";
			backButton.width=60;
			backButton.height=30;
			backButton.nameList.add( SpurnTheme.MY_CUSTOM_HEADER_BUTTON );
			backButton.addEventListener(starling.events.Event.TRIGGERED, backClicked)
			header.leftItems = new <DisplayObject>[ backButton ];
			header.validate();
		}
		
		private function backClicked():void
		{
			backButton.removeEventListener(starling.events.Event.TRIGGERED,backClicked);
			leaving=true
			//destroy();
			Root.REFRESH_EXAM_CALENDAR_LIST=true;
			this.owner.showScreen( Root.MENU );
			
		}			
		
		
		
		private function init():void
		{
			trace("----------------SEARCH VIEW INIT-----------------")
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, init);
			this.owner.addEventListener( FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );

			addHeader();
			makeExamBoards();
			addSearchInput();
			makeList();
			addDetailText();
			
			createCalendarBut();
			makeFooterTabs()
		}
		
		private function owner_transitionCompleteHandler():void
		{
			
			if(leaving)
			{
				destroy();
			}
			else
			{
				trace("----------------SEARCH VIEW TRANSITION COMPLETE-----------------")
				this.owner.removeEventListener( FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );
				_fatController = Root.FAT_CONTROLLER;
	
				
				_fatController.getExamData.getTimetable(populatetimeTable);
			}
			
			
		}
		
		
		public function populatetimeTable():void
		{
			filteredVector = _fatController.examData.exams.filter(initalFilterExam)
			list.dataProvider = myArrayCollection = new ListCollection(filteredVector);
			trace(_fatController.examData.exams);
			//examBoardsTabs.selectedIndex = 0;
			//_mainTab.selectedIndex = 0;
			list.selectedIndex=0;
			//makeList();
		}
		
		private function addSearchInput():void 
		{
			
			searchTextInput = new TextInput();
			searchTextInput.nameList.add( TextInput.ALTERNATE_NAME_SEARCH_TEXT_INPUT );
			//searchTextInput.nameList.add(SpurnTheme.ALTERNATE_NAME_MY_TEXT_INPUT);
			addChild(searchTextInput);
			searchTextInput.y=examBoardsTabs.y+examBoardsTabs.height;
			searchTextInput.addEventListener(starling.events.Event.CHANGE, textChanged)
			searchTextInput.width = Constants.STAGE_WIDTH;
			searchTextInput.height=(Constants.STAGE_HEIGHT/100)*10;
			searchTextInput.prompt="Type your exam here.."
			
			

		
			
			searchTextInput.addEventListener(FeathersEventType.ENTER, dismissKeyBoard)
			
		
			this.searchTextInput.textEditorProperties.returnKeyLabel = ReturnKeyLabel.GO;
		
			
			searchTextInput.validate();
		}
		
		private function dismissKeyBoard():void
		{
			// TODO Auto Generated method stub
			trace("hide")
			Starling.current.nativeStage.focus = Starling.current.nativeStage;
			//hiddenTextInput.setFocus();
		}
		
		private function addDetailText():void 
		{
			detailText = new TextInput();
			detailText.nameList.add( SpurnTheme.ALTERNATE_NAME_MY_TEXT_INPUT );
			this.addChild( this.detailText );
			detailText.width = Constants.STAGE_WIDTH;
			detailText.height = (Constants.STAGE_HEIGHT/100)*40;
			detailText.x = 0;
			detailText.y = list.y+ list.height;
			detailText.isEditable = false;
			
			
			detailText.validate();	
		}
		
		
		
		private function textChanged():void
		{
			// TODO Auto Generated method stub
			trace("changed");
			filterText  = searchTextInput.text;
			filteredVector = _fatController.examData.exams.filter(filterExam)
			//list.dataProvider = myArrayCollection = new ListCollection(_fatController.examData.exams);
			list.dataProvider = myArrayCollection = new ListCollection(filteredVector);
			
			list.dispatchEvent(new starling.events.Event(starling.events.Event.CHANGE));
		}
		
		
		
		private function filterExam(element:*, index:int, arr:Vector.<Exam>):Boolean {
			var myString:String = Exam(element).title.toLowerCase();
			var myBoard:String = Exam(element).board.toLowerCase();
			
			return myString.lastIndexOf(filterText.toLowerCase())>-1 && myBoard==filterBoard.toLowerCase();
		}
		private function initalFilterExam(element:*, index:int, arr:Vector.<Exam>):Boolean {
			
			var myString:String = Exam(element).title.toLowerCase();
			var myBoard:String = Exam(element).board.toLowerCase();
			
			var myDate:Date=new Date(Exam(element).date);
			//trace("myDate = "+myDate)
			return myString.lastIndexOf(filterText.toLowerCase())>-1 && myBoard==filterBoard.toLowerCase() && myDate>new Date();
		}
		
		
		
		private function makeExamBoards():void
		{
			this.examBoardsTabs = new feathers.controls.TabBar;
			examBoardsTabs.dataProvider=new ListCollection(["AQA","EDEXCEL", "OCR", "WJEC" ])
			//this.examBoardsTabs. = true;
			//this.examBoardsTabs.label = "Edit";
			this.examBoardsTabs.addEventListener(starling.events.Event.CHANGE, editButton_changeHandler);
			
			examBoardsTabs.height=(Constants.STAGE_HEIGHT/100)*7;
			examBoardsTabs.y = header.height
			examBoardsTabs.width = Constants.STAGE_WIDTH;
			examBoardsTabs.validate();
			addChild(examBoardsTabs);
		}
		
		
		
		private function makeFooterTabs():void
		{
			
			this._mainTab = new feathers.controls.TabBar;
			_mainTab.dataProvider=new ListCollection(["SEARCH","MANUAL" ])
			this._mainTab.addEventListener(starling.events.Event.CHANGE, editButton_changeHandler);
			_mainTab.height=(Constants.STAGE_HEIGHT/100)*10;
			_mainTab.y  =Constants.STAGE_HEIGHT - int((Constants.STAGE_HEIGHT/100) *9);
			_mainTab.width = Constants.STAGE_WIDTH;
			
			_mainTab.validate();
		}
		
		
		private function makeList():void
		{
			list.width = Constants.STAGE_WIDTH;
			list.height =  (Constants.STAGE_HEIGHT/100)*37;
			list.x = 0;
			list.y = searchTextInput.y+searchTextInput.height;
			list.scrollBarDisplayMode = List.SCROLL_BAR_DISPLAY_MODE_FLOAT;
			
			list.horizontalScrollPolicy = List.SCROLL_POLICY_OFF;
			list.itemRendererFactory = tileListItemRendererFactory;
			
			list.addEventListener( starling.events.Event.CHANGE, list_changeHandler );
			this.addChild( this.list );
		}
		
		private function list_changeHandler( event:starling.events.Event =null):void
		{
			//var list:List = List( event.currentTarget );
			//var currentIndx:int = list.selectedIndex;
			trace("changes, event = "+event);
			
			if(event!=null)
			{
				_exam = Exam(list.selectedItem);
				if(_exam)
				{
					detailText.text = "\n<b>Title: </b>"+_exam.title + "\n<b>Board: </b>"+_exam.board +"\n<b>Date: </b>"+_exam.date+"\n<b>Time: </b>"+_exam.time+"\n<b>Duration: </b>"+_exam.examDuration+"\n<b>Code: </b>"+_exam.examCode;
					calBut.visible=true;
				}
				else
				{
					detailText.text="";
					calBut.visible=false;
				}
			}
			else
			{
				//detailText.text="Select an item";
				calBut.visible=false;
			}
			//trace( "selectedIndex:", Exam(selectedItem).examCode );
			
		}
		
		
		
	
		
		protected function tileListItemRendererFactory():IListItemRenderer
		{
			const renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = "title";
			renderer.iconSourceField = "texture";
			return renderer;
		}
		
	
		
	}
}