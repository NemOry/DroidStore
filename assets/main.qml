import bb.cascades 1.0
import bb.system 1.0
import bb.cascades.pickers 1.0
import bb.data 1.0

import "sheets"
import "pages"

import "js/globals.js" as Globals

TabbedPane 
{
    id: tabbedPane
    showTabsOnActionBar: false

//    Tab 
//    {
//        id: allTab
//        title: "All"
//        imageSource: "asset:///images/tabGrid.png"
//        
//        AllPage
//        {
//            id: allPage
//        }
//    }

	onActiveTabChanged: 
	{
        _app.flurryLogEvent("OPENED " + activeTab.title + " TAB");
    }

    Tab 
    {
        id: appsTab
        title: "Apps"
        imageSource: "asset:///images/tabGrid4.png"
        
        AppsPage
        {
            id: appsPage
        }
    }
    
    Tab 
    {
        id: gamesTab
        title: "Games"
        imageSource: "asset:///images/tabGames.png"
        
        GamesPage
        {
            id: gamesPage
        }
    }
    
    //    Tab 
    //    {
    //        id: allTab
    //        title: "All"
    //        imageSource: "asset:///images/tabGrid.png"
    //        
    //        AllPage
    //        {
    //            id: allPage
    //        }
    //    }
    
//    Tab
//    {
//        id: topAppsTab
//        title: "Top Apps"
//        imageSource: "asset:///images/tabTopApps.png"
//        
//        TopAppsPage
//        {
//            id: topAppsPage
//        }
//    }
    
//    Tab 
//    {
//        id: favoritesTab
//        title: "Favorites"
//        imageSource: "asset:///images/tabStar.png"
//        
//        FavoritesPage
//        {
//            id: favoritesPage
//        }
//    }

    Menu.definition: MenuDefinition 
    {
        actions: 
        [
//            ActionItem 
//            {
//                title: "About"
//                imageSource: "asset:///images/tabInfo.png"
//                onTriggered:
//                {
//                    aboutSheet.open();
//                }
//            },
            ActionItem 
            {
                title: "Downloads (" + _droidStoreAPI.downloadsDataModel.size() + ")"
                imageSource: "asset:///images/tabDownload.png"
                onTriggered: 
                {
                    downloadsSheet.open();
                    
                    _app.flurryLogEvent("OPENED DOWNLOADS");
                }
            },
//            ActionItem  
//            {
//                title: "Contact Us"
//                imageSource: "asset:///images/tabEmail.png"
//                onTriggered: 
//                {
//                    _app.invokeEmail("support@cheerstore.com", "Support : " + Globals.applicationName + " ", "")
//                }
//            },
            ActionItem 
            {
                title: "Settings"
                imageSource: "asset:///images/tabSettings.png"
                onTriggered:
                {
                    settingsSheet.open();
                    
                    _app.flurryLogEvent("OPENED SETTINGS");
                }
            }
        ]
    }
	
    attachedObjects: 
    [
        Invocation 
        {
            id: invokeShare
            query 
            {
                mimeType: "text/plain"
                invokeActionId: "bb.action.SHARE"
                invokerIncluded: true
                data: Globals.shareText
            }
        },
        AboutSheet 
        {
            id: aboutSheet
        },
        SettingsSheet 
        {
            id: settingsSheet
        },
        SearchSheet 
        {
            id: searchSheet
        },
        DownloadsSheet 
        {
            id: downloadsSheet
        }
    ]
    
    onCreationCompleted: 
    {
        _app.openSearchSignal.connect(openSearch);
        _app.openSettingsSignal.connect(openSettings);
        _app.openDownloadsSignal.connect(openDownloads);
        
        _app.flurryLogEvent("STARTED APPLICATION");
    }
    
    function openSearch(parameters)
    {
        searchSheet.parameters = parameters;
        searchSheet.open();
        
        _app.flurryLogEvent("OPENED SEARCH");
    }
    
    function openSettings()
    {
        settingsSheet.open();
        
        _app.flurryLogEvent("OPENED SETTINGS");
    }
    
    function openDownloads()
    {
        downloadsSheet.open();
        
        _app.flurryLogEvent("OPENED DOWNLOADS");
    }
}
