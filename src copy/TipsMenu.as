package
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Screen;
	import feathers.events.FeathersEventType;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	import themes.SpurnTheme;

	public class TipsMenu extends Screen
	{
		private var header:Header;
		private var backButton:Button;

		
		public function TipsMenu()
		{
		}
		
		
		private function addHeader():void
		{
			header = new Header();
			header.width = Constants.STAGE_WIDTH;
			//header.height = (Constants.STAGE_HEIGHT/100)*10;
			header.title = "Revision Tips";
			
			this.addChild( header );
			var backButton:Button = new Button();
			backButton.nameList.add( SpurnTheme.MY_CUSTOM_BACK_BUTTON );
			backButton.addEventListener(starling.events.Event.TRIGGERED,backClicked)
			header.leftItems = new <DisplayObject>[ backButton ];
			header.validate();
			trace("header height = "+header.height);
		}
		
		private function backClicked():void
		{
			backButton.removeEventListener(starling.events.Event.TRIGGERED,backClicked)
			destroy();
			this.owner.showScreen( Root.MENU );
			
		}
		
		private function destroy():void
		{
			//this.owner.removeEventListener( FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );
			removeChild(header);
			
			header=null;
			backButton = null;
			
		}
		
	}
}