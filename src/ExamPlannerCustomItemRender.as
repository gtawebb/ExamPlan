package
{
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.List;
	import feathers.controls.ScrollText;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	
	import starling.events.Event;
	
	public class ExamPlannerCustomItemRender extends FeathersControl implements IListItemRenderer
	{
		public function ExamPlannerCustomItemRender()
		{
		}
		
		protected var _label:ScrollText;
		//private var square:Quad;
		//protected var _subLabel:TextInput;
		
		protected var _index:int = -1;
		
		public function get index():int
		{
			return this._index;
		}
		
		public function set index(value:int):void
		{
			if(this._index == value)
			{
				return;
			}
			this._index = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _owner:List;
		
		public function get owner():List
		{
			return this._owner;
		}
		
		public function set owner(value:List):void
		{
			if(this._owner == value)
			{
				return;
			}
			this._owner = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _data:Object;
		
		public function get data():Object
		{
			return this._data;
		}
		
		public function set data(value:Object):void
		{
			if(this._data == value)
			{
				return;
			}
			this._data = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		
		}
		
		protected var _isSelected:Boolean;
		
		public function get isSelected():Boolean
		{
			return this._isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			if(this._isSelected == value)
			{
				return;
			}
			this._isSelected = value;
			this.invalidate(INVALIDATION_FLAG_SELECTED);
			this.dispatchEventWith(Event.CHANGE);
			trace("slelct")
			
		}
		
		protected var _padding:Number = 0;
		
		public function get padding():Number
		{
			return this._padding;
		}
		
		public function set padding(value:Number):void
		{
			if(this._padding == value)
			{
				return;
			}
			this._padding = value;
			this.invalidate(INVALIDATION_FLAG_LAYOUT);
		}
		
		override protected function initialize():void
		{
			if(!this._label)
			{
				/*square = new Quad(Constants.STAGE_WIDTH-(Constants.STAGE_WIDTH/100*10), (Constants.STAGE_HEIGHT/100)*65,0x000000 )
				square.x=(Constants.STAGE_WIDTH/100)*5;
				square.y=(Constants.STAGE_HEIGHT/100)*5;
				addChild(square);*/
				this._label = new ScrollText();
				//this._label.nameList.add( SpurnTheme.TIPS_HEADING_TEXT_AREA );
				this.addChild(this._label);
				this._label.paddingTop=0;
				
				_label.isHTML=true;
				_label.background=true;
				_label.backgroundColor=0x000000;
				//_label.clipContent = true;
				//_label.wordWrap = true;
				
				_label.textFormat = new TextFormat( "Helvetica", 16, 0xFFFFFF,false,null,null,null,null,TextFormatAlign.CENTER,null,null,null,5 );
				
				
				//this._subLabel = new TextInput();
				//this._subLabel.nameList.add( SpurnTheme.DETAILS_TEXT_AREA );
				//this.addChild(this._subLabel);
			}
			
			
		}
		
		override protected function draw():void
		{
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			
			if(dataInvalid)
			{
				this.commitData();
			}
			
			//this.autoSizeIfNeeded();
			this.layoutChildren();
			
			
		}
		
		protected function autoSizeIfNeeded():Boolean
		{
			const needsWidth:Boolean = isNaN(this.explicitWidth);
			const needsHeight:Boolean = isNaN(this.explicitHeight);
			if(!needsWidth && !needsHeight)
			{
				return false;
			}
			
			this._label.width = this.explicitWidth - 2 * this._padding;
			this._label.height = this.explicitHeight - 2 * this._padding;
			this._label.validate();
			//this._subLabel.width = this.explicitWidth - 2 * this._padding;
			//this._subLabel.height = this.explicitHeight - 2 * this._padding;
			//this._subLabel.validate();
			
			var newWidth:Number = this.explicitWidth;
			if(needsWidth)
			{
				newWidth = this._label.width + 2 * this._padding;
				//newWidth = this._subLabel.width + 2 * this._padding;
			}
			var newHeight:Number = this.explicitHeight;
			if(needsHeight)
			{
				newHeight = this._label.height + 2 * this._padding;
				//newHeight = this._subLabel.height + 2 * this._padding;
			}
			
			return this.setSizeInternal(newWidth, newHeight, false);
		}
		
		protected function commitData():void
		{
			if(this._data)
			{
				this._label.text = this._data.label;
				//this._subLabel.text = this._data.body;
			}
			else
			{
				this._label.text = null;
				//this._subLabel.text = null;
			}
			
		}
		
		protected function layoutChildren():void
		{
			this._label.x = this._padding;
			this._label.y = this._padding+20;
			this._label.width = this.actualWidth - 2 * this._padding;
			this._label.height = this.actualHeight - 6 * this._padding;
			//this._subLabel.x = this._padding;
			//this._subLabel.y = this._padding+50;
			
			//this._subLabel.width = (Constants.STAGE_WIDTH/100)*90;
			//this._subLabel.height = (Constants.STAGE_HEIGHT/100)*44;
			
			
			
			
		}
	}
}