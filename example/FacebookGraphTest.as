package
{
	import com.facebook.graph.controls.Distractor;
	import com.reycogames.facebook.FacebookForGames;
	import com.reycogames.facebook.data.FacebookUser;
	import com.reycogames.facebook.data.PostToWallProperties;
	import com.reycogames.facebook.data.Score;
	import com.reycogames.facebook.manager.ScoreManager;
	import com.reycogames.facebook.manager.ShareManager;
	import com.reycogames.facebook.model.FacebookGameModel;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	[SWF( width="600", height="450", frameRate="60" )]
	public class FacebookGraphTest extends Sprite
	{
		private var appID:String 		= "";
		private var appSecret:String 	= "";
		private var permissions:Array	= [ "publish_stream" ];
		private var distractor:Distractor;
		
		private var someRandomScore:int = 500;
		
		public function FacebookGraphTest()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			distractor = new Distractor();
			distractor.text = "Loading";
			addChild( distractor );
			
			FacebookForGames.authenticate( appID, appSecret, permissions, handleFBInit );
		}
		
		private function handleFBInit( facebookUser:FacebookUser ):void
		{
			removeChild( distractor );
			distractor = null;
			
			trace( FacebookGameModel.currentUser.first_name + " is ready to go!" );
			
			ScoreManager.getScoresForGame( handleGotScores );
		}
		
		private function handleGotScores( scores:Vector.<Score> ):void
		{
			for (var a:int = 0; a < scores.length; a++) 
			{
				trace( scores[a].userName, scores[a].score );
			}
		}
		
		private function sendScores():void
		{
			ScoreManager.postScore( someRandomScore, handleScorePosted );
		}
		
		private function handleScorePosted():void
		{
			trace( "score saved" );
			
			var postToWallProps:PostToWallProperties = new PostToWallProperties();
			postToWallProps.name = " I just scored " + someRandomScore + "!";
			postToWallProps.description = "[some description about your game]";
			postToWallProps.link = "http://[link to my game].com";
			postToWallProps.picture = "http://[some link to an image]";
			
			ShareManager.postToWall( postToWallProps, handlePostSuccess );
		}
		
		private function handlePostSuccess( result:Object ):void
		{
			trace( "score shared on wall" );
		}
	}
}