package com.reycogames.facebook.data
{
	import com.facebook.graph.Facebook;

	public class Score extends Object
	{
		public var applicationId:String;
		public var applicationName:String;
		public var userId:String;
		public var userName:String;
		public var score:int;
		public var imageUrl:String;
		
		public function Score( scoreData:Object = null )
		{
			if(scoreData)
			{
				applicationId 	= String( scoreData.application.id );
				applicationName = String( scoreData.application.name );
				userId 			= String( scoreData.user.id );
				userName 		= String( scoreData.user.name );
				score 			= int( scoreData.score );				
				imageUrl 		= Facebook.getImageUrl( userId );
			}
		}
	}
}