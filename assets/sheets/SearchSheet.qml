import bb.cascades 1.0
import nemory.DroidStoreAPI 1.0
import bb.data 1.0

import "../components"

Sheet 
{
    property variant parameters;
    property string lastQuery : "";
    
    onOpened: 
    {
        titleBar.searchTextAlias.requestFocus();
        titleBar.searchTextAlias.resetText();
        
        _droidStoreAPI.resultsDataModel.clear();
        searchResultsContainer.visible = false;
        
        refreshRecentSearches();
    }
    
    function refreshRecentSearches()
    {
        arrayDataModel.clear();
        dataSource.load();
    }
    
    NavigationPane 
    {
        id: navigationPane
        
        Page 
        {
            titleBar: DroidStoreTitleBar 
            {
                id: titleBar
                page: "search"
                logoVisibility: false
                titleTextVisibility: false
                closeVisibility: true
                onCloseButtonClicked: 
                {
                    close();
                }
                onSearched: 
                {
                    search(searchedText);
                }
            }
            
            Container 
            {
                layout: DockLayout {}
                
                Label 
                {
                    visible: _droidStoreAPI.resultsDataModel.size() == 0 && searchResultsContainer.visible && !droidStoreAPI.loading
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    text: "No Results Found for " + lastQuery;
                }
                
                Container 
                {
                    id: stackContainer
                    
                    Container 
                    {
                        id: searchResultsContainer
                        visible: false
                        
                        Header 
                        {
                            title: "Search Results"
                            subtitle: _droidStoreAPI.resultsDataModel.size()
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
                                _droidStoreAPI.loadScreenshots(indexPath[0], _droidStoreAPI.results);
                                
                                var page 			= detailedPageComponent.createObject();
                                page.app		 	= selectedItem;
                                
                                navigationPane.push(page);
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
                                    	id: root
                                    }
                                }
                            ]
                            
                            onTriggered: 
                            {
                                var selectedItem 	= arrayDataModel.data(indexPath);
                                search(selectedItem.searchText);
                            }
                            
                            function removeRecentSearch(searchText)
                            {
                                _app.removeFromRecentSearches(searchText);
                                refreshRecentSearches();
                            }
                            
                            attachedObjects:
                            [
                                DataSource 
                                {
                                    id: dataSource
                                    source: "file://" + _app.dbPath();
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
                            
                            onCreationCompleted: 
                            {
                                refreshRecentSearches();
                            }
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
            
            attachedObjects: 
            [
                DroidStoreAPI
                {
                    id: droidStoreAPI
                    
                    onComplete: 
                    {
                        console.log("SEARCH JSON RESPONSE: " + response + ", CATEGORY: " + parameters.category);
                        _droidStoreAPI.parseResultsJSON(response, parameters.category);
                    }
                }
            ]
            
            actions: 
            [
                ActionItem 
                {
                    title: "Search"
                    ActionBar.placement: ActionBarPlacement.OnBar
                    imageSource: "asset:///images/tabSearch.png"
                    onTriggered: 
                    {
                        titleBar.searchTextAlias.requestFocus();
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
                        refreshRecentSearches();
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
        }
    }
    
    function search(searchedText)
    {
        console.log("CATEGORY: " + parameters.category);
        
        if(!droidStoreAPI.loading && searchedText.length > 0)
        {
            searchResultsContainer.visible = true;
            lastQuery 		= searchedText;
            droidStoreAPI.search(searchedText, 50);
            
            _app.addToRecentSearches(searchedText);
            refreshRecentSearches();
            
            _app.flurryLogEvent("SEARCHED: " + searchedText);
        }
    }
}