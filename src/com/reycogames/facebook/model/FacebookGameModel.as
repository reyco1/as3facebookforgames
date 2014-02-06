package com.reycogames.facebook.model
{
	import com.reycogames.facebook.data.FacebookUser;

	public class FacebookGameModel
	{
		public static const API_SECURED_PATH:String 	= "https://graph.facebook.com";
		public static const API_UNSECURED_PATH:String 	= "http://graph.facebook.com";
		
		public static var APP_ID:String					= "";
		public static var APP_SECRET:String				= "";
		public static var APP_ACCESS_TOKEN:String		= "";
		public static var USER_ACCESS_TOKEN:String		= "";
		public static var PERMISSIONS:Array				= null;
		
		public static var currentUser:FacebookUser		= null;
	}
}