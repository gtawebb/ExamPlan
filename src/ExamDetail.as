package
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.TextInput;
	import feathers.events.FeathersEventType;
	
	import model.Exam;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	import themes.SpurnTheme;

	public class ExamDetail extends Screen
	{
		private var myExamData:Object;
		private var list:List = new List();
		
	//test
		
		//trace(myObject.results[0].description);*/
		
		
		private var header:Header;
		private var detailText:TextInput;
		private var backButton:Button;
		private var leaving:Boolean=false;

		
		public function ExamDetail()
		{
			
				
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			this.owner.addEventListener( FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );

			addHeader();

		}
		
		private function destroy():void
		{
			this.owner.removeEventListener( FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );
		}
		
		private function owner_transitionCompleteHandler():void
		{
			// TODO Auto Generated method stub
			
			if(leaving)
			{
				destroy();
			}
			else
			{
				addAdviceText();
			}
			
		}
		
		private function addAdviceText():void 
		{
			
			detailText = new TextInput();
			detailText.nameList.add( SpurnTheme.ALTERNATE_NAME_MY_TEXT_INPUT );
			this.addChild( this.detailText );
			detailText.width = Constants.STAGE_WIDTH;
			detailText.height = (Constants.STAGE_HEIGHT/100)*40;
			detailText.x = 0;
			detailText.y = (Constants.STAGE_HEIGHT/100)*59;
			detailText.isEditable = false;
			
			
			var _exam:Exam=Root.FAT_CONTROLLER.selectedExam;
			detailText.text=detailText.text = "<b>Title: </b>"+_exam.title+"\n<b>Date: </b>"+_exam.date+"\n"+_exam.notes;
			
			detailText.validate();	
		}
		
		
		
		private function addHeader():void
		{
			header = new Header();
			header.width = Constants.STAGE_WIDTH;
			//header.height = (Constants.STAGE_HEIGHT/100)*10;
			header.title = "Revision Apps";
			
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
			//destroy();
			leaving=true;
			this.owner.showScreen( Root.MENU );
			//this.owner.addScreen("MENUCACHE",ScreenNavigatorItem(this));
			//this.owner.showScreen( "MENUCACHE");
			
			
		}		
	}
}