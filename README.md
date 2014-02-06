<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Untitled Document</title>
</head>

<body>
<p>The Facebook For Games Library is an extension of the Facebook Actionscript API (packaged within the library as some changes needed to be made) which facilitates the process of authenticating and user log-in within your Facebook web games. It takes care of all the grunt work of logging in the user, if they are not logged in already, and then having the user authenticate your game ( all pretty much a single, swift process. )</p>
<p>Once your game is authenticated, you now have access to the game’s and user’s scores. The library also makes it extremely easy to save the score to Facebook and to share or post it to the user’s wall.</p>
<p><strong>Main classes : </strong></p>
<ol>
  	<li><strong>FacebookForGames</strong> - ahdnles the authentication and login all under the hood.</li>
    <li><strong>ShareManager</strong> - Allows you to post the the users wall or open a share lnk popup.</li><li><strong>ScoreManager</strong> - Allows you to get the scores for the game for the user and the user's frinds. Also allows you to save the user's score.</li>
    <li><strong>FacebookGameModel</strong> - Holds all the pertinent session, user and game data.</li>
</ol>
<p><strong>Data objects :</strong></p>
<ol>
    <li><strong>FacebookUser</strong> - holds all the pertinent information for the currently logged in user. An instance of this class for the current user is saved in FacebookGameModel.</li>
    <li><strong>Score</strong> : holds the score data including the application name and id and also the user name and id as well as their score.</li>
</ol>
</p>
</body>
</html>
