package
{
    import com.distriqt.extension.calendar.Calendar;
    import com.distriqt.extension.calendar.events.CalendarStatusEvent;
    import com.distriqt.extension.calendar.objects.EventObject;
    import com.distriqt.extension.dialog.Dialog;
    import com.distriqt.extension.dialog.events.DialogEvent;
    
    import flash.display.BitmapData;
    import flash.utils.Dictionary;
    
    import controller.FatController;
    
    import feathers.controls.Button;
    import feathers.controls.ButtonGroup;
    import feathers.controls.Header;
    import feathers.controls.List;
    import feathers.controls.Screen;
    import feathers.controls.ScrollContainer;
    import feathers.controls.Scroller;
    import feathers.controls.TextInput;
    import feathers.controls.ToggleSwitch;
    import feathers.controls.renderers.DefaultListItemRenderer;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.events.FeathersEventType;
    import feathers.layout.HorizontalLayout;
    
    import model.DataPersistence;
    import model.Exam;
    import model.HTTPService;
    
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Quad;
    import starling.events.Event;
    import starling.textures.Texture;
    
    import themes.SpurnTheme;
    
    /** The Menu shows the logo of the game and a start button that will, once triggered, 
     *  start the actual game. In a real game, it will probably contain several buttons and
     *  link to several screens (e.g. a settings screen or the credits). If your menu contains
     *  a lot of logic, you could use the "Feathers" library to make your life easier. */
    public class Menu extends Screen
    {
        public static const START_GAME:String = "startGame";
		
		protected var theme:SpurnTheme;
		private var list:List;
		private var itemsToDelete:Vector.<String>;
		private var examsVector:Vector.<EventObject>;
		private var header:Header;
		private var headingText:TextInput;
		private var detailText:TextInput;
		private var _editing:Boolean=false;
		private var cachedAccessories:Dictionary=new Dictionary();
		private var editButton:Button;
		private var listData:ListCollection;
		private var container:ScrollContainer;
		protected var _fatController:FatController;
		private var myHttp:HTTPService;
		private var iconTexture:Texture;
		private var iconImage:Image;
		private var tabs:ButtonGroup;
		private var square:Quad;

		private var debug:Boolean=false;
		private var leaving:Boolean=false;
        
        public function Menu()
        {
		
			itemsToDelete = new Vector.<String>;
			
			this.theme = new SpurnTheme(this.stage);
			
			Dialog.service.addEventListener( DialogEvent.DIALOG_CLOSED, dialog_dialogClosedHandler, false, 0, true );
			Dialog.service.addEventListener( DialogEvent.DIALOG_CANCELLED, dialog_dialogCancelledHandler, false, 0, true );
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, init);
			_fatController = Root.FAT_CONTROLLER;
			
			
			
        }
		
		private function owner_transitionCompleteHandler():void
		{
			if(leaving)
			{
				destroy();
			}
			else
			{
				// TODO Auto Generated method stub
				trace("inti");
				/*MonsterDebugger.initialize(this);
				MonsterDebugger.enabled=true;
				MonsterDebugger.trace(this, "StarlingWorld");*/
				
				trace(" ---------------------TRANSITION COMPLETE--------------------------")
				createTabBar();
				
				getExams();
				addList();
				_fatController.getExamData.getTimetable();
			}
			
		}
		
		
		private function getDataPersistenceManager():DataPersistence
		{
			return _fatController.dataPersistence;
		}
		
		
		
		private function calendar_accessGrantedHandler( event:CalendarStatusEvent ):void
		{
			trace( "GRANTED" );
			
			
			
			
			
		}
		
		
		private function calendar_accessDeniedHandler( event:CalendarStatusEvent ):void
		{
			trace( "DENIED" );
		}
		
		private function init():void
		{
			this.owner.addEventListener( FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );
		
			trace(" ---------------------INIT--------------------------")
			addHeader();
			addTitleBox();
			addHeadingText();
			addIcon();
		}
		
		private function destroy():void
		{
			removeChildren();
			list.removeEventListener( starling.events.Event.CHANGE, list_changeHandler );
			list.removeEventListener( starling.events.Event.RESIZE, list_changeHandler );
			Dialog.service.removeEventListener( DialogEvent.DIALOG_CLOSED, dialog_dialogClosedHandler);
			Dialog.service.removeEventListener( DialogEvent.DIALOG_CANCELLED, dialog_dialogCancelledHandler);
			editButton.addEventListener(starling.events.Event.TRIGGERED, editClicked);
			iconImage.dispose();
			editButton=null;
			square=null;
			tabs=null;
			detailText=null;
			iconImage=null;
			container=null;
			header=null;
			list=null;
			iconTexture=null;
			headingText=null;
			listData=null;
			_fatController=null;
			
			this.owner.removeEventListener( FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );
		}
		
		private function oncalButTriggered():void
		{
			
			Calendar.service.requestAccess();
			
			
			
		}
		
		private function calendar_uiHandler( event:CalendarStatusEvent ):void
		{
			switch (event.type)
			{
				//				case CalendarStatusEvent.UI_SAVE:
				//				case CalendarStatusEvent.UI_CANCEL:
				//				case CalendarStatusEvent.UI_DELETE:
				//					break;
				
				default:
					trace( event.type );
			}
		}
		
		private function removeExams():void
		{
			
			var startDate:Date = new Date();
			startDate.date -= 0;
			var endDate:Date = new Date();
			endDate.date += 365;
		
			var events:Array = Calendar.service.getEvents( startDate, endDate  );
			
			for each (var evt:EventObject in events)
			{
				trace( "["+evt.id+"] in "+evt.calendarId+" @ "+ evt.startDateString + " :: " + evt.title );
				for (var i:int = 0; i < itemsToDelete.length; i++) 
				{
					trace("examTitle="+itemsToDelete[i]+" and evt.title= "+evt.title)
					if (evt.title == itemsToDelete[i])
					{
						trace( "Found: "+evt );
						Calendar.service.removeEvent( evt );
						
					}
				}
			}
			var event2:Vector.<EventObject> = _fatController.activeExamList.examsVector
				
			for (var J:int = event2.length-1; J >=0; J--) 
			{
				var evt2:EventObject=event2[J];
				
				for (var k:int = itemsToDelete.length-1; k >=0; k--) 
				{
					if (evt2.title == itemsToDelete[k])
					{
						trace( "Found: "+evt2 );
						trace(" ---------------------REMOVING ITEM AT "+J+"--------------------------")
						event2.splice(J,1);
						
					}
				}
				
				
			}
			getExams();
			
		}
		
		
		private function getExams():void
		{
			if(_fatController.activeExamList.examsVector==null)
			{
				
				trace(" ---------------------RETRIEVING EXAMS FROM THE CALANDAR--------------------------")
			
			
				examsVector = new Vector.<EventObject>;
				var startDate:Date = new Date();
				startDate.date -= 0;
				var endDate:Date = new Date();
				endDate.date += 365;
				
				var events:Array = Calendar.service.getEvents( startDate, endDate  );
				
				for each (var evt:EventObject in events)
				{
					trace( "["+evt.id+"] in "+evt.calendarId+" @ "+ evt.startDateString + " :: " + evt.title );
					
					if (evt.title.substr(0,5) == "EXAM:")
					{
						trace( "Found: "+evt );
						
						examsVector.push(evt);
						
						//Calendar.service.removeEvent( evt );
						
					}
				}
				
			
				_fatController.activeExamList.examsVector=examsVector;
			}
			else
			{
				trace(" ---------------------RETRIEVING EXAMS FROM CACHE--------------------------")

				examsVector = _fatController.activeExamList.examsVector;
			}
			if(debug)
			{
				listData= new ListCollection(
					[
						{ title: "Plan" },
						{ title: "Prepare" },
						{ title: "Revise" },
					]);
			}
			else
			{
				listData=new ListCollection(examsVector);
			}
			
		}
		
		private function addList():void
		{
			list = new List();
			list.width = Constants.STAGE_WIDTH;
			list.height =  (Constants.STAGE_HEIGHT/100)*64 - header.height;
			list.x = 0;
			list.y =  detailText.y+detailText.height;
			this.addChild( this.list );
			list.scrollBarDisplayMode = List.SCROLL_BAR_DISPLAY_MODE_FLOAT;
			
			list.horizontalScrollPolicy = List.SCROLL_POLICY_OFF;
			list.itemRendererFactory = tileListItemRendererFactoryForText;
			
		//	list.dataProvider =  new ListCollection(examsVector);
			
			list.dataProvider = listData;
			
			list.addEventListener( starling.events.Event.CHANGE, list_changeHandler );
			list.addEventListener( starling.events.Event.RESIZE, list_changeHandler );
			
			
			//list.selectedIndex = 0;
			
		}
		
		private function strReplace(str:String, search:String, replace:String):String {
			return str.split(search).join(replace);
		}
		
		private function list_changeHandler( event:starling.events.Event =null):void
		{
			//var list:List = List( event.currentTarget );
			//var currentIndx:int = list.selectedIndex;
			trace("changes, event = "+event);
			
			var _exam:EventObject = EventObject(list.selectedItem);
			Root.FAT_CONTROLLER.selectedExam=new Exam();
			
			var newDate:Date = new Date(_exam.startDate.getTime()+3600000);
			
			var dateString:String = String(newDate.day)+" "+String(newDate.getDate())+ " "+String(newDate.getMonth())+" "+String(newDate.getFullYear());
			
			
			_exam.notes=strReplace(_exam.notes, "Time", "<b>Time</b>");
			_exam.notes=strReplace(_exam.notes, "Duration", "<b>Duration</b>");
			_exam.notes=strReplace(_exam.notes, "Code", "<b>Code</b>");
			_exam.notes=strReplace(_exam.notes, "Board", "<b>Board</b>");
				
			
			Root.FAT_CONTROLLER.selectedExam.title = _exam.title;
			Root.FAT_CONTROLLER.selectedExam.date = _exam.startDate.toLocaleDateString();
			Root.FAT_CONTROLLER.selectedExam.notes = _exam.notes;
			
			if(event!=null)
			{
				
				if(_exam)
				{
					//detailText.text = "<b>Title: </b>"+_exam.title + "\n<b>Date: </b>"+dateString+"\n"+_exam.notes;
					
				}
				else
				{
					//detailText.text="";
					
				}
			}
			else
			{
				detailText.text="Select an item";
				
			}
			//trace( "selectedIndex:", Exam(selectedItem).examCode );
			//destroy();
			leaving=true;
			this.owner.showScreen( Root.EXAM_DETAIL);
		}
		
		private function addHeader():void
		{
			header = new Header();
			header.width = Constants.STAGE_WIDTH;
			//header.height = (Constants.STAGE_HEIGHT/100)*10;
			header.title = "My Exams";
			
			this.addChild( header );
			editButton = new Button();
			editButton.label="Edit";
			editButton.width=60;
			editButton.height=30;
			editButton.nameList.add( SpurnTheme.MY_CUSTOM_HEADER_BUTTON );
			editButton.addEventListener(starling.events.Event.TRIGGERED, editClicked)
			header.rightItems = new <DisplayObject>[ editButton ];
			
			
			header.validate();
		}
		
		private function editClicked():void
		{
			if(!_editing)
			{
				editButton.label="Finish";
				_editing=true;
				list.itemRendererFactory = tileListItemRendererFactoryForToggle;
			}
			else
			{
				if(itemsToDelete.length>0)
				{
					
					//
					//trace( "showAlertDialog("+titleString+","+messageString+","+cancelLabel+","+otherLabels.join(",")+")");
					Dialog.service.showAlertDialog( 0, "Delete Exams", "Do you want to delete all the exams marked DELETE from My Exams and your phone calendar", "Cancel", new Array("OK") );
				}
				else
				{
					editButton.label="Edit";
					_editing=false;
					list.itemRendererFactory = tileListItemRendererFactoryForText;
					itemsToDelete = new Vector.<String>;
					list.dataProvider = listData;
				}
			}
		}			
		
		private function countDays( startDate:Date, endDate:Date ):int 
		{ 
			var oneDay:int = 24*60*60*1000; // hours*minutes*seconds*milliseconds 
			var diffDays:int = Math.round(Math.abs((startDate.getTime() - endDate.getTime())/(oneDay))); 
			return diffDays+1; 
		} 
		
		
		protected function tileListItemRendererFactoryForToggle():IListItemRenderer
		{
			const renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = "title";
			//renderer.@accessoryLabelProperties.textFormat = new TextFormat( "Helvetica", 18, 0xFFFFFF, true );
			
			var date:Date=new Date();
			

			
			renderer.accessoryFunction = function( item:Object ):DisplayObject
			{
				if(item in cachedAccessories)
				{
					return cachedAccessories[item];
				}
				var accessory:DisplayObject = createAccessoryForItem( item );
				cachedAccessories[item] = accessory;
				return accessory;
			};
		
			return renderer;
		}
		
		protected function tileListItemRendererFactoryForText():IListItemRenderer
		{
			const renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			//renderer.labelField = "title";
			
			//renderer.@accessoryLabelProperties.textFormat = new TextFormat( "Helvetica", 18, 0xFFFFFF, true );
			
			
			renderer.labelFunction = function( item:Object ):String
			{
				var length:int = EventObject(item).title.length-6;
				return EventObject(item).title.substr(6,length);
			};

			var date:Date=new Date();
		
			
			renderer.accessoryLabelFunction = function( item:Object ):String
			{
			var dueDate:Date	
			if(debug)
			{
				dueDate = new Date();
			}
			else
			{
				dueDate = new Date(EventObject(item).startDate.getTime()+3600000);
			}
			
			return String(countDays(date, dueDate))+" days to go!";
			};
			
			return renderer;
		}
		
		
		
		
		private function createAccessoryForItem( item:Object ):DisplayObject 
		{
			
			var toggle:ToggleSwitch = new ToggleSwitch();
			toggle.isSelected = true;
			toggle.offText = "DELETE";
			toggle.onText = "KEEP";
			toggle.addEventListener( Event.CHANGE, toggle_changeHandler );
			return toggle as DisplayObject;
			
		}
		
		
		private function toggle_changeHandler(e:Event):void 
		{
			var toggle:ToggleSwitch = ToggleSwitch( e.currentTarget );
			trace( "toggle.isSelected changed:", toggle.isSelected );
			trace("itemsToDelete1 = "+itemsToDelete);
			if(!toggle.isSelected)
			{
				itemsToDelete.push(examsVector[DefaultListItemRenderer(toggle.parent).index].title);
			}
			else
			{
				
				itemsToDelete.splice(itemsToDelete.indexOf(examsVector[DefaultListItemRenderer(toggle.parent).index].title), 1);
				//trace(itemsToDelete);
			}
			trace("itemsToDelete2 = "+itemsToDelete);

			
		}
		
		private function addTitleBox():void 
		{
			container = new ScrollContainer();
			container.backgroundSkin=new Image(Texture.fromBitmapData(new BitmapData(1,1,false,0xffffff)));
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.gap = 10;
			container.horizontalScrollPolicy=Scroller.SCROLL_POLICY_OFF
			container.verticalScrollPolicy=Scroller.SCROLL_POLICY_OFF
			container.width=Constants.STAGE_WIDTH;
			container.paddingLeft=7;
			container.paddingBottom=7;
			container.paddingTop=7;
			container.paddingRight=7;
			container.layout = layout;
			container.y=header.height;
			this.addChild( container );
			
		}
		private function addIcon():void 
		{
			iconTexture = Root.assets.getTexture("icon");
			iconImage=new Image(iconTexture);
			iconImage.addEventListener(starling.events.Event.ADDED_TO_STAGE,iconAdded);
			container.validate();
			container.addChild(iconImage);
		}
		
		private function iconAdded():void
		{
			// TODO Auto Generated method stub
			trace("container.height123="+container.height)
			iconImage.removeEventListener(starling.events.Event.ADDED_TO_STAGE,iconAdded);

			addAdviceText();
		}
		
		private function addHeadingText():void 
		{
			headingText = new TextInput();
			headingText.nameList.add( SpurnTheme.HEADING_TEXT_AREA );
			container.addChild( this.headingText );
			//headingText.backgroundSkin = new Image(Texture.fromBitmapData(new BitmapData(1,1,false,0xffffff)));
			headingText.width = (Constants.STAGE_WIDTH/10)*7;
			headingText.height = (Constants.STAGE_HEIGHT/100)*15;
			//headingText.paddingTop=7;
			
			
			headingText.isEditable = false;
			
			headingText.text="REVISON BUDDIES GCSE EXAM PLANNER"; 
			
			headingText.validate();	
		}
        
		private function addAdviceText():void 
		{
			detailText = new TextInput();
			detailText.nameList.add( SpurnTheme.PARA_TEXT_AREA );
			this.addChild( this.detailText );
			//detailText.backgroundSkin = new Image(Texture.fromBitmapData(new BitmapData(1,1,false,0xffffff)));
			detailText.width = (Constants.STAGE_WIDTH);
			detailText.height = (Constants.STAGE_HEIGHT/100)*10;
			detailText.x = 0;
			trace("container.height123="+container.height)
			detailText.y = container.y+container.height;
			detailText.isEditable = false;
			
			detailText.text="Click on an exam below to view details, to add more exams click the Plan button"; 
			
			detailText.validate();	
		}
		
		private function createTabBar():void
		{
		
			square = new Quad(Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT/100*10,0x000000 )
			addChild(square);
			square.y=Constants.STAGE_HEIGHT-Constants.STAGE_HEIGHT/100*10;
			tabs = new ButtonGroup();
			tabs.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			//tabs.gap=5;
			tabs.horizontalAlign=ButtonGroup.HORIZONTAL_ALIGN_CENTER;
			//tabs.verticalAlign=ButtonGroup.VERTICAL_ALIGN_MIDDLE;

			tabs.paddingTop=2;
			tabs.customButtonName = SpurnTheme.ALTERNATE_NAME_MY_TAB_MIDDLE;
			
			tabs.dataProvider = new ListCollection(
				[
					{ label: "Plan", triggered: onviewExamsButTriggered },
					{ label: "Prepare", triggered: onviewTipsButTriggered },
					{ label: "Revise", triggered: onRevisionAppsTriggered },
				]);
			tabs.height = 40;
			tabs.width = Constants.STAGE_WIDTH;
			tabs.y = Constants.STAGE_HEIGHT - tabs.height;
			this.addChild( tabs );
			this.validate();
			
				
		}
		
		private function onRevisionAppsTriggered():void
		{
			// TODO Auto Generated method stub
			//destroy();
			leaving=true;
			
			this.owner.showScreen( Root.REVISION_APPS );
			
		}
		
		private function onviewTipsButTriggered():void
		{
			// TODO Auto Generated method stub
			//destroy();
			leaving=true;
			this.owner.showScreen( Root.TIPS_MENU);
			
		}
		
		private function onviewExamsButTriggered():void
		{
			// TODO Auto Generated method stub
			//destroy();
			leaving=true;
			this.owner.showScreen( Root.SEARCH_SUBJECTS);
			
		}
		
		private function dialog_dialogClosedHandler( event:DialogEvent ):void
		{
			trace( "Dialog Closed: id="+event.id +" button="+event.data );
			//clearInterval( progressInterval );
			if (event.data=="1")
			{
				editButton.label="Edit";
				_editing=false;
				list.itemRendererFactory = tileListItemRendererFactoryForText;
				
				removeExams();
				itemsToDelete = new Vector.<String>;
				list.dataProvider = listData;
			}
			else
			{
				//
			}
		}
		
		private function dialog_dialogCancelledHandler( event:DialogEvent ):void
		{
			trace( "Dialog Cancelled: id="+event.id +" data="+event.data );
			//clearInterval( progressInterval );
		}
		
       
    }
}