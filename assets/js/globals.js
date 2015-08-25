
var applicationName 			= "Cheer Store";
var applicationShortDescription = "";
var applicationLongDescription 	= "";
var appworldid 					= "";
var appworldvendorid 			= "673";
var appworldurl 				= "appworld://content/" + appworldid;
var appworldshareurl 			= "http://appworld.blackberry.com/webstore/content/" + appworldid;
var shareText 					= "Check out " + applicationName + " - An Android Apps Store for #BlackBerry10:" + appworldshareurl + " #TeamBlackBerry";

var defaultTitleBarColorBright 	= "#ea5c21";
var defaultTitleBarColorDark 	= "#383838";
var defaultBackgroundImage 		= "";

function urlify(text) 
{
    var urlRegex = /(https?:\/\/[^\s]+)/g;
    
    return text.replace(urlRegex, function(url) 
    {
            return '<a href="' + url + '">' + url + '</a>';
    });
}

function categoryNameToID(name)
{
    var id = 0;
    
    if(name == "All Applications")
    {
        id = 0;
    }
    else if(name == "All Games")
    {
        id = 1;
    }
    else if(name == "Books and References")
    {
        id = 2;
    }
    else if(name == "Business")
    {
        id = 3;
    }
    else if(name == "Comics")
    {
        id = 4;
    }
    else if(name == "Communication")
    {
        id = 5;
    }
    else if(name == "Education")
    {
        id = 6;
    }
    else if(name == "Entertainment")
    {
        id = 7;
    }
    else if(name == "Finance")
    {
        id = 8;
    }
    else if(name == "Health and Fitness")
    {
        id = 9;
    }
    else if(name == "Lifestyle")
    {
        id = 10;
    }
    else if(name == "Media and Video")
    {
        id = 11;
    }
    else if(name == "Medical")
    {
        id = 12;
    }
    else if(name == "Music and Audio")
    {
        id = 13;
    }
    else if(name == "News and Magazines")
    {
        id = 14;
    }
    else if(name == "Personalization")
    {
        id = 15;
    }
    else if(name == "Photography")
    {
        id = 16;
    }
    else if(name == "Productivity")
    {
        id = 17;
    }
    else if(name == "Shopping")
    {
        id = 18;
    }
    else if(name == "Social")
    {
        id = 19;
    }
    else if(name == "Sports")
    {
        id = 20;
    }
    else if(name == "Tools")
    {
        id = 21;
    }
    else if(name == "Transportation")
    {
        id = 22;
    }
    else if(name == "Travel and Local")
    {
        id = 23;
    }
    else if(name == "Weather")
    {
        id = 24;
    }
    else if(name == "Libraries and Demo")
    {
        id = 25;
    }
    else if(name == "Arcade and Action")
    {
        id = 26;
    }
    else if(name == "Brain and Puzzle")
    {
        id = 27;
    }
    else if(name == "Cards and Casino")
    {
        id = 28;
    }
    else if(name == "Casual")
    {
        id = 29;
    }
    else if(name == "Racing")
    {
        id = 30;
    }
    else if(name == "Sports Games")
    {
        id = 31;
    }
    else 
    {
        id = 1000;
    }
    
    return id;
}