package com.reycogames.facebook.data
{
	import com.facebook.graph.Facebook;

	public class PostToWallProperties
	{
		public var message		: String = "";
		public var link			: String = "";
		public var name			: String = "";
		public var description	: String = "";
		public var picture		: String = "";
		
		// do not edit
		public var access_token	: String = "";
		
		public function PostToWallProperties()
		{
			access_token = Facebook.getAuthResponse().accessToken;
		}
	}
}