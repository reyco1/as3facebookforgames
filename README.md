The Facebook For Games Library is an extension of the Facebook Actionscript API (packaged within the library as some changes needed to be made) which facilitates the process of authenticating and user log-in within your Facebook web games. It takes care of all the grunt work of logging in the user, if they are not logged in already, and then having the user authenticate your game ( all pretty much a single, swift process. )

Once your game is authenticated, you now have access to the game’s and user’s scores. The library also makes it extremely easy to save the score to Facebook and to share or post it to the user’s wall.

Main classes : 

FacebookForGames - ahdnles the authentication and login all under the hood.
ShareManager - Allows you to post the the users wall or open a share lnk popup.
ScoreManager - Allows you to get the scores for the game for the user and the user's frinds. Also allows you to save the user's score.
FacebookGameModel - Holds all the pertinent session, user and game data;

Data objects :

FacebookUser - holds all the pertinent information for the currently logged in user. An instance of this class for the current user is saved in FacebookGameModel.
Score : holds the score data including the application name and id and also the user name and id as well as their score.
