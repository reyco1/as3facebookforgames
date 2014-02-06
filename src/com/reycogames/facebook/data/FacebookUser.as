package com.reycogames.facebook.data
{
	import com.facebook.graph.Facebook;

	public class FacebookUser
	{
		public var first_name:String; 
		public var gender:String; 
		public var id:String; 
		public var last_name:String; 
		public var link:String; 
		public var locale:String; 
		public var name:String; 
		public var timezone:Number; 
		public var updated_time:String; 
		public var username:String; 
		public var verified:Boolean; 
		public var work:Array; 
		public var imageUrl:String;
		
		public function FacebookUser( userData:Object )
		{
			for( var param:String in userData )
			{
				try
				{
					this[ param ] = userData[ param ];
				}
				catch(e:*)
				{  
					//trace("[FacebookUser]", "\"" + param + "\"", "not registered.");
					// continue silently
				}
			}	
			
			imageUrl = Facebook.getImageUrl( id );
		}
		
		public static function generate(response:Object):FacebookUser
		{
			var user:FacebookUser = new FacebookUser( response );
			return user;
		}
	}
}