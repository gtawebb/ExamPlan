package
{
    import com.demonsters.debugger.MonsterDebugger;
    import com.distriqt.extension.calendar.Calendar;
    import com.distriqt.extension.calendar.events.CalendarStatusEvent;
    import com.distriqt.extension.dialog.Dialog;
    
    import flash.desktop.NativeApplication;
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filesystem.File;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;
    
    import starling.core.Starling;
    import starling.events.Event;
    import starling.textures.Texture;
    import starling.utils.AssetManager;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;
    import starling.utils.formatString;
    
    [SWF(frameRate="30", backgroundColor="#d7dcc7")]
    public class ExamPlan extends Sprite
    {
        // We embed the "Ubuntu" font. Beware: the 'embedAsCFF'-part IS REQUIRED!!!
        [Embed(source="/fonts/Ubuntu-R.ttf", embedAsCFF="false", fontFamily="Ubuntu")]
        private static const UbuntuRegular:Class;
        
        // Startup image for SD screens
        [Embed(source="/Default.png")]
        private static var Background:Class;
        
        // Startup image for HD screens
        [Embed(source="/Default@2x.png")]
        private static var BackgroundHD:Class;
		
		[Embed(source="/Default-568h@2x.png")]
		private static var BackgroundiPhone5:Class;
        
        private var mStarling:Starling;
        
        public function ExamPlan()
        {
            // set general properties
			
			
			
			var isPad:Boolean = (stage.fullScreenWidth == 768 || stage.fullScreenHeight == 1536);
			Constants.STAGE_WIDTH  = isPad ? 384 : 320;
			Constants.STAGE_HEIGHT = isPad ? 512 : 480;
			/*
			var myObject:Object=new Object();
			myObject={
				"resultCount":4,
				"results": [
					{"kind":"software", "features":["iosUniversal"], 
						"supportedDevices":["iPadMini", "iPodTouchourthGen", "iPhone4S", "iPadMini4G", "iPadThirdGen4G", "iPad23G", "iPhone5c", "iPodTouchFifthGen", "iPhone-3GS", "iPadWifi", "iPad3G", "iPodTouchThirdGen", "iPhone5s", "iPadFourthGen", "iPadFourthGen4G", "iPadThirdGen", "iPhone5", "iPad2Wifi", "iPhone4"], "isGameCenterEnabled":false, 
						"screenshotUrls":["http://a2.mzstatic.com/us/r30/Purple/v4/d3/62/a0/d362a0f9-f378-dce2-c242-ed2dc3f00b35/screen480x480.jpeg", "http://a4.mzstatic.com/us/r30/Purple/v4/e9/64/f7/e964f71c-9c10-13d4-75f4-be3fc5b5507d/screen480x480.jpeg", "http://a1.mzstatic.com/us/r30/Purple/v4/f9/d7/61/f9d76140-f103-90a2-eb2b-99127ee099ea/screen480x480.jpeg", "http://a5.mzstatic.com/us/r30/Purple/v4/e9/96/ee/e996ee21-51e0-a0a4-5a56-e48bc9eff81e/screen480x480.jpeg", "http://a2.mzstatic.com/us/r30/Purple/v4/cd/fa/d6/cdfad6a1-550a-e418-4da1-a61980efe970/screen480x480.jpeg"], 
						"ipadScreenshotUrls":["http://a1.mzstatic.com/us/r30/Purple/v4/c2/8d/5e/c28d5e4d-16c3-0ba8-0851-9a9ae5c34458/screen480x480.jpeg", "http://a3.mzstatic.com/us/r30/Purple/v4/e5/d3/2f/e5d32f89-f2cb-27be-4225-91855e02198d/screen480x480.jpeg", "http://a1.mzstatic.com/us/r30/Purple2/v4/8f/bd/f1/8fbdf125-30a5-06af-4fd2-293361c5817d/screen480x480.jpeg", "http://a5.mzstatic.com/us/r30/Purple/v4/dd/3d/7f/dd3d7ff4-b825-7168-5a9d-1556396bc31a/screen480x480.jpeg", "http://a2.mzstatic.com/us/r30/Purple/v4/d8/09/a1/d809a1de-d4a0-bc32-5c97-542a92538408/screen480x480.jpeg"], "artworkUrl60":"http://a1609.phobos.apple.com/us/r30/Purple/v4/fb/d3/23/fbd323f8-bdfc-5278-e5ff-b5b2530f2502/Icon.png", "artworkUrl512":"http://a1956.phobos.apple.com/us/r30/Purple/v4/fe/7c/79/fe7c79df-18be-18e4-40c0-813f26644209/mzl.fklsttyi.png", "artistViewUrl":"https://itunes.apple.com/us/artist/revision-buddies/id536618150?uo=4", "artistId":536618150, "artistName":"Revision Buddies", "price":0.00, "version":"2.01", 
						"description":"GCSE Modern History Revision App\n\nRevision Buddies are here to help you to succeed in your exams! Test yourself with over 1500 multiple choice revision questions on key topics, each with their own detailed explanatory note. \nMonitor your progress and share your results on Facebook and Twitter. This self-assessment series is designed to ensure that you have a full understanding of all the facts you need in order to excel in your GCSE History exams. \n\nContent is designed to cover the majority of exam boards \u2013 covers the full syllabus of the Edexcel syllabus, the majority of the AQA syllabus, and is looking to contain the full spread of OCR soon. Watch this space! \n\nWe have also included the relevant past papers from all three exam boards to make this the most complete revision app for GCSE Modern History.\n\nFull details of each section can be found at www.revisionbuddies.com. \n\n1 Britain WW1: Before, During and After \n2 Britain WW2: Before, During and After \n3 Germany: 1918-1939: The Rise of Hitler\n4 Germany: the Weimar Republic \n5 The USSR and Stalin \n6 Russia: The Fall of the Tsarist Regime, the road to Communism and the development of the USSR \n7 The USA: Racism and intolerance, civil rights and a changing society \n8 The USA: Economic boom and the Roaring 20s \n9 The USA: The Great Depression and the New Deal \n10 Causes of WW1 \n11 The Peace Treaties and how Europe was affected \n12 The road to WW2 \n13 Cold War Crises: Berlin, Cuba, Czechoslovakia\n14 The development of the Super Powers and the Cold War \n15 The end of the Cold War", "currency":"USD", "genres":["Education", "Reference"], "genreIds":["6017", "6006"], "releaseDate":"2012-11-27T03:03:27Z", "sellerName":"Revision Buddies Ltd", "bundleId":"com.revisionbuddies.gcsehistory", "trackId":536617847, "trackName":"GCSE History", "primaryGenreName":"Education", "primaryGenreId":6017, "releaseNotes":"Updated keywords", "formattedPrice":"Free", "wrapperType":"software", "trackCensoredName":"GCSE History", "languageCodesISO2A":["CS", "NL", "EN", "FR", "DE", "IT", "JA", "KO", "PL", "PT", "RU", "ZH", "ES", "SV", "ZH", "TR"], "fileSizeBytes":"21418652", "sellerUrl":"http://www.revisionbuddies.com", "contentAdvisoryRating":"4+", "artworkUrl100":"http://a1956.phobos.apple.com/us/r30/Purple/v4/fe/7c/79/fe7c79df-18be-18e4-40c0-813f26644209/mzl.fklsttyi.png", "trackViewUrl":"https://itunes.apple.com/us/app/gcse-history/id536617847?mt=8&uo=4", "trackContentRating":"4+"}, 
					{"kind":"software", "features":["iosUniversal"], 
						"supportedDevices":["iPadMini", "iPodTouchourthGen", "iPhone4S", "iPadMini4G", "iPadThirdGen4G", "iPad23G", "iPhone5c", "iPodTouchFifthGen", "iPhone-3GS", "iPadWifi", "iPad3G", "iPodTouchThirdGen", "iPhone5s", "iPadFourthGen", "iPadFourthGen4G", "iPadThirdGen", "iPhone5", "iPad2Wifi", "iPhone4"], "isGameCenterEnabled":false, 
						"screenshotUrls":["http://a4.mzstatic.com/us/r30/Purple/v4/d5/3d/3e/d53d3e3d-e8b6-ae42-3c49-fba9a1a3580d/screen480x480.jpeg", "http://a4.mzstatic.com/us/r30/Purple/v4/f5/e9/dd/f5e9dd81-5b66-e949-6534-c969e5402113/screen480x480.jpeg", "http://a4.mzstatic.com/us/r30/Purple2/v4/35/a5/71/35a571a3-1cff-7312-26a8-d0f4b4415cdc/screen480x480.jpeg", "http://a2.mzstatic.com/us/r30/Purple2/v4/b1/cb/cd/b1cbcd28-6c43-b621-917e-c80091759224/screen480x480.jpeg", "http://a3.mzstatic.com/us/r30/Purple2/v4/00/02/6f/00026f03-6168-257d-9580-833a481daf93/screen480x480.jpeg"], 
						"ipadScreenshotUrls":["http://a5.mzstatic.com/us/r30/Purple/v4/de/63/d1/de63d11e-621a-2aea-045c-9e56fc34b89b/screen480x480.jpeg", "http://a3.mzstatic.com/us/r30/Purple/v4/f7/33/7f/f7337f23-cf6e-f295-d3e5-7670b7e5358a/screen480x480.jpeg", "http://a2.mzstatic.com/us/r30/Purple2/v4/39/5b/12/395b12bd-fbc0-fadb-bf13-03b77e4d2019/screen480x480.jpeg", "http://a3.mzstatic.com/us/r30/Purple/v4/d5/49/3a/d5493a1c-1ad3-e9f3-d367-67775064aa4c/screen480x480.jpeg", "http://a1.mzstatic.com/us/r30/Purple/v4/cb/1e/fa/cb1efa32-043e-198f-ecfd-88a709d31372/screen480x480.jpeg"], "artworkUrl60":"http://a1958.phobos.apple.com/us/r30/Purple/v4/c2/f0/22/c2f02284-200e-d323-b377-765fffa96a98/Icon.png", "artworkUrl512":"http://a764.phobos.apple.com/us/r30/Purple2/v4/d1/45/8f/d1458f73-c731-136c-bf5f-19c6debba492/mzl.eoyqnzuo.png", "artistViewUrl":"https://itunes.apple.com/us/artist/revision-buddies/id536618150?uo=4", "artistId":536618150, "artistName":"Revision Buddies", "price":0.00, "version":"2.01", 
						"description":"Self-Assessment revision aid for GCSE Religious Studies: Religion in Life and Society: Christianity and Islam \n\nRevision Buddies are here to help you to succeed in your exams! This app has been created as a buddy to help you make sure that you know the relevant detail to prepare you for your R.S. Christianity and Islam GCSE examination topics. Each multiple choice question has been written by an experienced author and teacher of the subject to make sure that you are up to scratch on your knowledge of the Beliefs, Ethics and Philosophy of each religion, with an explanatory note with each answer to help you on your way to success. \nMonitor your progress, post your results on Facebook and Twitter and challenge your friends. These self-assessment exercises are designed to help you to consolidate your knowledge and learn the essentials for your exams. They have been written by an experienced teacher and author of the subject with the aim of covering Edexcel, AQA and OCR syllabuses, and provide you with the ability to pick and choose the section relevant to you.\n\nWe have also included past papers from all three exam boards to make this the most complete revision app for GCSE Religious Studies \u2013 Christianity and Islam.\n\nKey Revision Topics covered:\nReligion in life and society: Christian Beliefs\nReligion in life and society: Christian Ethics\nReligion in life and society: Christian Philosophy\nReligion in life and society: Islamic Beliefs\nReligion In life and society: Islamic Ethics\nReligion in life and society: Islamic Philosophy\n\nFor full details on these topics please see our website: www.revisionbuddies.com \n\nRevision Buddies © 2012\nContent produced November 2012", "currency":"USD", "genres":["Education", "Reference"], "genreIds":["6017", "6006"], "releaseDate":"2012-12-10T08:36:54Z", "sellerName":"Revision Buddies Ltd", "bundleId":"com.revisionbuddies.gcsereligiousstudies", "trackId":580863000, "trackName":"GCSE Religious Studies", "primaryGenreName":"Education", "primaryGenreId":6017, "releaseNotes":"Updated past papers", "formattedPrice":"Free", "wrapperType":"software", "trackCensoredName":"GCSE Religious Studies", "languageCodesISO2A":["CS", "NL", "EN", "FR", "DE", "IT", "JA", "KO", "PL", "PT", "RU", "ZH", "ES", "SV", "ZH", "TR"], "fileSizeBytes":"21416183", "sellerUrl":"http://www.revisionbuddies.com", "contentAdvisoryRating":"4+", "artworkUrl100":"http://a764.phobos.apple.com/us/r30/Purple2/v4/d1/45/8f/d1458f73-c731-136c-bf5f-19c6debba492/mzl.eoyqnzuo.png", "trackViewUrl":"https://itunes.apple.com/us/app/gcse-religious-studies/id580863000?mt=8&uo=4", "trackContentRating":"4+"}, 
					{"kind":"software", "features":["iosUniversal"], 
						"supportedDevices":["iPadMini", "iPodTouchourthGen", "iPhone4S", "iPadMini4G", "iPadThirdGen4G", "iPad23G", "iPhone5c", "iPodTouchFifthGen", "iPhone-3GS", "iPadWifi", "iPad3G", "iPodTouchThirdGen", "iPhone5s", "iPadFourthGen", "iPadFourthGen4G", "iPadThirdGen", "iPhone5", "iPad2Wifi", "iPhone4"], "isGameCenterEnabled":false, 
						"screenshotUrls":["http://a1.mzstatic.com/us/r30/Purple/v4/f1/a0/a8/f1a0a89c-d6bc-cbb8-9a36-4aded26eaa59/screen480x480.jpeg", "http://a4.mzstatic.com/us/r30/Purple2/v4/21/d1/59/21d1598b-3afa-ea7a-708e-083849536002/screen480x480.jpeg", "http://a1.mzstatic.com/us/r30/Purple/v4/dc/dc/b6/dcdcb63c-c7fd-6355-75f4-a44aed439151/screen480x480.jpeg", "http://a1.mzstatic.com/us/r30/Purple2/v4/3d/c7/1f/3dc71f7f-e1c6-bb38-2a3f-8d5c72cd292e/screen480x480.jpeg", "http://a3.mzstatic.com/us/r30/Purple/v4/df/1f/bf/df1fbf97-cfa6-d96b-d41c-19322d912eb1/screen480x480.jpeg"], 
						"ipadScreenshotUrls":["http://a1.mzstatic.com/us/r30/Purple/v4/f6/a3/a1/f6a3a13d-4908-5a7d-3c07-7a98bf23716b/screen480x480.jpeg", "http://a5.mzstatic.com/us/r30/Purple2/v4/43/a1/d9/43a1d9ff-3b54-a234-d928-b06836738b5c/screen480x480.jpeg", "http://a4.mzstatic.com/us/r30/Purple/v4/c2/dd/fb/c2ddfb51-9c3f-9895-323d-17ae1424ff3c/screen480x480.jpeg", "http://a3.mzstatic.com/us/r30/Purple/v4/f6/d8/b2/f6d8b23c-5644-f8f6-7eb2-fa5844da9ad1/screen480x480.jpeg", "http://a5.mzstatic.com/us/r30/Purple2/v4/31/8c/fb/318cfbd0-56e2-3836-ed84-3fe4d7972899/screen480x480.jpeg"], "artworkUrl60":"http://a396.phobos.apple.com/us/r30/Purple/v4/e3/2b/cc/e32bcc14-2b1f-43a4-6836-2bde8457c03d/Icon.png", "artworkUrl512":"http://a709.phobos.apple.com/us/r30/Purple2/v4/e5/90/9b/e5909b3e-1caf-b45b-7689-486910b0cb1d/mzl.jbbagawg.png", "artistViewUrl":"https://itunes.apple.com/us/artist/revision-buddies/id536618150?uo=4", "artistId":536618150, "artistName":"Revision Buddies", "price":0.00, "version":"2.01", 
						"description":"Revision Buddies are here to help you to succeed in your exams! Get up to speed with your Higher French GCSE vocabulary and grammar, specifically orientated around the topics covered by Edexcel, OCR and AQA to ensure that you know your stuff to get an A*. There are over 1000 multiple choice questions for you to test yourself with, written by a qualified teacher we provide you with an explanation to each question whether you get it wrong or right.\nMonitor your progress, post your results on Facebook and Twitter and challenge friends to see if they can do better. These self-assessment exercises are designed to ensure that you have a good grounding in the grammar and language that you will need in your Higher French GCSE exams. \nWe have also included past papers from all three exam boards to make this the most complete revision app for GCSE French Higher.\n\nKey Revision Topics covered:\n\nHealth, Relationships and Sport\nRecognise and use a variety of the necessary vocabulary and grammar to express opinions on healthy and unhealthy lifestyles and their consequences; relationships with family and friends; thoughts for the future such as marriage and partnerships; discuss hobbies and interests, sporting events and lifestyle \n\nLeisure & Entertainment\nRecognise and use a variety of the necessary vocabulary and grammar to discuss your free time, plans, preferences and experiences; talk about what you do when you are getting around, socialising, special occasions and festivals as well as your opinions on TV, films, music, shopping, money, fashion, trends and technology\n\nTravel & Tourism\nRecognise and use the necessary vocabulary and grammar to discuss in detail how to travel, about experiences of holidays and exchanges \u2013 including the weather, accommodation, food, drink and cultural differences\n\nMedia & Culture\nRecognise and use the necessary vocabulary and grammar to describe and discuss music, film, reading and books, fashion, celebrities, religion, blogs and the internet\n\nHome & Environment\nRecognise and use the necessary vocabulary and grammar to describe your home and the local area, what your local region is like; to talk about life at home, facilities nearby and how you get around; to give opinions and discuss the current problems facing the planet and how to be environmentally friendly.\n\nEducation & Work\nRecognise and use the necessary vocabulary and grammar to describe your school, college and future plans as well as pressures and problems; to talk about current jobs, work experience/part-time jobs, school life, future study and jobs abroad\n\nKey Grammar covered: \nVerbs - regular and irregular, reflexive, negative forms, interrogative forms, impersonal verbs (\u2018il faut\u2019), verbs followed by an infinitive and prepositions; Tenses - the present tense, the perfect tense, the imperfect tense, the pluperfect tense, the conditional tense with \u2018vouloir\u2019, \u2018aimer\u2019 and \u2018pouvoir\u2019, the immediate future tense, the future tense the imperative; Articles - definite, indefinite and partitive; The use of the negative; Adverbs - comparative and superlative including \u2018mieux\u2019 and \u2018le mieux\u2019, regular, interrogative, of place and time; Noun agreements; Question words; Adjectives - agreements and position, possessive, demonstrative (\u2018ce\u2019, \u2018cette\u2019), comparative and superlative including \u2018meilleur\u2019 and \u2018pire\u2019, indefinite; Dates and time - including \u2018depuis\u2019 plus the present and imperfect tense; Pronouns - personal, reflexive, relative (\u2018qui\u2019 and \u2018que\u2019), emphatic, demonstrative, indefinite, interrogative, the use of \u2018y\u2019 and \u2018en\u2019, object: direct and indirect; Quantifiers and intensifiers (\u2018assez\u2019, \u2018beaucoup\u2019, \u2018peu\u2019 etc.); Conjunctions \nRecognising: The passive voice in the present, future, imperfect and perfect tenses; Using \u2018dont\u2019; Demonstrative and possessive pronouns (\u2018celui\u2019 and \u2018le mien\u2019); The subjunctive mood in the present tense and commonly used expressions\n\nRevision Buddies © 2012\nwww.revisionbuddies.com\nContent produced October 2012", "currency":"USD", "genres":["Education", "Travel"], "genreIds":["6017", "6003"], "releaseDate":"2012-11-27T02:01:59Z", "sellerName":"Revision Buddies Ltd", "bundleId":"com.revisionbuddies.gcsefrenchhigher", "trackId":578654982, "trackName":"GCSE French - Higher", "primaryGenreName":"Education", "primaryGenreId":6017, "releaseNotes":"Updated past papers", "formattedPrice":"Free", "wrapperType":"software", "trackCensoredName":"GCSE French - Higher", "languageCodesISO2A":["CS", "NL", "EN", "FR", "DE", "IT", "JA", "KO", "PL", "PT", "RU", "ZH", "ES", "SV", "ZH", "TR"], "fileSizeBytes":"21425628", "sellerUrl":"http://www.revisionbuddies.com", "contentAdvisoryRating":"4+", "artworkUrl100":"http://a709.phobos.apple.com/us/r30/Purple2/v4/e5/90/9b/e5909b3e-1caf-b45b-7689-486910b0cb1d/mzl.jbbagawg.png", "trackViewUrl":"https://itunes.apple.com/us/app/gcse-french-higher/id578654982?mt=8&uo=4", "trackContentRating":"4+"}, 
					{"kind":"software", "features":["iosUniversal"], 
						"supportedDevices":["iPadMini", "iPodTouchourthGen", "iPhone4S", "iPadMini4G", "iPadThirdGen4G", "iPad23G", "iPhone5c", "iPodTouchFifthGen", "iPhone-3GS", "iPadWifi", "iPad3G", "iPodTouchThirdGen", "iPhone5s", "iPadFourthGen", "iPadFourthGen4G", "iPadThirdGen", "iPhone5", "iPad2Wifi", "iPhone4"], "isGameCenterEnabled":false, 
						"screenshotUrls":["http://a5.mzstatic.com/us/r30/Purple2/v4/34/6f/99/346f9918-23c0-b87e-ab27-977ce7425658/screen480x480.jpeg", "http://a5.mzstatic.com/us/r30/Purple/v4/e0/7c/da/e07cdac2-46d8-e2fe-a4ed-b329e342d285/screen480x480.jpeg", "http://a4.mzstatic.com/us/r30/Purple2/v4/4e/f3/6b/4ef36bd4-0c3f-f595-33b7-aefbe88497fc/screen480x480.jpeg", "http://a2.mzstatic.com/us/r30/Purple2/v4/45/c3/aa/45c3aafc-eec1-0dfe-a350-ea558f42054f/screen480x480.jpeg", "http://a3.mzstatic.com/us/r30/Purple2/v4/8b/84/be/8b84be69-0e33-8b5f-ea77-79ca12f06737/screen480x480.jpeg"], 
						"ipadScreenshotUrls":["http://a5.mzstatic.com/us/r30/Purple/v4/d6/eb/56/d6eb5693-53da-b95a-74f5-1ae407b350e9/screen480x480.jpeg", "http://a4.mzstatic.com/us/r30/Purple/v4/eb/63/b2/eb63b209-4418-0344-e3f3-df7213a6f454/screen480x480.jpeg", "http://a4.mzstatic.com/us/r30/Purple/v4/fb/bd/3a/fbbd3a0c-1b1b-b1b2-4867-c39bc908eb47/screen480x480.jpeg", "http://a3.mzstatic.com/us/r30/Purple/v4/e5/87/90/e5879055-e9e0-36bd-a7bb-575a6c75f054/screen480x480.jpeg", "http://a4.mzstatic.com/us/r30/Purple2/v4/ba/80/5d/ba805d21-0cef-5ab6-783c-3d55e37ac42c/screen480x480.jpeg"], "artworkUrl60":"http://a1318.phobos.apple.com/us/r30/Purple2/v4/3d/8c/4f/3d8c4f50-9a05-c743-3c53-49816cf58af0/Icon.png", "artworkUrl512":"http://a537.phobos.apple.com/us/r30/Purple/v4/ef/0e/fc/ef0efcd1-2ea4-df5f-9c02-cc473f9cc61b/mzl.klbifuuy.png", "artistViewUrl":"https://itunes.apple.com/us/artist/revision-buddies/id536618150?uo=4", "artistId":536618150, "artistName":"Revision Buddies", "price":0.00, "version":"2.01", 
						"description":"Revision Buddies are here to help you to succeed in your exams! \n\nThis app has been created to help you make sure that you are up to speed with your Foundation French GCSE vocabulary and grammar, specifically orientated around the topics covered by Edexcel, OCR and AQA to ensure that you know your stuff to get up to a C grade. There are over 1000 multiple choice questions for you to test yourself with, written by a qualified teacher in the subject who provides you with an explanation to each question whether you get it wrong or right.\nMonitor your progress, post your results on Facebook and Twitter and challenge friends to see if they can do better. These self-assessment exercises are designed to ensure that you have a good grounding in the grammar and language that you will need in your Foundation French GCSE exams.\n\nWe have also included past papers from all three exam boards to make this the most complete revision app for GCSE French Foundation.\n\nKey Revision Topics covered:\nHealth, Relationships and Sport\nAbility to recognise and use a variety of the necessary vocabulary and grammar to express opinions on healthy and unhealthy lifestyles and their consequences; relationships with family and friends; thoughts for the future such as marriage and partnerships; to discuss hobbies and interests, sporting events and lifestyle\n\nLeisure and Entertainment \nAbility to recognise and use a variety of the necessary vocabulary and grammar to discuss your free time, plans, preferences and experiences; to talk about what you do when you are getting around, socialising, special occasions and festivals as well as your opinions on TV, films, music, shopping, money, fashion and trends as well as technology\n\nTravel and Tourism\nAbility to recognise and use the necessary vocabulary and grammar to discuss how to travel, about experiences of holidays and exchanges \u2013 including the weather, accommodation, food, drink and cultural differences\n\nMedia and Culture\nAbility to recognise and use the necessary vocabulary and grammar to describe and discuss music, film, reading and books, fashion, celebrities, religion, blogs and the internet\n\nHome and Environment\nAbility to recognise and use the necessary vocabulary and grammar to describe your home and the local area, what your local region is like; to talk about life at home, facilities nearby and how you get around; to give opinions and discuss the current problems facing the planet and how to be environmentally friendly\n\nEducation and Work\nAbility to recognise and use the necessary vocabulary and grammar to describe your school, college and future plans as well as pressures and problems; to talk about current jobs, work experience/part-time jobs school life, future study and jobs abroad\n\nGrammar covered: \n\nVerbs - regular and irregular, including reflexive, all persons of the verb, negative forms, interrogative forms, impersonal verbs (\u2018il faut\u2019), verbs followed by an infinitive and prepositions; Tenses - The present tense, the perfect tense, the imperfect tense (\u2018avoir\u2019, \u2018être\u2019, \u2018faire\u2019), the conditional tense with \u2018vouloir\u2019, \u2018aimer\u2019 and \u2018pouvoir\u2019, the immediate future tense, the imperative; Articles - definite, indefinite and partitive; The use of the negative; Adverbs - comparative and superlative, regular, interrogative, of place and time; Noun agreements;  Question words; Adjectives - agreements and position, possessive, demonstrative (\u2018ce\u2019, \u2018cette\u2019), comparative and superlative, indefinite; Dates and time - including \u2018depuis\u2019 plus the present tense; Pronouns - personal, reflexive, relative (\u2018qui\u2019 and \u2018que\u2019), emphatic, demonstrative, indefinite, interrogative; Quantifiers and intensifiers (\u2018assez\u2019, \u2018beaucoup\u2019, \u2018peu\u2019 etc.); Prepositions; Conjunctions such as \u2018mais\u2019 and \u2018puis\u2019\nRecognising: The passive voice; Other verbs in the imperfect tense; The future tense; The pluperfect tense, The present participle.\nRevision Buddies © 2012\nwww.revisionbuddies.com\nContent produced October 2012", "currency":"USD", "genres":["Education", "Travel"], "genreIds":["6017", "6003"], "releaseDate":"2012-11-26T08:00:00Z", "sellerName":"Revision Buddies Ltd", "bundleId":"com.revisionbuddies.gcsefrenchfoundation", "trackId":574293848, "trackName":"GCSE French - Foundation", "primaryGenreName":"Education", "primaryGenreId":6017, "releaseNotes":"Updated past papers", "formattedPrice":"Free", "wrapperType":"software", "trackCensoredName":"GCSE French - Foundation", "languageCodesISO2A":["CS", "NL", "EN", "FR", "DE", "IT", "JA", "KO", "PL", "PT", "RU", "ZH", "ES", "SV", "ZH", "TR"], "fileSizeBytes":"21422424", "sellerUrl":"http://www.revisionbuddies.com", "contentAdvisoryRating":"4+", "artworkUrl100":"http://a537.phobos.apple.com/us/r30/Purple/v4/ef/0e/fc/ef0efcd1-2ea4-df5f-9c02-cc473f9cc61b/mzl.klbifuuy.png", "trackViewUrl":"https://itunes.apple.com/us/app/gcse-french-foundation/id574293848?mt=8&uo=4", "trackContentRating":"4+"}]
			}
				

			trace(myObject.results[0].description);*/
			
			if(stage.fullScreenHeight == 1136)
			{
				Constants.STAGE_HEIGHT = 568;
			}
            
            var stageWidth:int   = Constants.STAGE_WIDTH;
            var stageHeight:int  = Constants.STAGE_HEIGHT;
			
			trace("height = "+stage.fullScreenHeight);
			trace("width = "+stage.fullScreenWidth);
			
            var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
            
            Starling.multitouchEnabled = true;  // useful on mobile devices
            Starling.handleLostContext = !iOS;  // not necessary on iOS. Saves a lot of memory!
            
            // create a suitable viewport for the screen size
            // 
            // we develop the game in a *fixed* coordinate system of 320x480; the game might 
            // then run on a device with a different resolution; for that case, we zoom the 
            // viewPort to the optimal size for any display and load the optimal textures.
            
            var viewPort:Rectangle = RectangleUtil.fit(
                new Rectangle(0, 0, stageWidth, stageHeight), 
                new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
                ScaleMode.SHOW_ALL);
            
            // create the AssetManager, which handles all required assets for this resolution
            
            var scaleFactor:int = viewPort.width < 480 ? 1 : 2; // midway between 320 and 640
            var appDir:File = File.applicationDirectory;
            var assets:AssetManager = new AssetManager(scaleFactor);
            
            assets.verbose = Capabilities.isDebugger;
            assets.enqueue(
                appDir.resolvePath("audio"),
                appDir.resolvePath(formatString("fonts/{0}x", scaleFactor)),
                appDir.resolvePath(formatString("textures/{0}x", scaleFactor))
            );
            
            // While Stage3D is initializing, the screen will be blank. To avoid any flickering, 
            // we display a startup image now and remove it below, when Starling is ready to go.
            // This is especially useful on iOS, where "Default.png" (or a variant) is displayed
            // during Startup. You can create an absolute seamless startup that way.
            // 
            // These are the only embedded graphics in this app. We can't load them from disk,
            // because that can only be done asynchronously (resulting in a short flicker).
            // 
            // Note that we cannot embed "Default.png" (or its siblings), because any embedded
            // files will vanish from the application package, and those are picked up by the OS!
            
            var backgroundClass:Class = scaleFactor == 1 ? Background : BackgroundHD;
			if(Constants.STAGE_HEIGHT == 568)
			{
				backgroundClass = BackgroundiPhone5;
			}
            var background:Bitmap = new backgroundClass();
            Background = BackgroundHD = null; // no longer needed!
            
            background.x = viewPort.x;
            background.y = viewPort.y;
            background.width  = viewPort.width;
            background.height = viewPort.height;
            background.smoothing = true;
            addChild(background);
            
            // launch Starling
            
            mStarling = new Starling(Root, stage, viewPort);
            mStarling.stage.stageWidth  = stageWidth;  // <- same size on all devices!
            mStarling.stage.stageHeight = stageHeight; // <- same size on all devices!
            mStarling.simulateMultitouch  = false;
            mStarling.enableErrorChecking = Capabilities.isDebugger;
            
            mStarling.addEventListener(starling.events.Event.ROOT_CREATED, 
                function onRootCreated(event:Object, app:Root):void
                {
                    mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
                    removeChild(background);
                    background = null;
                    
                    var bgTexture:Texture = Texture.fromEmbeddedAsset(backgroundClass, 
                                                                      false, false, scaleFactor);
                    
                    app.start(bgTexture, assets);
                    mStarling.start();
                });
            
            // When the game becomes inactive, we pause Starling; otherwise, the enter frame event
            // would report a very long 'passedTime' when the app is reactivated. 
            
            NativeApplication.nativeApplication.addEventListener(
                flash.events.Event.ACTIVATE, function (e:*):void { mStarling.start(); });
            
            NativeApplication.nativeApplication.addEventListener(
                flash.events.Event.DEACTIVATE, function (e:*):void { mStarling.stop(true); });
			
			try
			{
				Calendar.init( "6f1a81b2b93bc75dff2046404516f8b60f98f64cKRP0nn+VjOshnY/s+1+/kt1NaBFJf4X8EP6xIqmFpJFi2EAIWGePWmXBWdkd65Pl8bf5w2uXr9pBZuSiXY+YbQ==" );
				
				Calendar.service.addEventListener( CalendarStatusEvent.ACCESS_GRANTED, calendar_accessGrantedHandler, false, 0, true );
				Calendar.service.addEventListener( CalendarStatusEvent.ACCESS_DENIED,  calendar_accessDeniedHandler, false, 0, true );
				
				Calendar.service.addEventListener( CalendarStatusEvent.UI_SAVE, 	calendar_uiHandler, false, 0, true );
				Calendar.service.addEventListener( CalendarStatusEvent.UI_CANCEL,  	calendar_uiHandler, false, 0, true );
				Calendar.service.addEventListener( CalendarStatusEvent.UI_DELETE,  	calendar_uiHandler, false, 0, true );
				
				trace( "Calendar Supported: "+ String(Calendar.isSupported) );
				trace( "Calendar Version: " + Calendar.service.version );
			}
			catch (e:Error)
			{
				
			}
			Calendar.service.requestAccess();
			
			try
			{
				Dialog.init( "6f1a81b2b93bc75dff2046404516f8b60f98f64cKRP0nn+VjOshnY/s+1+/kt1NaBFJf4X8EP6xIqmFpJFi2EAIWGePWmXBWdkd65Pl8bf5w2uXr9pBZuSiXY+YbQ==" );
				
				trace( "Dialog Supported: "+ String(Dialog.isSupported) );
				trace( "Dialog Version: " + Dialog.service.version );
				
			}
			catch (e:Error)
			{
				trace( "ERROR::"+e.message );
			}
			
			
			
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
		
		
		private function calendar_accessGrantedHandler( event:CalendarStatusEvent ):void
		{
			trace( "GRANTED" );
			
			//
			//	Now lets try to create an event
			
		}
		
		
		private function calendar_accessDeniedHandler( event:CalendarStatusEvent ):void
		{
			trace( "DENIED" );
			
			//
			//	See what happens if you add an event with a denied calendar access under iOS
			//	You should see a message along the lines of "This app does not have access to your calendars"
			//	and the user will be forced to press "Cancel"
			//testCalendar();
		}
    }
}