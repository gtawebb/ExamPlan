package
{
    import flash.display.Bitmap;
    import flash.system.System;
    
    import controller.FatController;
    
    import feathers.controls.ScreenNavigator;
    import feathers.controls.ScreenNavigatorItem;
    import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
    
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.BitmapFont;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.AssetManager;
    
    import utils.ProgressBar;

    /** The Root class is the topmost display object in your game. It loads all the assets
     *  and displays a progress bar while this is happening. Later, it is responsible for
     *  switching between game and menu. For this, it listens to "START_GAME" and "GAME_OVER"
     *  events fired by the Menu and Game classes. Keep this class rather lightweight: it 
     *  controls the high level behaviour of your game. */
    public class Root extends Sprite
    {
        private static var sAssets:AssetManager;
        
        private var _background:Image;
        private var mActiveScene:Sprite;
        private var _navigator:ScreenNavigator;
		
		public static const REVISION_APPS:String="RevisionApps";
		public static const MENU:String="Menu";
		public static const SEARCH_SUBJECTS:String="SearchSubjects";
		public static const EXAM_DETAIL:String="ExamDetail";
		public static const TIPS_MENU:String="TipsMenu";
		public static const TIPS_DETAILS:String="TipsDetails";
		
		public static var REFRESH_EXAM_CALENDAR_LIST:Boolean=false;
		
		public static var FIRST_TIME:Boolean=true;
		public static var FAT_CONTROLLER:FatController;
		
		private var _transitionManager:Object;
		
		[Embed(source="/fonts/futura/font.png")]
		protected static const DefaultFontAtlas:Class;
		
		[Embed(source="/fonts/futura/font.fnt", mimeType="application/octet-stream")]
		protected static const DefaultFontXML:Class;
		private static var mybitmapFont:BitmapFont;
		

        
        public function Root()
        {
			
            addEventListener(Menu.START_GAME, onStartGame);
            addEventListener(Game.GAME_OVER,  onGameOver);
			FAT_CONTROLLER  = new FatController();
		
			
            // not more to do here -- Startup will call "start" immediately.
        }
		
		
		
		public static function getbitmapfnt():BitmapFont
		{
			if(mybitmapFont==null)
			{
				var fontBitmap:Bitmap = new DefaultFontAtlas();
				var fontTexture:Texture = Texture.fromBitmap(fontBitmap);
				var fontXML:XML = XML(new DefaultFontXML());
				mybitmapFont=new BitmapFont(fontTexture, fontXML);
				TextField.registerBitmapFont(mybitmapFont);
			}
			return mybitmapFont;
		}
        
        public function start(background:Texture, assets:AssetManager):void
        {
            // the asset manager is saved as a static variable; this allows us to easily access
            // all the assets from everywhere by simply calling "Root.assets"
            sAssets = assets;
            
            // The background is passed into this method for two reasons:
            // 
            // 1) we need it right away, otherwise we have an empty frame
            // 2) the Startup class can decide on the right image, depending on the device.
            _background = new Image(background)
            addChild(_background);
			
			this._navigator = new ScreenNavigator();
			this.addChild( this._navigator );
			//this._navigator.addScreen( "ViewExams", new ScreenNavigatorItem( ViewExams ) );
			this._navigator.addScreen( SEARCH_SUBJECTS, new ScreenNavigatorItem( SearchSubjects ) );
			
			this._navigator.addScreen( REVISION_APPS, new ScreenNavigatorItem( RevisionApps ) );
			this._navigator.addScreen( EXAM_DETAIL, new ScreenNavigatorItem( ExamDetail ) );
			this._navigator.addScreen( TIPS_DETAILS, new ScreenNavigatorItem( TipsDetails ) );
			this._navigator.addScreen( TIPS_MENU, new ScreenNavigatorItem( TipsMenu ) );
			this._transitionManager = new ScreenSlidingStackTransitionManager( _navigator );
			//this._transitionManager.
			this._transitionManager.duration = 0.4;
			this._transitionManager.delay=.4;
			//this._transitionManager.ease = Transitions.EASE_OUT;
			
            
            // The AssetManager contains all the raw asset data, but has not created the textures
            // yet. This takes some time (the assets might be loaded from disk or even via the
            // network), during which we display a progress indicator. 
            
            var progressBar:ProgressBar = new ProgressBar(175, 20);
            progressBar.x = (background.width  - progressBar.width)  / 2;
            progressBar.y = (background.height - progressBar.height) / 2;
            progressBar.y = background.height * 0.85;
            addChild(progressBar);
            
            assets.loadQueue(function onProgress(ratio:Number):void
            {
                progressBar.ratio = ratio;
                
                // a progress bar should always show the 100% for a while,
                // so we show the main menu only after a short delay. 
                
                if (ratio == 1)
                    Starling.juggler.delayCall(function():void
                    {
                        progressBar.removeFromParent(true);
						showMenu();
						
                        
                        // now would be a good time for a clean-up 
                        System.pauseForGCIfCollectionImminent(0);
                        System.gc();
                    }, 0.15);
            });
        }
        
        private function onGameOver(event:Event, score:int):void
        {
            trace("Game Over! Score: " + score);
			this._navigator.showScreen( MENU );
           // showScene(Menu);
        }
        
        private function onStartGame(event:Event, gameMode:String):void
        {
            trace("Game starts! Mode: " + gameMode);
			
			this._navigator.showScreen(SEARCH_SUBJECTS);
        }
        
       /* private function showExams():void
        {
			removeChild(_background);
			_background=null;
			this._navigator.showScreen("ViewExams");
           
        }*/
        private function showMenu():void
        {
			removeChild(_background);
			_background=null;
			var myMenu:Menu = new Menu()
			this._navigator.addScreen( MENU, new ScreenNavigatorItem( myMenu ) );
			this._navigator.showScreen(MENU);
           
        }
        
        public static function get assets():AssetManager { return sAssets; }
    }
}