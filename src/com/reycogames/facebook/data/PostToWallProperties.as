package com.reycogames.facebook.data
{
	public class PostToWallProperties extends Object
	{
		public var message		: String = "";
		public var link			: String = "";
		public var name			: String = "";
		public var description	: String = "";
		public var picture		: String = "";
		public var accesstoken	: String = "";
		public var caption		: String = "";
		
		public function PostToWallProperties()
		{
		}
		
		public function toObject():Object
		{
			var obj:Object 	= {};
			obj.message 	= message;
			obj.link 		= link;
			obj.name 		= name;
			obj.description = description;
			obj.picture 	= picture;
			obj.accesstoken = accesstoken;
			obj.caption 	= caption;
			return obj;
		}
	}
}