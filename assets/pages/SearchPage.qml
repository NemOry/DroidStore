import bb.cascades 1.0
import nemory.DroidStoreAPI 1.0

import "../components"
import bb.data 1.0

Page 
{
    property string lastQuery : "";
    
    onCreationCompleted: 
    {
        searchText.requestFocus();
    }
    
    Container 
    {
        topPadding: 30
        layout: DockLayout {}
        
        Container 
        {
            id: stackContainer
            
            Container 
            {
                leftPadding: 20
                rightPadding: 20
                
                layout: StackLayout 
                {
                    orientation: LayoutOrientation.LeftToRight
                }
                
                TextField 
                {
                    id: searchText
                    hintText: "Enter a Search Term"
                    onTextChanged:
                    {
                        search();
                    }
                    
                    keyListeners: 
                    [
                        KeyListener 
                        {
                            onKeyReleased: 
                            {  
                                if(event.key == 13)
                                {
                                   searchResultsContainer.requestFocus();
                                   search();
                                }
                            }        
                        }
                    ]
                    
                    layoutProperties: StackLayoutProperties 
                    {
                        spaceQuota: 6
                    }
                }
                
                Button 
                {
                    imageSource: "asset:///images/search.png"
                    
                    layoutProperties: StackLayoutProperties 
                    {
                        spaceQuota: 1
                    }
                    
                    onClicked: 
                    {
                        search();
                    }
                }
            }
            
            Container 
            {
                id: searchResultsContainer
                visible: false
                
                Header 
                {
                    title: "Search Results"
                }
                
                ListView 
                {
                    visible: !droidStoreAPI.loading
                    dataModel: _droidStoreAPI.resultsDataModel
                    
                    attachedObjects: 
                    [
                        ComponentDefinition 
                        {
                            id: detailedPageComponent
                            source: "asset:///pages/DetailedPage.qml"
                        }
                    ]
                    
                    onTriggered: 
                    {
                        var selectedItem 	= _droidStoreAPI.resultsDataModel.data(indexPath);
                        _droidStoreAPI.loadScreenshots(indexPath[0]);
                        
                        var page 			= detailedPageComponent.createObject();
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
                id: recentSearchesContainer
                visible: !searchResultsContainer.visible
                
                Header 
                {
                    title: "Recent Searches"
                }
                
                ListView 
                {
                    dataModel: arrayDataModel
                    
                    listItemComponents: 
                    [
                        ListItemComponent 
                        {
                            RecentSearchItem
                            {
                            	
                            }
                        }
                    ]
                    
                    function removeRecentSearch(searchText)
                    {
                    	_app.removeFromRecentSearches(searchText);
                    }
                    
                    attachedObjects:
                    [
                        DataSource 
                        {
                            id: dataSource
                            source: _app.dbPath();
                            query: "select * from RecentSearches"
                            
                            onDataLoaded: 
                            {
                                arrayDataModel.insert(0, data);
                            }
                        },
                        ArrayDataModel 
                        {
                            id: arrayDataModel
                        }
                    ]
                }
            }
        }
        
        Container 
        {
            id: loading
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
                searchText.requestFocus();
            }
        },
        ActionItem 
        {
            title: "Clear Recent Searches"
            ActionBar.placement: ActionBarPlacement.InOverflow
            imageSource: "asset:///images/tabDelete.png"
            onTriggered: 
            {
                _app.clearRecentSearches();
                
                _app.flurryLogEvent("CLEARED RECENT SEARCHES");
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
        DroidStoreAPI
        {
            id: droidStoreAPI
            
            onComplete: 
            {
                console.log("SEARCH JSON RESPONSE: " + response);
                _droidStoreAPI.parseResultsJSON(response, "all");
            }
        }
    ]
    
    function search()
    {
        if(!droidStoreAPI.loading && searchText.text.length > 0)
        {
            searchResultsContainer.visible = true;
            lastQuery 		= searchText.text;
            droidStoreAPI.search(searchText.text, 50);
            
            _app.addToRecentSearches(searchText.text);
            
            _app.flurryLogEvent("SEARCHED: " + searchText.text);
        }
    }
}