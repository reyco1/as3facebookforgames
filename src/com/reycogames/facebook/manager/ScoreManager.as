package com.reycogames.facebook.manager
{
	import com.facebook.graph.Facebook;
	import com.reycogames.facebook.data.Score;
	import com.reycogames.facebook.model.FacebookGameModel;

	public class ScoreManager
	{		
		public static var onGetScoresSuccess:Function;
		public static var onGetScoresFail:Function;
		public static var onPostScoreSuccess:Function;
		public static var onPostScoreFail:Function;
		
		public static function getScoresForGame( onGetScoresSuccess:Function = null, onGetScoresFail:Function = null ):void
		{
			if(onGetScoresSuccess != null) 
				ScoreManager.onGetScoresSuccess = onGetScoresSuccess;
			if(onGetScoresFail != null) 
				ScoreManager.onGetScoresFail = onGetScoresFail;
			
			Facebook.api( "/" + FacebookGameModel.APP_ID + "/scores", handleGetUserScoreRequest);
		}
		
		public static function getScoresForUser( onGetScoresSuccess:Function = null, onGetScoresFail:Function = null ):void
		{
			if(onGetScoresSuccess != null) 
				ScoreManager.onGetScoresSuccess = onGetScoresSuccess;
			if(onGetScoresFail != null) 
				ScoreManager.onGetScoresFail = onGetScoresFail;
			
			Facebook.api( "/" + FacebookGameModel.USER.id + "/scores", handleGetUserScoreRequest);
		}
		
		private static function handleGetUserScoreRequest( response:Object, fail:Object ):void
		{
			if( response )
			{
				var scores:Vector.<Score> = new Vector.<Score>();
				for (var a:int = 0; a < response.length; a++) 
				{
					scores.push( new Score(response[a]) );
				}
				
				if(onGetScoresSuccess != null)
					ScoreManager.onGetScoresSuccess.call( null, scores );
			}
			else
			{
				if(onGetScoresFail != null) 
					ScoreManager.onGetScoresFail( null, fail );
			}
		}
		
		public static function postScore( score:Number, onPostScoreSuccess:Function = null, onPostScoreFail:Function = null ):void
		{
			if(onPostScoreSuccess != null) 
				ScoreManager.onPostScoreSuccess = onPostScoreSuccess;
			if(onPostScoreFail != null) 
				ScoreManager.onPostScoreFail = onPostScoreFail;
			
			var params:Object = 
				{
					score		 : score,
					access_token : FacebookGameModel.APP_ACCESS_TOKEN
				};
			
			Facebook.api(  Facebook.getAuthResponse().uid + "/scores/", handleScoresSent, params, "POST" );
		}
		
		private static function handleScoresSent( response:Object, fail:Object ):void
		{
			if( response )
			{
				if( ScoreManager.onPostScoreSuccess != null )
					ScoreManager.onPostScoreSuccess.call( null, response );
			}
			else
			{
				if( ScoreManager.onPostScoreFail != null )
					ScoreManager.onPostScoreFail.call( null, fail );
			}
		}
	}
}