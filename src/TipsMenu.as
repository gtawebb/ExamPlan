package
{
	import controller.FatController;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.events.FeathersEventType;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	import themes.SpurnTheme;

	public class TipsMenu extends Screen
	{
		private var header:Header;
		private var backButton:Button;
		private var detailText:TextInput;
		private var container:ScrollContainer;
		private var butVector:Vector.<String>
		protected var _fatController:FatController;
		private var leaving:Boolean=false;


		
		public function TipsMenu()
		{
			super();
			_fatController = Root.FAT_CONTROLLER;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			this.owner.addEventListener( FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );
			
			addHeader();
			addAdviceText();
			
		}
		
		private function owner_transitionCompleteHandler():void
		{
			if(leaving)
			{
				destroy();
			}
			else
			{
				createButs();
			}
			
		}
		
		private function createButs():void
		{
			container = new ScrollContainer();
			container.y=detailText.y+detailText.height;
			addChild(container);
			//container.x=int((Constants.STAGE_WIDTH/100) *5);
			container.paddingTop = int((Constants.STAGE_WIDTH/100) *3);
			container.paddingLeft = int((Constants.STAGE_WIDTH/100) *3);
			container.paddingRight = int((Constants.STAGE_WIDTH/100) *3);
			butVector = Constants.TIPS_TITLES;
			//butVector.reverse();
			var but:Button;
			for (var i:int = butVector.length-1; i >=0; i--) 
			{
				trace(i)
				but = new Button();
				but.nameList.add(SpurnTheme.ALTERNATE_NAME_MY_TAB_MIDDLE);
				but.width=int((Constants.STAGE_WIDTH/100) *94);
				but.height=int((Constants.STAGE_HEIGHT/100) *10);
				but.y=i*int((Constants.STAGE_HEIGHT/100) *11);
				
				but.label=butVector[i];
				container.addChild(but);
				but.addEventListener( starling.events.Event.TRIGGERED, but_handler );
			}
			
		}
		
		private function but_handler(e:Event):void
		{
			
			_fatController.tipsIndex=butVector.indexOf(Button(e.target).label);
			//destroy();
			leaving=true
			this.owner.showScreen( Root.TIPS_DETAILS);
			
		}
		
		private function addAdviceText():void 
		{
			detailText = new TextInput();
			detailText.nameList.add( SpurnTheme.PARA_TEXT_AREA );
			this.addChild( this.detailText );
			//detailText.backgroundSkin = new Image(Texture.fromBitmapData(new BitmapData(1,1,false,0xffffff)));
			detailText.width = (Constants.STAGE_WIDTH);
			detailText.padding=5;
			detailText.height = (Constants.STAGE_HEIGHT/100)*20;
			detailText.x = 0;
			
			detailText.y = header.y+header.height;
			detailText.isEditable = false;
			
			detailText.text="Revising is never easy, there's always someing better to do and it never sinks in anyway! We've all been there so we've compiled this essential list of revision tips to help you create the perfect" +
				"environment for revising and getting you mentally focued for the exam"; 
			
			detailText.validate();	
		}
		
		private function addHeader():void
		{
			header = new Header();
			header.width = Constants.STAGE_WIDTH;
			//header.height = (Constants.STAGE_HEIGHT/100)*10;
			header.title = "Exam Preparation";
			
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
			
			backButton.removeEventListener(starling.events.Event.TRIGGERED, backClicked)
			//destroy();
			leaving=true
			this.owner.showScreen( Root.MENU );
			
		}
		
		private function destroy():void
		{
			this.owner.removeEventListener( FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );
			removeChild(header);
			removeChild(container);
			removeChild(detailText);
			container.removeChildren();
			detailText=null;
			container=null;
			header=null;
			backButton = null;
			
		}
		
	}
}