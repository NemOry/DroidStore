import bb.cascades 1.0
import org.labsquare 1.0
import bb.cascades.pickers 1.0
import bb.data 1.0

import "../sheets"
import "../components"
import "../js/globals.js" as Globals

Page 
{    
    property variant app;
    
    titleBar: DroidStoreTitleBar 
    {
        titleText: app.title
        page: "app"
        closeVisibility: false
        settingsVisibility: true
        searchVisibility: false
        logoVisibility: false
    }
    
    Container 
    {
        bottomPadding: 30
        
        ScrollView 
        {
            Container 
            {
                id: main
                bottomPadding: 10
                topPadding: 10
                leftPadding: 10
                rightPadding: 10
                
                Container 
                {
                    id: downloadingContainer
                    visible: false
                    
                    bottomPadding: 20
                    topPadding: 20
                    
                    layout: StackLayout
                    {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    
                    Container 
                    {
                        preferredWidth: 570
                        
                        ProgressIndicator
                        {
                            value: 90
                            toValue: 100
                        }
                        
                        Label 
                        {
                            id: downloadStatus
                            text: "Downloading"
                            textStyle.fontSize: FontSize.XSmall
                            textStyle.color: Color.DarkGray
                        }
                    }
                    
                    Container
                    {
                        leftPadding: 10
                        
                        layout: StackLayout
                        {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        
                        ImageButton 
                        {
                            preferredHeight: 70
                            preferredWidth: 70
                            defaultImageSource: "asset:///images/refresh.png"
                        }
                        
                        ImageButton 
                        {
                            preferredHeight: 70
                            preferredWidth: 70
                            defaultImageSource: "asset:///images/stop.png"
                        }
                    }
                }
                
                Container 
                {
                    id: top
                    
                    layout: StackLayout
                    {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    
                    WebImageView 
                    {
                        id:img
                        preferredHeight: 130
                        preferredWidth: 130
                        url: app.icon_72
                        imageSource: "asset:///icontest.png"
                    }
                    
                    Container 
                    {
                        layoutProperties: StackLayoutProperties 
                        {
                            spaceQuota: 5
                        }
                        
                        layout: StackLayout 
                        {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        
                        leftPadding: 10.0
                        
                        Container 
                        {
                            Label 
                            {
                                verticalAlignment: VerticalAlignment.Top
                                text: app.title
                                //text: "Instagram"
                            }
                        }
                        
                        Container 
                        {
                            topPadding: 5
                            
                            Label 
                            {
                                verticalAlignment: VerticalAlignment.Center
                                text: "by " + app.developer
                                //text: "By: Oliver Martinez"
                                textStyle.fontSize: FontSize.XSmall
                            }
                        }
                        
                        Container 
                        {
                            topPadding: 5
                            
                            layout: StackLayout 
                            {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            
                            StarRating 
                            {
                                topPadding: 5
                                rating: app.rating
                            }
                            
                            Label 
                            {
                                text: app.number_ratings + " Ratings"
                                textStyle.fontSize: FontSize.XSmall
                                visible: false
                            }
                        }
                    }
                    
                    Container 
                    {
                        verticalAlignment: VerticalAlignment.Center
                        
                        leftPadding: 20
                        rightPadding: 20
                        
                        CustomButton
                        {
                            id: downloadButton
                            text: (app.price_numeric > 0 ? + app.price_numeric : "Download")
                            enabled: (app.price_numeric == 0)
                            onClicked: 
                            {
                                if(app.platform == "android")
                                {
                                    enabled = false;
                                    //downloadingContainer.visible = true;
                                    
                                    var theObject 			= new Object();
                                    theObject.packageid 	= app.package_name;
                                    theObject.name 			= app.title;
                                    theObject.iconURL 		= app.icon_72;
                                    theObject.status 		= "Downloading";
                                    theObject.evozi_key 	= app.evozi_key;
                                    _droidStoreAPI.addDownload(theObject);
                                    
                                    _app.showToast("Download starting.");
                                    
                                    _app.flurryLogEvent("DOWNLOADING: " + app.title);
                                }
                                else if(app.platform == "blackberry") // blackberry app
                                {
                                    _app.invokeBBWorld(app.package_name);
                                    
                                    _app.flurryLogEvent("DOWNLOADING BB APP: " + app.title);
                                }
                            }
                        }
                        
                        Button
                        {
                            id: openButton
                            text: "Open"
                            visible: false
                            onClicked: 
                            {
                                
                            }
                        }
                    }
                }
                
                Label 
                {
                    visible: app.price_numeric > 0
                    text: app.paiderrorstring
                    textStyle.color: Color.Red
                    textStyle.fontSize: FontSize.XSmall
                }
                
                SegmentedControl 
                {
                    options: 
                    [
                        Option 
                        {
                            text: "Details"
                        },
                        Option 
                        {
                            text: "Reviews"
                        }
                    ]
                    
                    onSelectedIndexChanged: 
                    {
                        if(selectedIndex == 1)
                        {
                            _app.showToast("Coming Soon! :)");
                        }
                    }
                }

                Container 
                {
                    id: details
                    topMargin: 20

                    Divider {}
                    
                    Container 
                    {
                        id: screenshots
                        topMargin: 20
                        
                        ListView 
                        {
                            preferredHeight: 400
                            
                            layout: StackListLayout
                            {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            
                            dataModel: _droidStoreAPI.screenshotsDataModel
                            
                            onTriggered: 
                            {
                                var selectedItem = _droidStoreAPI.screenshotsDataModel.data(indexPath);
                            }
                            
                            listItemComponents: 
                            [
                                ListItemComponent 
                                {
                                    ScreenshotItem
                                    {
                                        id: root
                                    }
                                }
                            ]
                        }
                    }
                    
                    Divider {}
                    
                    Container 
                    {
                        id: downloadsContainer
                        
                        layout: StackLayout 
                        {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        
                        Label 
                        {
                            text: "Downloads:"
                            textStyle.color: Color.DarkGray
                            textStyle.fontSize: FontSize.Small
                        }
                        
                        Label 
                        {
                            text: app.downloads
                            textStyle.fontSize: FontSize.Small
                        }
                    }

                    Divider {}
                    
                    Label 
                    {
                        text: Globals.urlify(app.description)
                        multiline: true
                        textStyle.fontSize: FontSize.Small
                        textFormat: TextFormat.Html
                    }
                    
                    Divider {}
                    
                    Container 
                    {
                        id: versionContainer
                        
                        layout: StackLayout 
                        {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        
                        Label 
                        {
                            text: "Version:"
                            textStyle.color: Color.DarkGray
                            textStyle.fontSize: FontSize.Small
                        }
                        
                        Label 
                        {
                            text: app.version
                            textStyle.fontSize: FontSize.Small
                        }
                    }
                    
                    Container 
                    {
                        id: sizeContainer
                        
                        layout: StackLayout 
                        {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        
                        Label 
                        {
                            text: "Download Size:"
                            textStyle.color: Color.DarkGray
                            textStyle.fontSize: FontSize.Small
                        }
                        
                        Label 
                        {
                            text: bytesToSize(app.size)
                            textStyle.fontSize: FontSize.Small
                        }
                    }
                    
                    Container 
                    {
                        id: releaseDateContainer
                        
                        layout: StackLayout 
                        {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        
                        Label 
                        {
                            text: "Release Date:"
                            textStyle.color: Color.DarkGray
                            textStyle.fontSize: FontSize.Small
                        }
                        
                        Label 
                        {
                            text: app.market_update
                            textStyle.fontSize: FontSize.Small
                        }
                    }
                    
                    Container 
                    {
                        id: categoryContainer
                        
                        layout: StackLayout 
                        {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        
                        Label 
                        {
                            text: "Category:"
                            textStyle.color: Color.DarkGray
                            textStyle.fontSize: FontSize.Small
                        }
                        
                        Label 
                        {
                            text: app.category
                            textStyle.fontSize: FontSize.Small
                            textStyle.color: Color.create("#22B7E0")
                        }
                        
                        gestureHandlers: TapHandler 
                        {
                            onTapped:
                            {
                                var page 					= categorizedLoadedComponent.createObject();
                                var categoryObject			= new Object();
                                categoryObject.title		= app.category;
                                categoryObject.subcategory	= "top_apps_overall_weekly";
                                page.categoryObject 		= categoryObject;
                                page.initialize();
                                
                                navigationPane.push(page);
                            }
                            
                            attachedObjects: ComponentDefinition 
                            {
                                id: categorizedLoadedComponent
                                source: "asset:///pages/CategoriesLoadedPage.qml"
                            }
                        }
                    }

                    Container 
                    {
                        id: contentRatingContainer
                        
                        layout: StackLayout 
                        {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        
                        Label 
                        {
                            text: "Content Rating:"
                            textStyle.color: Color.DarkGray
                            textStyle.fontSize: FontSize.Small
                        }
                        
                        Label 
                        {
                            text: app.content_rating
                            textStyle.fontSize: FontSize.Small
                        }
                    }
                }
            }
        }
    }
    
    actions: 
    [
//        ActionItem 
//        {
//            title: "Review"
//            imageSource: "asset:///images/tabPencil.png"
//            ActionBar.placement: ActionBarPlacement.OnBar
//            onTriggered: 
//            {
//                _app.showToast("Coming Soon :)");
//            }
//        },
//        ActionItem 
//        {
//            title: "Share"
//            imageSource: "asset:///images/tabShare.png"
//            ActionBar.placement: ActionBarPlacement.OnBar
//            onTriggered:
//            {
//                _app.showToast("Coming Soon :)");
//            }
//        },
//        ActionItem 
//        {
//            title: "Add to Favorite"
//            imageSource: "asset:///images/tabStar.png"
//            ActionBar.placement: ActionBarPlacement.InOverflow
//            onTriggered: 
//            {
//                _app.showToast("Coming Soon :)");
//            }
//        },
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
    
    function bytesToSize(bytes) 
    {
        var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
        if (bytes == 0) return '0 Bytes';
        var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
        return Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
    }
}
