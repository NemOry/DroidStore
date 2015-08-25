import bb.cascades 1.0
import nemory.DroidStoreAPI 1.0

import "../components"
import "../sheets"
import "../js/globals.js" as Globals

Page 
{
    property variant categoryObject;
    
    function initialize()
    {
        
        console.log("CATEGORY: " + categoryObject.title + ", ID: " + Globals.categoryNameToID(categoryObject.title));
        droidStoreAPI.loadTopApps(categoryObject.subcategory, "worldwide", "en", Globals.categoryNameToID(categoryObject.title));
    }

    titleBar: DroidStoreTitleBar 
    {
        page: "categoriesloaded"
        titleText: "Category: " + categoryObject.title
        closeVisibility: false
        settingsVisibility: false
        searchVisibility: false
        logoVisibility: false
    }
    
    Container 
    {
        topPadding: 10
        bottomPadding: 10
        leftPadding: 10
        rightPadding: 10
        
        layout: DockLayout {}
        
        Container 
        {
            id: stackContainer
            
            Header 
            {
                title: "Results"
                visible: _droidStoreAPI.topAppsDataModel.size() > 0
                subtitle: _droidStoreAPI.topAppsDataModel.size()
            }
            
            ListView 
            {
                id: listView
                visible: !droidStoreAPI.loading
                dataModel: _droidStoreAPI.topAppsDataModel
                
                attachedObjects: 
                [
                    ComponentDefinition 
                    {
                        id: pageDefinition
                        source: "asset:///pages/DetailedPage.qml"
                    }
                ]
                
                onTriggered: 
                {
                    var selectedItem = _droidStoreAPI.topAppsDataModel.data(indexPath);
                    _droidStoreAPI.loadScreenshots(indexPath[0], _droidStoreAPI.topApps);
                    var page 			= appPageComponent.createObject();
                    page.app		 	= selectedItem;
                    navigationPane.push(page);
                    
                    _app.flurryLogEvent("OPENED APP: " + selectedItem.title);
                }
                
                listItemComponents: 
                [
                    ListItemComponent 
                    {
                        ApplicationItem
                        {
                        
                        }
                    }
                ]
            }
        }

        Container 
        {
            id: loadingBox
            visible: droidStoreAPI.loading
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            
            ActivityIndicator 
            {
                running: droidStoreAPI.loading
                preferredHeight: 200
                horizontalAlignment: HorizontalAlignment.Center
            }
        }
    }
    
    actions: 
    [
        ActionItem 
        {
            title: "Search"
            ActionBar.placement: ActionBarPlacement.OnBar
            imageSource: "asset:///images/tabSearch.png"
            onTriggered: 
            {
                var parameters = new Object();
                parameters.category = Globals.categoryNameToID(categoryObject.title);
                searchSheet.parameters = parameters;
                searchSheet.open();
            }
        },
        ActionItem 
        {
            title: "Downloads (" + _droidStoreAPI.downloadsDataModel.size() + ")"
            imageSource: "asset:///images/tabDownload.png"
            ActionBar.placement: ActionBarPlacement.InOverflow
            onTriggered: 
            {
                _app.openDownloads();
            }
        }
    ]
    
    attachedObjects: 
    [
        SearchSheet
        {
            id: searchSheet
        },
        ComponentDefinition 
        {
            id: appPageComponent
            source: "asset:///pages/DetailedPage.qml"
        },
        DroidStoreAPI
        {
            id: droidStoreAPI
            onComplete: 
            {
                console.log("RESPONSE: " + response);
                _droidStoreAPI.parseTopAppsJSON(response);
            }
        }
    ]
}
