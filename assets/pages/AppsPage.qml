import bb.cascades 1.0
import nemory.DroidStoreAPI 1.0

import "../components"
import "../sheets"

import "../js/globals.js" as Globals

NavigationPane 
{
    id: navigationPane
    property string lastQuery : "";
    property string lastCategoryName : "";
    
    Page 
    {
        titleBar: DroidStoreTitleBar 
        {
            titleText: "Applications"
            page: "app"
            logoVisibility: true
            closeVisibility: false
            settingsVisibility: true
            searchVisibility: false
        }
        
        ScrollView 
        {
            id: mainScrollView
            
            Container 
            {
                id: mainContainer
                //topPadding: 10
                //bottomPadding: 10
                //leftPadding: 10
                //rightPadding: 10
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                layout: DockLayout { }
                
                Container 
                {
                    id: stackContainer
                    visible: !loadingBox.visible
                    
//                    Carousel 
//                    {
//                        bottomPadding: 10
//                        verticalAlignment: VerticalAlignment.Center
//                        autoScrollEnabled: true
//                        autoScrollInterval: 5000
//                        
//                        list: 
//                        [ 
//	                        "asset:///images/1.jpg", 
//	                        "asset:///images/2.jpg", 
//	                        "asset:///images/3.jpg", 
//	                        "asset:///images/4.jpg",
//	                        "asset:///images/5.jpg" 
//                        ]
//                        
//                        onCreationCompleted: 
//                        {
//                            setIndex(0)
//                        }
//                    }
                    
                    Container 
                    {
                        id: popularContainer
                        visible: !droidStoreAPIPopular.loading
                        
                        Container 
                        {
                            bottomPadding: 20
                            
                            Header 
                            {
                                title: "Popular Apps"
                                visible: _droidStoreAPI.popularAppsDataModel.size() > 0
                            }
                        }
                        
                        Container 
                        {
                            horizontalAlignment: HorizontalAlignment.Center
                            leftPadding: 20
                            layout: DockLayout {}
                            
                            ListView 
                            {
                                horizontalAlignment: HorizontalAlignment.Center
                                dataModel: _droidStoreAPI.popularAppsDataModel
                                preferredHeight: 450
                                
                                layout: GridListLayout 
                                {
                                    columnCount: 4
                                    verticalCellSpacing: 50
                                }
                                
                                onTriggered: 
                                {
                                    var selectedItem = _droidStoreAPI.popularAppsDataModel.data(indexPath);
                                    _droidStoreAPI.loadScreenshots(indexPath[0], _droidStoreAPI.popularApps);
                                    var page 			= appPageComponent.createObject();
                                    page.app		 	= selectedItem;
                                    
                                    navigationPane.push(page);
                                    
                                    _app.flurryLogEvent("OPENED APP: " + selectedItem.title);
                                }
                                
                                listItemComponents: 
                                [
                                    ListItemComponent 
                                    {
                                        ApplicationGridItem
                                        {
                                        
                                        }
                                    }
                                ]
                            }
                            
                            ImageButton 
                            {
                                defaultImageSource: "asset:///images/expand.png"
                                horizontalAlignment: HorizontalAlignment.Right
                                verticalAlignment: VerticalAlignment.Bottom
                                onClicked: 
                                {
                                    var categoryObject 			= new Object();
                                    categoryObject.title 		= "All Applications";
                                    categoryObject.subcategory 	= "top_apps_overall_weekly";
                                    
                                    var page 			= categorizedLoadedComponent.createObject();
                                    page.categoryObject = categoryObject;
                                    page.initialize();
                                    
                                    navigationPane.push(page);
                                }
                            }
                        }
                    }
                    
                    Container 
                    {
                        id: trendingContainer
                        visible: !droidStoreAPITrending.loading
                        
                        Container 
                        {
                            bottomPadding: 20
                            
                            Header 
                            {
                                title: "Trending Apps"
                                visible: _droidStoreAPI.trendingAppsDataModel.size() > 0
                            }
                        }
                        
                        Container 
                        {
                            horizontalAlignment: HorizontalAlignment.Center
                            leftPadding: 20
                            
                            layout: DockLayout {}
                            
                            ListView 
                            {
                                horizontalAlignment: HorizontalAlignment.Center
                                dataModel: _droidStoreAPI.trendingAppsDataModel
                                preferredHeight: 450
                                
                                layout: GridListLayout 
                                {
                                    columnCount: 4
                                    verticalCellSpacing: 50
                                }
                                
                                onTriggered: 
                                {
                                    var selectedItem 	= _droidStoreAPI.trendingAppsDataModel.data(indexPath);
                                    _droidStoreAPI.loadScreenshots(indexPath[0], _droidStoreAPI.trendingApps);
                                    var page 			= appPageComponent.createObject();
                                    page.app		 	= selectedItem;
                                    
                                    navigationPane.push(page);
                                }
                                
                                listItemComponents: 
                                [
                                    ListItemComponent 
                                    {
                                        ApplicationGridItem
                                        {
                                        
                                        }
                                    }
                                ]
                            }
                            
                            ImageButton 
                            {
                                defaultImageSource: "asset:///images/expand.png"
                                horizontalAlignment: HorizontalAlignment.Right
                                verticalAlignment: VerticalAlignment.Bottom
                                onClicked: 
                                {
                                    var categoryObject 			= new Object();
                                    categoryObject.title 		= "All Applications";
                                    categoryObject.subcategory 	= "top_apps_trending_daily";
                                    
                                    var page 			= categorizedLoadedComponent.createObject();
                                    page.categoryObject = categoryObject;
                                    page.initialize();
                                    
                                    navigationPane.push(page);
                                }
                            }
                        }
                    }
                }
                
                Container 
                {
                    id: loadingBox
                    visible: (droidStoreAPIPopular.loading || droidStoreAPITrending.loading)
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    
                    ActivityIndicator 
                    {
                        running: loadingBox.visible
                        preferredHeight: 200
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                }
            }
        }
        
        actions:
        [
            ActionItem
            {
                title: "Search"
                imageSource: "asset:///images/tabSearch.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: 
                {
                    var parameters = new Object();
                    parameters.category = "app";
                    _app.openSearch(parameters);
                }
            },
            ActionItem
            {
                title: "Categories"
                imageSource: "asset:///images/tabFolder.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: 
                {
                    var page = categoriesPageComponent.createObject();
                    var categoryObject 			= new Object();
                    categoryObject.source 		= "asset:///offlinedata/appcategories.xml";
                    page.categoryObject 		= categoryObject;
                    navigationPane.push(page);
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
    
    attachedObjects: 
    [
        DroidStoreAPI
        {
            id: droidStoreAPIPopular
            
            onComplete: 
            {
                console.log("POPULAR APPS: " + response)
                _droidStoreAPI.parsePopularJSON(response, "app");
            }
        },
        DroidStoreAPI
        {
            id: droidStoreAPITrending
            
            onComplete: 
            {
                console.log("TRENDING APPS: " + response)
                _droidStoreAPI.parseTrendingJSON(response, "app");
            }
        },
        ComponentDefinition 
        {
            id: categoriesPageComponent
            source: "asset:///pages/CategoriesPage.qml"
        },
        ComponentDefinition 
        {
            id: appPageComponent
            source: "asset:///pages/DetailedPage.qml"
        },
        ComponentDefinition 
        {
            id: categorizedLoadedComponent
            source: "asset:///pages/CategoriesLoadedPage.qml"
        }
    ]
    
    onCreationCompleted: 
    {
        loadPopular();
        loadTrending();
    }
    
    function loadPopular()
    {
        if(!droidStoreAPIPopular.loading)
        {
            droidStoreAPIPopular.loadTopApps("top_apps_overall_weekly", "worldwide", "en", Globals.categoryNameToID("All Applications"));
        }
    }
    
    function loadTrending()
    {
        if(!droidStoreAPITrending.loading)
        {
            droidStoreAPITrending.loadTopApps("top_apps_trending_daily", "worldwide", "en", Globals.categoryNameToID("All Applications"));
        }
    }
}