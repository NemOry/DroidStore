import bb.cascades 1.0

import "../components"
import "../sheets"

Page 
{
    property variant categoryObject;
    
    //"asset:///offlinedata/categories.xml"
    
    titleBar: DroidStoreTitleBar 
    {
        page: "categories"
        titleText: "Categories"
        closeVisibility: false
        settingsVisibility: false
        searchVisibility: false
        logoVisibility: false
    }
    
    Container 
    {
        ListView 
        {
            id: listView
            dataModel: XmlDataModel 
            {
                id: xmlDataModel
                source: categoryObject.source
            }

            onTriggered: 
            {
                var selectedItem 	= dataModel.data(indexPath);
                selectedItem.subcategory = "top_apps_overall_weekly";
                
                var page 			= categorizedLoadedComponent.createObject();
                page.categoryObject = selectedItem;
                page.initialize();
                
                navigationPane.push(page);
                
                _app.flurryLogEvent("OPENED CATEGORY: " + selectedItem.title);
            }
            
            listItemComponents: 
            [
                ListItemComponent 
                {
                    StandardListItem
                    {
                        id: root
                    }
                }
            ]
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
                parameters.category = "all";
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
            id: categorizedLoadedComponent
            source: "asset:///pages/CategoriesLoadedPage.qml"
        }
    ]
}
