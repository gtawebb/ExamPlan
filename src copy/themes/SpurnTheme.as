package themes
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.TextArea;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.text.ITextEditorViewPort;
	import feathers.controls.text.TextFieldTextEditor;
	import feathers.controls.text.TextFieldTextEditorViewPort;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextEditor;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale9Image;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.textures.Scale9Textures;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.Texture;
	
	
	
	
	public class SpurnTheme extends MetalWorksMobileTheme
	{

		
		[Embed(source="/fonts/AdelleBasic_Bold.otf", embedAsCFF="false", fontFamily="AdelleBasic_Bold")]
		public static const AdelleBasic_Bold:Class;
		
		[Embed(source="/fonts/CALIBRI.TTF", embedAsCFF="false", fontFamily="CALIBRI")]
		public static const Calibri:Class;
		
		[Embed(source="/fonts/DINEngschriftStd.otf", embedAsCFF="false", fontFamily="DINEngschriftStd")]
		public static const DINEngschriftStd:Class;
		
		
		public static const MY_CUSTOM_BACK_BUTTON:String = "my-custom-back-button";
		public static const MY_CUSTOM_NORMAL_BUTTON:String = "my-custom-normal-button";
		public static const MY_CUSTOM_HEADER_BUTTON:String = "MY_CUSTOM_HEADER_BUTTON";
		
		public static const ALTERNATE_NAME_MY_TAB_BAR:String = "ALTERNATE_NAME_MY_TAB_BAR";
		public static const ALTERNATE_NAME_MY_TEXT_INPUT:String = "ALTERNATE_NAME_MY_TEXT_INPUT";
		public static const HEADING_TEXT_AREA:String = "HEADING_TEXT_AREA";
		public static const PARA_TEXT_AREA:String = "PARA_TEXT_AREA";
		public static const ALTERNATE_NAME_MY_TAB_LAST:String = "ALTERNATE_NAME_MY_TAB_LAST";
		public static const ALTERNATE_NAME_MY_TAB_MIDDLE:String = "ALTERNATE_NAME_MY_TAB_MIDDLE";
		public static const ALTERNATE_NAME_MY_TAB_FIRST:String = "ALTERNATE_NAME_MY_TAB_FIRST";
		
		
		
		private var buttonDown:Scale9Textures;
		private var buttonUp:Scale9Textures;
		private var listItem:Scale9Textures;
		private var firstTabUp:Scale9Textures;
		private var middleTabUp:Scale9Textures;
		private var lastTabUp:Scale9Textures;
		private var firstTabDown:Scale9Textures;
		private var middleTabDown:Scale9Textures;
		private var lastTabDown:Scale9Textures;
		
		/*private var buttonUpImage:Scale9Image
		private var buttonDownImage:Scale9Image*/

		
		public function SpurnTheme(root:DisplayObjectContainer, scaleToDPI:Boolean = true )
		{
			super( root, scaleToDPI );
		}
		
	
		
		override protected function initialize():void
		{
			super.initialize();
			this.setInitializerForClass( Button, myBackButtonInitializer, MY_CUSTOM_BACK_BUTTON );
			this.setInitializerForClass( Button, myNormalButtonInitializer, MY_CUSTOM_NORMAL_BUTTON );
			this.setInitializerForClass( Button, myHeaderButtonInitializer, MY_CUSTOM_HEADER_BUTTON );
			
			this.setInitializerForClass( TextInput, myTextInputInit, ALTERNATE_NAME_MY_TEXT_INPUT );
			this.setInitializerForClass( TextArea, myHeadingText, HEADING_TEXT_AREA );
			this.setInitializerForClass( TextArea, myParaText, PARA_TEXT_AREA );

		//	this.setInitializerForClass(DefaultListItemRenderer, itemRendererInitializer);

			this.setInitializerForClass(Button, tabInitializer, ALTERNATE_NAME_MY_TAB_MIDDLE);
			
			this.setInitializerForClass( Button, customFirstTabInitializer, ALTERNATE_NAME_MY_TAB_FIRST);
			this.setInitializerForClass( Button, customLastTabInitializer, ALTERNATE_NAME_MY_TAB_LAST);
			
			
			//this.setInitializerForClass(TextInput, textInputInitializer);
			// set new initializers here
			
			var textureDown:Texture = Root.assets.getTexture("BlueButtonDown")
			var rect:Rectangle = new Rectangle( 6, 6, 16, 57 );
			buttonDown = new Scale9Textures( textureDown, rect );
			
			var textureUp:Texture = Root.assets.getTexture("BlueButtonUp")
			buttonUp = new Scale9Textures( textureUp, rect );
			
			var textureListItem:Texture = Root.assets.getTexture("ListItem")
			//var rect:Rectangle = new Rectangle( 6, 6, 16, 57 );
			listItem = new Scale9Textures( textureListItem, rect );
			
			var textureFirstTabItemUp:Texture = Root.assets.getTexture("TabLeftUp")
			//var rect:Rectangle = new Rectangle( 6, 6, 16, 57 );
			firstTabUp = new Scale9Textures( textureFirstTabItemUp, rect );
			
			var textureMiddleTabItemUp:Texture = Root.assets.getTexture("TabCentreUp")
			//var rect:Rectangle = new Rectangle( 6, 6, 16, 57 );
			middleTabUp = new Scale9Textures( textureMiddleTabItemUp, rect );
			
			var lastTabItemUp:Texture = Root.assets.getTexture("TabRightUp")
			//var rect:Rectangle = new Rectangle( 6, 6, 16, 57 );
			lastTabUp = new Scale9Textures( lastTabItemUp, rect );
			
			var textureFirstTabItemDown:Texture = Root.assets.getTexture("TabLeftDown")
			//var rect:Rectangle = new Rectangle( 6, 6, 16, 57 );
			firstTabDown = new Scale9Textures( textureFirstTabItemDown, rect );
			
			var textureMiddleTabItemDown:Texture = Root.assets.getTexture("TabCentreDown")
			//var rect:Rectangle = new Rectangle( 6, 6, 16, 57 );
			middleTabDown = new Scale9Textures( textureMiddleTabItemDown, rect );
			
			var lastTabItemDown:Texture = Root.assets.getTexture("TabRightDown")
			//var rect:Rectangle = new Rectangle( 6, 6, 16, 57 );
			lastTabDown = new Scale9Textures( lastTabItemDown, rect );
			
		/*	var backTexture:Texture = new Bitmap(new BitmapData(10,10,false,0x333333));
			var rect:Rectangle = new Rectangle( 2, 2, 32, 114 );
			buttonDown = new Scale9Textures( textureDown, rect );
			*/
			
			//buttonDownImage = new Scale9Image( buttonDown );
			
			
			
			//buttonUpImage = new Scale9Image( buttonUp );

		}
		
		protected function myParaText(textInput:TextArea):void
		{
			// TODO Auto Generated method stub
			
			textInput.backgroundSkin = new Image(Texture.fromBitmapData(new BitmapData(1,1,false,0xd7dcc7)));
			trace("got here")
			
			textInput.paddingTop=7;
			textInput.paddingLeft=7;
			
			textInput.textEditorFactory = function():ITextEditorViewPort
			{
				var editor:TextFieldTextEditorViewPort = new TextFieldTextEditorViewPort();
				
				editor.textFormat = new TextFormat( "Helvetica", 14, 0x000000 );
				
				editor.wordWrap = true;
				editor.multiline = true;
				return editor;
			}
		}
		
		protected function myHeadingText(textInput:TextArea):void
		{
			// TODO Auto Generated method stub
			
			textInput.backgroundSkin = new Image(Texture.fromBitmapData(new BitmapData(1,1,false,0xd7dcc7)));
			trace("got here")
			
			
			
			textInput.textEditorFactory = function():ITextEditorViewPort
			{
				var editor:TextFieldTextEditorViewPort = new TextFieldTextEditorViewPort();
				editor.embedFonts=true;
				editor.multiline = true;
				editor.wordWrap = true;
				editor.textFormat = new TextFormat( "DINEngschriftStd", 26, 0x000000,null,null,null,null,null,null,null,null,null,5 );
				
				return editor;
			}
		}
		
		protected function myTextInputInit(textInput:TextInput):void
		{
			// TODO Auto Generated method stub
			
				textInput.backgroundSkin = new Image(Texture.fromBitmapData(new BitmapData(1,1,false,0xd7dcc7)));
			trace("got here")
			
				textInput.textEditorFactory = function():ITextEditor
				{
					var editor:TextFieldTextEditor = new TextFieldTextEditor();
					editor.isHTML=true;
					editor.textFormat = new TextFormat( "Helvetica", 14, 0x000000 );
					editor.wordWrap = true;
					//editor.multiline = true;
					return editor;
				}
		}
		
		
		override protected function tabInitializer(tab:Button):void
		{
			
			super.tabInitializer(tab)	
			const defaultSkinUp:Scale9Image = new Scale9Image(middleTabUp);
			tab.defaultSkin = defaultSkinUp;
			const defaultSkinDown:Scale9Image = new Scale9Image(middleTabDown);
			tab.defaultSelectedSkin = defaultSkinDown;
			tab.downSkin = defaultSkinDown;
			
			
			
			
		}
		
		 protected function customFirstTabInitializer(tab:Button):void
		{
			
			super.tabInitializer(tab)	
			const defaultSkinUp:Scale9Image = new Scale9Image(firstTabUp);
			tab.defaultSkin = defaultSkinUp;
			const defaultSkinDown:Scale9Image = new Scale9Image(firstTabDown);
			tab.defaultSelectedSkin = defaultSkinDown;
			tab.downSkin = defaultSkinDown;
			
			
			
		}
		
		 protected function customLastTabInitializer(tab:Button):void
		{
			
			super.tabInitializer(tab)	
			const defaultSkinUp:Scale9Image = new Scale9Image(lastTabUp);
			tab.defaultSkin = defaultSkinUp;
			const defaultSkinDown:Scale9Image = new Scale9Image(lastTabDown);
			tab.defaultSelectedSkin = defaultSkinDown;
			tab.downSkin = defaultSkinDown;
			
		}
		
		
		override protected function itemRendererInitializer(renderer:BaseDefaultItemRenderer):void
		{
			
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = listItem;
			//skinSelector.defaultSelectedValue = buttonDown;
			skinSelector.setValueForState(this.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
				{
					width: 88 * this.scale,
						height: 88 * this.scale,
						textureScale: this.scale
				};
			renderer.stateToSkinFunction = skinSelector.updateValue;
			
			
			
			
			renderer.defaultLabelProperties.textFormat  = new TextFormat( "DINEngschriftStd", 18, 0xFFFFFF );
			renderer.defaultLabelProperties.embedFonts = true;
			renderer.downLabelProperties.textFormat  = new TextFormat( "DINEngschriftStd", 18, 0xFFFFFF);
			renderer.downLabelProperties.embedFonts = true;
			renderer.defaultSelectedLabelProperties.textFormat  = new TextFormat( "DINEngschriftStd", 18, 0x000000 );
			renderer.defaultSelectedLabelProperties.embedFonts = true;
			
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = renderer.paddingBottom = 8 * this.scale;
			renderer.paddingLeft = 32 * this.scale;
			renderer.paddingRight = 24 * this.scale;
			renderer.gap = 20 * this.scale;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = renderer.minHeight = 88 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 88 * this.scale;
			
			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
		}
		
		
		
	/*	protected function myCustomButtonInitializer( button:Button ):void
		{
			var downBut:Texture = Root.assets.getTexture("BlueButtonDown")
			var upBut:Texture = Root.assets.getTexture("BlueButtonUp")
			
			button.labelFactory = function():ITextRenderer
			{
				var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				//textRenderer.embedFonts = true;
				textRenderer.textFormat = new TextFormat( "Helvetica", 18, 0xFFFFFF );
				
				return textRenderer;
			}
				
			const defaultSkinUp:Scale9Image = new Scale9Image(middleTabUp);
			button.defaultSkin = defaultSkinUp;
			const defaultSkinDown:Scale9Image = new Scale9Image(middleTabDown);
			button.defaultSelectedSkin = defaultSkinDown;
			button.downSkin = defaultSkinDown;

			//button. = new TextFormat( "calibri", 30, 0xffffff );
		}*/
		
		protected function myBackButtonInitializer( button:Button ):void
		{
			
			button.labelFactory = function():ITextRenderer
			{
				var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat( "Helvetica", 18, 0xFFFFFF );
				return textRenderer;
			}
			var backUpTexture:Texture = Root.assets.getTexture("back");
			const defaultSkinUp:Image = new Image(backUpTexture);
			button.defaultSkin = defaultSkinUp;
		}
		protected function myNormalButtonInitializer( button:Button ):void
		{
			
			button.labelFactory = function():ITextRenderer
			{
				var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat( "Helvetica", 18, 0xFFFFFF );
				return textRenderer;
			}
			
			const defaultSkinUp:Scale9Image = new Scale9Image(buttonUp);
			button.defaultSkin = defaultSkinUp;
			
			const defaultSkinDown:Scale9Image = new Scale9Image(buttonDown);
			button.downSkin = defaultSkinDown;
		}
		
		protected function myHeaderButtonInitializer( button:Button ):void
		{
			
			button.labelFactory = function():ITextRenderer
			{
				var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat( "Helvetica", 12, 0xFFFFFF );
				return textRenderer;
			}
			
			const defaultSkinUp:Scale9Image = new Scale9Image(buttonUp);
			button.defaultSkin = defaultSkinUp;
			
			const defaultSkinDown:Scale9Image = new Scale9Image(buttonDown);
			button.downSkin = defaultSkinDown;
		}
		
		protected function myCustomListInitializer( list:List ):void
		{
			var downBut:Texture = Root.assets.getTexture("BlueButtonDown")
			var upBut:Texture = Root.assets.getTexture("BlueButtonUp")
			
			list.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.defaultSkin = new Image( downBut );
				renderer.downSkin = new Image( downBut );
				renderer.hoverSkin = new Image( upBut );
				renderer.defaultLabelProperties.embedFonts = true;
				renderer.defaultLabelProperties.textFormat = new TextFormat( "DINEngschriftStd", 18, 0xFFFFFF );
				renderer.defaultLabelProperties.textFormat.wordWrap=true;
					
				
				
				return renderer;
			}
			
			
			//button. = new TextFormat( "calibri", 30, 0xffffff );
		}
	}
}