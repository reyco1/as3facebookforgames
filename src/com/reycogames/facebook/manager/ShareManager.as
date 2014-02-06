package com.reycogames.facebook.manager
{
	import com.facebook.graph.Facebook;
	import com.reycogames.facebook.data.PostToWallProperties;
	
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class ShareManager
	{		
		public static var onPostSuccess:Function;
		public static var onPostFail:Function;
		
		public static function postToWall( properties:PostToWallProperties, onPostSuccess:Function = null, onPostFail:Function = null):void
		{
			if(onPostSuccess != null) 
				ShareManager.onPostSuccess = onPostSuccess;
			if(onPostFail != null) 
				ShareManager.onPostFail = onPostFail;
			
			Facebook.api( "/me/feed", handleShareComplete, properties, "POST" );
		}
		
		private static function handleShareComplete( response:Object, fail:Object ):void
		{
			if( response )
			{
				if( ShareManager.onPostSuccess != null )
					ShareManager.onPostSuccess.call( null, response );
			}
			else
			{
				if( ShareManager.onPostFail != null )
					ShareManager.onPostFail.call( null, fail );
			}
		}
		
		public static function showSharePopup( link:String ):void
		{
			var href:String = "http://www.facebook.com/sharer.php?u=" + link;
			viewPopup( href, "Share" );
		}
		
		public static function viewPopup(_address:String, _wname:String = "popup", _width:int = 600, _height:int = 400, _toolbar:String = "no", _scrollbar:String = "no", _resizeable:String = "yes"):void 
		{
			var address:String = _address;
			var wname:String = _wname;
			var w:int = _width;
			var h:int = _height;
			var t:String = _toolbar;
			var s:String = _scrollbar;
			var r:String = _resizeable;
			
			if (ExternalInterface.available) 
			{
				ExternalInterface.call("window.open", address, wname, "height=" + h + ",width=" + w + ",toolbar=" + t + ",scrollbars=" + s + ",resizable=" + r + "");
			}
			else 
			{
				var jscommand:String = "window.open('" + address + "','" + wname + "','height=" + h + ",width=" + w + ",toolbar=" + t + ",scrollbars=" + s + ",resizable=" + r + "');";
				var url:URLRequest = new URLRequest("javascript:" + jscommand + " void(0);");
				
				try
				{
					navigateToURL(url,"_self");
				} catch (e:Error) {
					trace("Popup failed", e.message);
				}
			}
		}
	}
}