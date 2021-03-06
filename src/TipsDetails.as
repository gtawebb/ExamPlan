package
{
	
	import controller.FatController;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.PageIndicator;
	import feathers.controls.Screen;
	import feathers.controls.Scroller;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalLayout;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	import themes.SpurnTheme;

	public class TipsDetails extends Screen
	{
		private var header:Header;
		private var backButton:Button;
		private var detailText:TextInput;
		private var container:List;
		
	//	private var butVector:Vector.<String>;
		private var tipsIndex:int;
		protected var _fatController:FatController;
		private var pages:PageIndicator;
		//private var headerText:Label;
		//private var bodyText:TextInput;
		//private var bodTextArray:Array;
		private var count:int=0;
	//	private var square:Quad;
		private var leaving:Boolean=false;


		
		public function TipsDetails()
		{
			super();
			_fatController = Root.FAT_CONTROLLER;
			tipsIndex=_fatController.tipsIndex;
			//trace("INDEX="+tipsIndex)
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			this.owner.addEventListener( FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );

			addHeader();
			addAdviceText();
			createPageIndicator();
			
			
		}
		
		private function owner_transitionCompleteHandler():void
		{
			if(leaving)
			{
				destroy();
			}
			else
			{
			createScrollContents();
			}
		}
		
		private function createScrollContents():void
		{
			
			//bodyText.nameList.add( SpurnTheme.PARA_TEXT_AREA );
			//square = new Quad(Constants.STAGE_WIDTH, (Constants.STAGE_HEIGHT/100)*2,0x000000 )
			//square.y=detailText.y+detailText.height;
			//addChild(square);
			container=new List();
			addChild(container);
			
			var layout:HorizontalLayout = new HorizontalLayout();
			//layout.gap = 20;
			//layout.padding = 20;
			//container.y=30;
			container.layout = layout;
			container.pageWidth=Constants.STAGE_WIDTH;
			container.scrollBarDisplayMode =Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
			container.horizontalScrollPolicy=Scroller.SCROLL_POLICY_ON;
			container.verticalScrollPolicy=Scroller.SCROLL_POLICY_OFF;
			container.snapToPages = true;
			container.minimumPageThrowVelocity=.1;
			//container.width=(Constants.STAGE_WIDTH/100)*90;
			//container.height=(Constants.STAGE_HEIGHT/100)*90;
			container.y=detailText.height+detailText.y;
			
			container.addEventListener(FeathersEventType.SCROLL_COMPLETE, scrollComplete);
			
			//var layoutVert:VerticalLayout = new VerticalLayout();
			
			//layoutVert.gap = 20;
			//layout.padding = 20;
			//var group:ScrollContainer=new ScrollContainer();
			//group.layout=layoutVert;
			
			
			var myObject:Object;
			var myArrayOfObjects:Array=[];
			//var headers:Vector.<String>=Constants["TIPS_DETAILS_HEADERS_"+tipsIndex];
			var bodies:Vector.<String>=Constants["TIPS_DETAILS_BODIES_"+tipsIndex];
			var theLength:int=bodies.length;
			
			for (var i:int = 0; i < theLength; i++) 
			{
				
				myObject={label:bodies[i]}
				myArrayOfObjects.push(myObject);
			}
			
			var myListCollection:ListCollection = new ListCollection(myArrayOfObjects);
			container.dataProvider=myListCollection;
			//container.addEventListener( starling.events.Event.TRIGGERED, list_changeHandler );
			container.itemRendererFactory = tileListItemRendererFactory;
			
		}
		
		private function list_changeHandler():void
		{
			trace("change")
		}
		
		protected function tileListItemRendererFactory():IListItemRenderer
		{
			var renderer:ExamPlannerCustomItemRender = new ExamPlannerCustomItemRender();
			
			renderer.padding = 10;
			renderer.width=(Constants.STAGE_WIDTH);
			renderer.height=(Constants.STAGE_HEIGHT/100)*74;
			//renderer.data = "title";
			
			return renderer;
			
			/*
			
			const renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = "title";
			renderer.width=(Constants.STAGE_WIDTH);
			renderer.height=(Constants.STAGE_HEIGHT/100)*64;*/
			//renderer.iconSourceField = "texture";
		}
		
		
		/*private function initializeHandler(e:Event):void
		{
			trace("headerText height = "+Label(e.target).height)
			
			bodTextArray[Label(e.target).minHeight].y=Label(e.target).y+Label(e.target).height;
			
		}*/
		
		private function scrollComplete(e:Event):void
		{
			// TODO Auto Generated method stub
			trace("complete")
			
			pages.selectedIndex=List(e.target).horizontalPageIndex;
		
			
		}
		private function createPageIndicator():void
		{
			pages = new PageIndicator();
			pages.pageCount = Constants["TIPS_DETAILS_BODIES_"+tipsIndex].length;
			pages.y=(Constants.STAGE_HEIGHT/100)*96;
			pages.width=Constants.STAGE_WIDTH;
		//	pages.width=Constants.STAGE_WIDTH;
			this.addChild( pages );
			pages.addEventListener( Event.CHANGE, pageIndicator_changeHandler );
			
		}
		
		private function pageIndicator_changeHandler( event:Event ):void
		{
			//var pages:PageIndicator = PageIndicator( event.currentTarget );
			container.scrollToPageIndex( pages.selectedIndex,0,1)
			trace( "selected index:", pages.selectedIndex );
		}
		
		
		
		private function addAdviceText():void 
		{
			detailText = new TextInput();
			detailText.nameList.add( SpurnTheme.TIPS_MAIN_HEADING_TEXT_AREA );
			this.addChild( this.detailText );
			//detailText.backgroundSkin = new Image(Texture.fromBitmapData(new BitmapData(1,1,false,0xffffff)));
			detailText.width = (Constants.STAGE_WIDTH);
			detailText.padding=5;
			
			detailText.height = (Constants.STAGE_HEIGHT/100)*10;
			//detailText.x = 0;
			
			detailText.y = header.y+header.height;
			detailText.isEditable = false;
			
			detailText.text = Constants.TIPS_TITLES[tipsIndex];
			
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
			//trace("header height = "+header.height);
		}
		
		private function backClicked():void
		{
			container.dataProvider=null;
			container.visible=false;
			backButton.removeEventListener(starling.events.Event.TRIGGERED, backClicked);
			leaving=true;
			//destroy();
			this.owner.showScreen( Root.TIPS_MENU );
			
		}
		
		private function destroy():void
		{
			this.owner.removeEventListener( FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );
			container.removeEventListener(FeathersEventType.SCROLL_COMPLETE, scrollComplete);
			pages.removeEventListener( Event.CHANGE, pageIndicator_changeHandler );
			container.removeChildren();
			removeChild(header);
			removeChild(container);
			removeChild(detailText);
			removeChild(pages);
			//container.removeChildren();
			pages=null;
			detailText=null;
			container=null;
			header=null;
			backButton = null;
			//_fatController=null;
		}
		
	}
}