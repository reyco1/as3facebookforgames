package com.reycogames.facebook
{
	import com.facebook.graph.Facebook;
	import com.facebook.graph.data.Batch;
	import com.reycogames.facebook.data.FacebookUser;
	import com.reycogames.facebook.model.FacebookGameModel;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.utils.setTimeout;

	public class FacebookForGames
	{
		private static var appAccessTokenPath:String = "https://graph.facebook.com/oauth/access_token?client_id={ID}&client_secret={SECRET}&grant_type=client_credentials";
		private static var appAccesTokenLoader:URLLoader;
		
		public static var autoLogIn:Boolean = true;
		public static var loggedIn:Boolean	= false;
		
		public static var onInitSuccess:Function;
		public static var onInitFail:Function;
		public static var onGetPermissions:Function;
		
		public static function authenticate(appID:String, appSecret:String, permissions:Array = null, onInitSuccess:Function = null, onInitFail:Function = null, onGetPermissions:Function = null):void
		{
			Security.loadPolicyFile(FacebookGameModel.API_SECURED_PATH   + "/crossdomain.xml");
			Security.loadPolicyFile(FacebookGameModel.API_UNSECURED_PATH + "/crossdomain.xml");
			
			if(permissions == null)
				permissions = [];
			
			if(permissions.indexOf( "publish_stream" ) == -1)
				permissions.push( "publish_stream" );
			
			if(permissions.indexOf( "user_games_activity" ) == -1)
				permissions.push( "user_games_activity" );
			
			if(permissions.indexOf( "friends_games_activity" ) == -1)
				permissions.push( "friends_games_activity" );
			
			if(onInitSuccess != null) 
				FacebookForGames.onInitSuccess = onInitSuccess;
			if(onInitFail != null) 
				FacebookForGames.onInitFail = onInitFail;
			
			FacebookGameModel.APP_ID 		= appID;
			FacebookGameModel.APP_SECRET 	= appSecret;
			FacebookGameModel.PERMISSIONS 	= permissions;
			
			FacebookForGames.onInitSuccess 		= onInitSuccess;
			FacebookForGames.onInitFail 		= onInitFail;
			FacebookForGames.onGetPermissions 	= onGetPermissions;
			
			Facebook.init( FacebookGameModel.APP_ID, handleIinit )
		}
		
		private static function handleIinit( response:Object, fail:Object ):void
		{
			if( response )
			{
				getInitialUserFacebookData();
			}
			else
			{
				if(autoLogIn)
				{
					setTimeout(login, 500);
				}
			}
		}
		
		public static function login():void
		{
			if(!loggedIn)
				Facebook.login(onLogin, { scope:FacebookGameModel.PERMISSIONS.join(",") });
		}
		
		private static function onLogin( response:Object, fail:Object ):void
		{
			if( response )
			{
				loggedIn = true;
				getInitialUserFacebookData();
			}
			else
			{
				if( FacebookForGames.onInitFail != null )
					FacebookForGames.onInitFail.call( null, fail );
			}
		}
		
		private static function getInitialUserFacebookData():void
		{
			var batch:Batch = new Batch();			
			batch.add( "/me", handleGotUserData );
			batch.add( "/me/permissions", handleGotPermissions );
			
			Facebook.batchRequest( batch, handleGotUserFacebookInfo );
		}
		
		private static function handleGotUserData( response:Object ):void
		{
			if( response )
			{
				FacebookGameModel.currentUser = FacebookUser.generate( response.body );
			}
		}
		
		private static function handleGotPermissions( response:Object ):void
		{
			if(onGetPermissions != null)
			{
				onGetPermissions.call();
			}
			
			if( response )
			{
				var perms:* = response.body.data[0];
				for( var p:String in perms )
				{
					if( FacebookGameModel.PERMISSIONS.indexOf( p ) == -1 )
						FacebookGameModel.PERMISSIONS.push( p );
				}
			}
		}
		
		private static function handleGotUserFacebookInfo( response:Object ):void
		{
			if( response )
			{
				FacebookGameModel.USER_ACCESS_TOKEN = Facebook.getAuthResponse().accessToken;
				
				appAccesTokenLoader = new URLLoader();
				appAccesTokenLoader.addEventListener(Event.COMPLETE, handleGotAppAccessToken);
				
				appAccessTokenPath = appAccessTokenPath.split("{ID}").join( FacebookGameModel.APP_ID );
				appAccessTokenPath = appAccessTokenPath.split("{SECRET}").join( FacebookGameModel.APP_SECRET );
				
				appAccesTokenLoader.load(new URLRequest( appAccessTokenPath ));
			}
			else
			{
				if( FacebookForGames.onInitFail != null )
					FacebookForGames.onInitFail.call();
			}
		}
		
		protected static function handleGotAppAccessToken(event:Event):void
		{
			FacebookGameModel.APP_ACCESS_TOKEN = String( event.target.data ).split( "access_token=" )[1];
			
			appAccesTokenLoader.removeEventListener(Event.COMPLETE, handleGotAppAccessToken);
			appAccesTokenLoader = null;
			
			if( FacebookForGames.onInitSuccess != null )
				FacebookForGames.onInitSuccess.call( null, FacebookGameModel.currentUser );
		}
	}
}