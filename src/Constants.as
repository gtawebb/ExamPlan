package
{
    import starling.errors.AbstractClassError;

    public class Constants
    {
        public function Constants() { throw new AbstractClassError(); }
        
        // We chose this stage size because it is used by many mobile devices; 
        // it's e.g. the resolution of the iPhone (non-retina), which means that your game
        // will be displayed without any black bars on all iPhone models up to 4S.
        // 
        // To use landscape mode, exchange the values of width and height, and 
        // set the "aspectRatio" element in the config XML to "landscape". (You'll also have to
        // update the background, startup- and "Default" graphics accordingly.)
        
        public static var STAGE_WIDTH:int  = 320;
        public static var STAGE_HEIGHT:int = 568;
		
		public static const SERVICE:String = "GCSETIMETABLE";
		
		public static const TEST:Vector.<Object> = new <Object>
			[
				{heading:"Plan carefully",body:"On the day of your exam make sure that you know when and where the exam is and get" +
					" there in plenty of time. Make sure you have everything with you that you need – pens, pencils, rubber, calculator? and that you have any identification or" +
					" necessary details.<br><br>When you open the paper, read the whole thing prior to picking up your pen, then read it again.  Use this time to work out which" +
					" questions you’re going to do and how much time you are going to spend on each one and note the mark scheme so that you can time the answer accordingly.<br><br>Read" +
					" what is required of you on the front page of the paper carefully, answering the wrong sections/ too many questions in the exam would be devastating.<br><br>Make" +
					" sure you write down your timings to help you feel in control and do your best to stick to these as closely as possible - give yourself 10 minutes to read over your" +
					" answers at the end.<br><br>Don’t panic if you run over your time scale by a few minutes, but do ensure that you will be able to make it up. Running out of time makes" +
					" the exam stressful and you won’t perform as well.<br><br>Remember that an exam isn’t about showing how much you know, it is about answering a question properly and" +
					" demonstrating that you are able to apply your knowledge correctly. You might be tempted to answer a question on a subject that you know lots about, but it might actually" +
					" be a difficult question and the subject that you find more difficult may have a question that you can answer better. Choose the questions that you are able to answer" +
					" most effectively."},
				{heading:"Give yourself a clue – Look at the mark scheme",body:"Look at the mark scheme to make sure that you will be answering the question as required. If a question has 3 marks, it is likely to be expecting" +
					" you to point out 3 things, bear this in mind. It will also require less time than a 15 mark answer."},
				{heading:"Start with the easiest question",body:"In doing this you will:<br><br>1) Boost your confidence because you will have safely completed a question that you are pleased with<br><br>2) If it is the easiest, " +
					"you should find you spend less time on it. It gives you the opportunity" +
					" to answer it well, but to also give you more time for the question that you think might be harder, without having to start it and then come back to it in fear of running" +
					" out of time."}
			];
		
		public static const TIPS_TITLES:Vector.<String> = new <String>["Revision Tips","Creating your revision timetable","Staying healthy","Dealing with stress","24 hour countdown",
			"In the exam"];
		
		public static const TIPS_DETAILS_SUBS:Vector.<String> = new <String>["It’s all worth it in the end! Work hard, stay focused and remember to relax."
			,"Your revision timetable will be one of the most useful things that you can create to keep yourself organised and ensure that you cover all the subjects that you need" +
			" to in enough detail. The key to this is planning what you need to cover, but doing so in a way that will work best for you, that you feel is manageable and is done" +
			" in a way that helps you remember things.<br><br>Being prepared will help you feel ready for when the exams come round so you can take them all in your stride!"
			,"Healthy food, getting sleep, taking regular exercise and maintaining a work / life balance all contribute to keeping healthy and feeling positive in the run up to exams."
			,"Exams are stressful times – Here are a few things which we think are helpful ways of dealing with stress:"
			,"GOOD LUCK AND KEEP SMILING – YOU ARE NEARLY THERE!"
			,"Here are RB’s tips for dealing with the exams themselves. Don’t forget that panicking gets you nowhere, stay calm and if the questions are tricky remember that everyone" +
			" will likely be thinking the same, so your chances haven’t changed. If you have done effective revision and stayed healthy with good amounts of sleep your brain will be" +
			" ready to perform."];
		
		
		public static const TIPS_DETAILS_HEADERS_5:Vector.<String> = new <String>["Plan carefully","Give yourself a clue – Look at the mark scheme","Start with the easiest question",
			"Answer the question!","If you get stuck, move on","Keep hydrated and energised","Show your workings","Running out of time?","Why are you leaving early?"];
		
		public static const TIPS_DETAILS_BODIES_5:Vector.<String> = new <String>["On the day of your exam make sure that you know when and where the exam is and get" +
			" there in plenty of time. Make sure you have everything with you that you need – pens, pencils, rubber, calculator? and that you have any identification or" +
			" necessary details.<br><br>When you open the paper, read the whole thing prior to picking up your pen, then read it again.  Use this time to work out which" +
			" questions you’re going to do and how much time you are going to spend on each one and note the mark scheme so that you can time the answer accordingly.<br><br>Read" +
			" what is required of you on the front page of the paper carefully, answering the wrong sections/ too many questions in the exam would be devastating.<br><br>Make" +
			" sure you write down your timings to help you feel in control and do your best to stick to these as closely as possible - give yourself 10 minutes to read over your" +
			" answers at the end.<br><br>Don’t panic if you run over your time scale by a few minutes, but do ensure that you will be able to make it up. Running out of time makes" +
			" the exam stressful and you won’t perform as well.<br><br>Remember that an exam isn’t about showing how much you know, it is about answering a question properly and" +
			" demonstrating that you are able to apply your knowledge correctly. You might be tempted to answer a question on a subject that you know lots about, but it might actually" +
			" be a difficult question and the subject that you find more difficult may have a question that you can answer better. Choose the questions that you are able to answer" +
			" most effectively."
			,"Look at the mark scheme to make sure that you will be answering the question as required. If a question has 3 marks, it is likely to be expecting" +
			" you to point out 3 things, bear this in mind. It will also require less time than a 15 mark answer."
			,"In doing this you will:<br><br>1) Boost your confidence because you will have safely completed a question that you are pleased with<br><br>2) If it is the easiest, " +
			"you should find you spend less time on it. It gives you the opportunity" +
			" to answer it well, but to also give you more time for the question that you think might be harder, without having to start it and then come back to it in fear of running" +
			" out of time."
			,"It sounds silly, but it is one of the most crucial things to remember. Look for the key words in the question - is it asking you to describe, calculate, analyse, discuss" +
			" the difference between or the benefits of? If you don't answer the question, no matter how good your knowledge is, you won't get the marks.","If you get stuck, move on"
			,"On papers with lots of questions, like maths or science, be careful not to wind yourself up on a question that you get stuck on. You don’t have time. Move to the next" +
			" question and come back to it later, you will be surprised how your brain might work when it returns to the question, it will be a bit refreshed and possibly confident" +
			" that you have managed to answer other questions<br><br>Don’t forget to use your common sense, take a stab at answers even if you don’t know the answer for sure, it" +
			" could be worth some marks. Noone can give you marks for a blank space."
			,"Take some water in with you and sip it slowly (don’t drink too much, you don’t want to be going for a pee). Check this out to see the " +
			"benefits: http://www.bbc.co.uk/news/education-17741653).Take in a chocolate bar or banana too if you think you might need an energy boost"
			,"This goes for all exams. Make sure you explain to the examiner what you are doing. For a maths exam, even if you come to the wrong answer, if you can show that you used" +
			" the right method, you will get some marks. In a written paper, if you show your essay plan but you run out of time, you will still get marks credited. It is always worth it."
			,"Sometimes this happens and if it does you need to know how best to deal with the situation. If you have 2 questions left but you don’t have time to do them both, you" +
			" should write plans for each, write the beginning of your answer for both and then bullet point the rest of your answer, or for a maths question, detail what calculations" +
			" you would do to get to the answer. You get more points at the start of an answer than at the end, so this means that you will maximise your marks."
			,"Unless you are 100% sure that you are going to score 100%, you should not walk out of an exam early. Read over your answers," +
			" double check your calculations, check that your essay answer covers all the points in the plan. Then check again."];
		
		
		public static const TIPS_DETAILS_HEADERS_4:Vector.<String> = new <String>["Rule number 1","Rule number 2","Rule number 3","Rule number 4","Rule number 5"];
		
		public static const TIPS_DETAILS_BODIES_1:Vector.<String> = new <String>["Stock up on things that you will need so you’re ready to go:<br><br>Highlighters<br>Pens<br>Revision " +
			"Cards<br>Post it notes<br>Paper<br><br>Make sure that you have a quiet, calm area for studying, with no distractions."
			,"Making a revision plan requires breaking things down into manageable chunks – and before putting together your planner, splitting subjects into key topics that you know you" +
			" need to cover for each exam is the starting point to help you figure out how much work will be involved for each one.<br><br>There will be some subjects that are longer than" +
			" others, and there will be some that you feel you know already – if you have a list for each one, that could also help as it’s very satisfying to cross them off once you’ve" +
			" covered them."
			,"This is very much up to you to decide what works for you – we would suggest creating a full version which takes you right up to the exams from the start of when you’re going" +
			" to revise and then creating a smaller weekly version that you can update as you go. It can be as detailed as you’d like it to be but having written out your topic lists," +
			" breaking it down within each subject header would be helpful.<br><br>Starting early is important, your brain will not be able to recall as well if you cram all of your" +
			" revision into a space of 3 weeks of all day revising."
			,"It’s tempting sometimes to stick to learning the things you like to learn about or find easiest, but as you will have subjects that you might not enjoy so much, it’s good to" +
			" have time allocated in which to cover them so you do give them some attention.<br><br>It’s a good idea to balance the subjects that you enjoy with those that you might" +
			" not want to do so much – maybe to two sessions a day that you will like, and one or two that you might not."
			,"Using the same principle of breaking your revision down into manageable chunks – you will know how best you work and when your concentration levels might dip – if that’s 45" +
			" minutes, then put in 45 minutes sections. If you can do an hour, then do an hour or even up to an hour and a half if that works for you, although you should include regular" +
			" breaks throughout the day to get a drink / snack / go for a walk / watch some tv."
			,"Some people concentrate best in the morning, others better in the afternoon – you need to choose what works for you and plan accordingly. If you lose concentration in the afternoon," +
			" do more in the morning so you have a productive day."
			,"It’s always good to have some down time and you don’t want to be completely put off by your timetable – it needs to be manageable and workable. You need to give your mind a chance" +
			" to process all you’re learning, and also to have fun whilst you are also revising so include some breaks of a whole morning / afternoon / day / weekend so you can go and do something" +
			" completely different and take your mind off work."
			,"Varying your revision techniques can also be a way to make things seem less formulaic and boring.<br><br>There might be days you want to read textbooks and make summary notes, there" +
			" might be days where you have practice questions / example essays you can do too – fit these into the timetable where you think this might be a nice way to round up / finish off" +
			" a topic or would like a bit of a change of pace. It’s always good to practice an exam paper – this helps you to focus, understand the format of your exam and will also help you" +
			" with planning your timing of questions.<br><br>Mind mapping is like a spidergram of all the information you have on a topic too – this is another way to display your notes so" +
			" could be a nice way to go over your revision? Revising with a friend could also be good as you will share information and talking through topics can also help details stick" +
			" in your mind."
			,"There will be times that you really don’t fancy revising at all. If this is the case, then take the afternoon off and add in the sessions you had planned into another day / put" +
			" into a break day instead perhaps.<br><br>Equally, there will also be times when you’ll be absorbed in a subject and want to continue with it instead of breaking your train of" +
			" thought – if so, just rejig accordingly too.<br><br>You might well end up rewriting your planner out a few times, but that’s fine – it’s got to be a timetable that works for you." +
			" If you’re too rigid it could end up seeming like it’s not helping you be organised, so just adapt it accordingly."
			,"Colour coding is very useful – this is up to you as to what works best but you could do this subject by subject perhaps or by what type of revision technique you’re going to use." +
			" This will also brighten up what could be quite a black and white timetable – try and make it look in some way appealing – it will help just to look at it!"
			,"Once you have your exam timetable – put it in your planner. This will give you a good idea of how long you have left until your exam dates. It will also help you to know  what you’ll" +
			" need to concentrate on nearer the time for any final revision, and you will have the end date in sight so you can start making a plan and looking forward to your free time!"
			,"Once you’ve made your plan, share it with your family so that they can support you and they know when they can and can’t disturb you. Now you're prepared, you know how much time you have" +
			" to learn a certain number of topics. You can revise without panicking, which will enhance your revision time and help you feel in control of your exams"];
		
		public static const TIPS_DETAILS_HEADERS_1:Vector.<String> = new <String>["Getting organised","Split out key topics within each subject","Creating a planner","Mix it up","How long should" +
			" I revise for at a time?","Try to plan to work at times that are best for you","Give yourself a break from time to time – plan in downtime","Build in a variation of" +
			" revision / practice questions / creating essay plans / mindmapping / revise with a friend","Be flexible","Colour codes","Getting your exam timetable","Share your exam timetable "];
		
		public static const TIPS_DETAILS_BODIES_4:Vector.<String> = new <String>["Stock up the short term memory<br><br> It is too late to learn new things, you just want to be consolidating" +
			" your knowledge at this point. Our apps are great for this, but you might also find that writing out your key facts for certain subject areas helpful too. You can write brief essay" +
			" plans to questions or practice applying your knowledge to past papers"
			,"Go for a run<br><br>Take some exercise. Make sure your body is fit and that your blood is pumping, it helps your brain work and gives you some time to let information settle "
			,"Eat well!<br><br>You need to feed your brain, give it some protein and steer clear of heavy carbohydrates which can slow you down.  Avoid the false sugar highs from sweets and" +
			" chocolate, have a banana instead. Add some vegetables to the mix to keep you nice and healthy "
			,"Get a good night’s sleep!<br><br>You don’t want to be tired in the exam otherwise you won’t be able to perform properly. Go to bed at a good time and make sure that your brain" +
			" isn’t still whirring with all the things you need to know.<br><br>To stop night time panic, it is good to have a check list of the points you want to have covered and to run over" +
			" them prior to finishing your revision for the day so that you can rest assured that you have done them"
			,"Be prepared<br><br>Know where the exam is, what time it is, get there in plenty of time and know the format of the exam. Take everything you need into the exam, including some water" +
			" to keep you nicely hydrated, and maybe a banana to boost energy levels"];
		
		public static const TIPS_DETAILS_HEADERS_2:Vector.<String> = new <String>["A balanced diet","Sleep","Exercise","Take regular breaks "];
		
		public static const TIPS_DETAILS_BODIES_2:Vector.<String> = new <String>["Eat lots of vegetables – they will give you lots of minerals and nutrients to keep you going and make you feel better" +
			" in yourself.<br><br>Protein and carbohydrate are also very important – having a good combination of all the food types will help your brain tick over and give you the energy you require." +
			" Brain power comes from somewhere and this is mainly from food!<br><br>Avoid things that will give you a quick hit of energy and then make you feel sluggish afterwards. The concept of a" +
			" sugar high is a real thing –  sugar does not give sustainable energy that your body can process and keep – natural sugars from fruit are much better for you and a banana will give you" +
			" longer lasting energy than a Mars Bar."
			,"Sleep is so important as it gives your body the break it needs. Brain recall becomes stronger after sleep and information becomes easier to access. Make sure you get enough of it –" +
			" and not too much – between 6 and 8 hours a day is optimum. This will help you feel much more alert and less stressed.<br><br>If you’re struggling to sleep, get yourself a good" +
			" book, or watch a film before going to bed so that you can stop your brain whirring and your body can rest effectively for the next day. "
			,"Taking exercise is also very important to keep your energy levels up and also get your circulation going. You don’t have to do anything too vigorous, just taking yourself for a walk," +
			" getting some fresh air and looking around you rather than book after book is good. Whilst sitting in front of a desk is a necessary part of revision, you need to get your legs" +
			" moving too!"
			,"This is like taking exercise – it’s important not to be chained to your desk all the time. If you’ve done a good session of revision then reward yourself for this and do something fun." +
			" Staying happy is an important part of being healthy."];
		
		public static const TIPS_DETAILS_HEADERS_3:Vector.<String> = new <String>["Be organised","Prepare properly –have an organised revision plan","Try not to panic and remember your brain" +
			" is a very clever thing","Take a deep breath ","Get some sleep","Eat well and in a balanced way","Talk to your friends","Remember - it’s ok!","Most importantly – stress can be good for you! "
			,"And Finally….make a plan for when they’re over"];
		
		public static const TIPS_DETAILS_BODIES_3:Vector.<String> = new <String>["Get to the exams on time – know when you exams are being held, where you need to be and how long you should get" +
			" there before they start.<br><br>Make sure you have pens that work (it sounds silly, but it’s happened before) and that if you need a calculator – this works too. Also make sure you" +
			" have protractor / compass or other things you might need for certain exams"
			,"It’s as much about the build up to exams as it is with taking them – if you feel prepared for them, this will help so much with avoiding any last minute worry that you haven’t" +
			" covered the topics you needed to. Last minute cramming of information can be really stressful and you can feel that you are overloading your brain!"
			,"You might feel just before your exams that you can’t remember anything you’ve spent months trying to learn – try and relax and trust your brain – things will come to mind if you" +
			" don’t panic.<br><br>Your brain is a very powerful tool – the most high powered, high tech computer is nowhere near as complex and clever as what you have there. Scientists are" +
			" constantly trying to get somewhere close!"
			,"This doesn’t need to be done in an overt way so people realise you might be panicking, but taking a deep breath when you sit down and open your paper can help just calm your" +
			" nerves a bit and gets the oxygen flowing around your body too.  Don’t forget, if you’re finding the paper tricky, the likelihood is that everyone around you is too."
			,"Sleep helps so much in helping you sort and retain information and also makes you feel much better. Lack of sleep can lead you to becoming worried. If you can’t sleep the" +
			" night beforehand though, don’t worry about this – most of the world’s leaders survive on 4 hours sleep and they function pretty well most of the time!"
			,"Having a good diet will make you feel much more alert, better in yourself and will give you the brain power and energy you need. Lots of carbohydrate at lunch time can" +
			" make you feel very sleepy as your body needs to process this heavy food  so we’d suggest not eating a baked potato before an afternoon exam  - save it until the evening."
			,"They might be finding revision and the lead up to exams tricky too and talking to them could be very cathartic. They will understand how you are feeling as they are in the same boat."
			,"It’s normal to find exams stressful – not many people think they’re a bundle of fun!<br><br>Everyone in your year group is having to do this as well – you’re not the only one." +
			"<br><brThey will end – exams are only an hour / two hours – not too long really in the grand scheme of things!"
			,"Stress IS good for you – within reason – it keeps your brain sharp and can help you focus your mind."
			,"They will be over at some point! And then you can go and have a great summer holiday – make plans to do something you can really look forward to – then it will all be worth it!"];
		
		public static const TIPS_DETAILS_HEADERS_0:Vector.<String> = new <String>["Test yourself!","Know how to apply your knowledge","Help yourself to remember",
			"Understand your brain: focus","Don’t panic!","Stay healthy"];
		
		public static const TIPS_DETAILS_BODIES_0:Vector.<String> = new <String>["It is all very well reading what you need to know, but you need to make sure that you have learnt it. Some" +
			" people find that they learn more if they take notes whilst reading, then test themselves on the notes that they have taken. This will make your revision time rewarding and" +
			" also mean that you know what you need to look over again."
			,"Revising isn’t just about getting to grips with what to know, it’s also about making sure you know how to apply it. For subjects like maths, the question/answer format is" +
			" relatively simple, but for essay based subjects like English literature and history, you need to make sure that you use the facts that you know correctly in order to" +
			" answer the question properly.<br><br>Look at past papers to familiarise yourself with the exam format and ask your teacher for ideas on what questions might come up and" +
			" then practise writing essay plans or spider diagrams – you don’t need to write a full blown essay, just know how you would apply the facts that you know correctly to the" +
			" question."
			,"Not going in? Our brains tend to remember stuff more easily if we are interested in them, so if a formula, date or name isn’t easy to remember, make it so that it is" +
			" memorable to you.<br><br>Ever use the saying 'Never Eat Shredded Wheat' to remember your North South East and West? Try it for the spelling of funny sounding names" +
			" or the order of the planets - make it relevent to you and it will be so much easier to remember."
			,"Your brain focuses best when there are no distractions: turn off your phone, shut down the internet. This is about you and your exams and nothing else. Your brain is" +
			" at its most alert in the morning, so try to focus on the stuff you find most difficult then.<br><br>Learning late at night is less effective and will make it hard" +
			" to sleep, so let your brain do something else before hitting the pillow.<br><br>Most people’s brains need a rest after 40 or so minutes so break up your revision" +
			" sessions with 10 minute breaks and give yourself a nice reward so that you have something to work towards, whether it be looking at FB or checking the football scores." +
			" Make sure you give yourself a little shake, or 5 star jumps, and get your blood moving so that you stay awake and your brain remains alert. "
			,"Make a revision timetable, and don’t over expect of yourself. Be realistic about what you can cover and when. You don’t want to cram, so start early, testing yourself" +
			" over a long period of time will give you a better chance of remembering with more accuracy and confidence.<br><br>Give yourself good breaks and make sure you have" +
			" a part of the day to relax. Consider putting your exam timetable in a public place so that your family can support you and knows when you are and aren’t meant to be studying."
			,"Make sure you get good sleep and eat healthily. Drink plenty of water and try not to snack too much. Try to eat fruit and nuts over crisps and chocolate. Get some exercise," +
			" whether just a walk around the block or a game of football, your body works better when it is fit, and you will find that you are more energetic and able to concentrate better."];
		
		

    }
}