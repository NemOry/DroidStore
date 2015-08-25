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
            titleText: Globals.applicationName
            page: "all"
            closeVisibility: false
            settingsVisibility: true
            searchVisibility: true
        }
        
        ScrollView 
        {
            id: mainScrollView
        
            Container 
            {
                id: mainContainer
                bottomPadding: 10
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                layout: DockLayout { }
                
                Container 
                {
                    id: stackContainer
                    visible: !loadingBox.visible
                    
                    Carousel 
                    {
                        bottomPadding: 10
//                        maxHeight: 600
//                        minHeight: 600
                        verticalAlignment: VerticalAlignment.Center

                        autoScrollEnabled: true
                        autoScrollInterval: 5000
                        
                        list: 
                        [ 
                            "asset:///images/1.jpg", 
	                        "asset:///images/2.jpg", 
	                        "asset:///images/3.jpg", 
                            "asset:///images/4.jpg",
                            "asset:///images/5.jpg" 
                        ]
                        
                        onCreationCompleted: 
                        {
                            setIndex(0)
                        }
                    }
                    
                    Container 
                    {
                        id: popularContainer
                        visible: !droidStoreAPIPopular.loading
                        
                        Header 
                        {
                            title: "Popular Apps & Games"
                            visible: _droidStoreAPI.popularAllDataModel.size() > 0
                        }
                        
                        Container 
                        {
                            horizontalAlignment: HorizontalAlignment.Center
                            leftPadding: 20
                            topPadding: 20
                            rightPadding: leftPadding
                            
                            layout: DockLayout {}
                            
                            ListView 
                            {
                                horizontalAlignment: HorizontalAlignment.Center
                                dataModel: _droidStoreAPI.popularAllDataModel
                                preferredHeight: 450
                                
                                layout: GridListLayout 
                                {
                                    columnCount: 4
                                    verticalCellSpacing: 50
                                }
                                
                                onTriggered: 
                                {
                                    var selectedItem = _droidStoreAPI.popularAllDataModel.data(indexPath);
                                    _droidStoreAPI.loadScreenshots(indexPath[0], _droidStoreAPI.popularAll);
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
                        
                        Header 
                        {
                            title: "Trending Apps & Games"
                            visible: _droidStoreAPI.trendingAllDataModel.size() > 0
                        }
                        
                        Container 
                        {
                            horizontalAlignment: HorizontalAlignment.Center
                            leftPadding: 20
                            topPadding: 20
                            rightPadding: leftPadding
                            
                            layout: DockLayout {}
                            
                            ListView 
                            {
                                horizontalAlignment: HorizontalAlignment.Center
                                dataModel: _droidStoreAPI.trendingAllDataModel
                                preferredHeight: 450
                                
                                layout: GridListLayout 
                                {
                                    columnCount: 4
                                    verticalCellSpacing: 50
                                }
                                
                                onTriggered: 
                                {
                                    var selectedItem 	= _droidStoreAPI.trendingAllDataModel.data(indexPath);
                                    _droidStoreAPI.loadScreenshots(indexPath[0], _droidStoreAPI.trendingAll);
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
                ActionBar.placement: ActionBarPlacement.InOverflow
                onTriggered: 
                {
                    var parameters = new Object();
                    parameters.category = "all";
                    _app.openSearch(parameters);
                }
            },
            ActionItem
            {
                title: "Categories"
                imageSource: "asset:///images/tabFolder.png"
                ActionBar.placement: ActionBarPlacement.InOverflow
                onTriggered: 
                {
                    var page = categoriesPageComponent.createObject();
                    navigationPane.push(page);
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
                console.log("POPULAR: " + response)
                _droidStoreAPI.parsePopularJSON(response, "all");
            }
        },
        DroidStoreAPI
        {
            id: droidStoreAPITrending
            
            onComplete: 
            {
                console.log("TRENDING: " + response)
            	_droidStoreAPI.parseTrendingJSON(response, "all");
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