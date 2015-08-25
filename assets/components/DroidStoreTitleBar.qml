import bb.cascades 1.0
import bb.system 1.0

import "../js/globals.js" as Globals

TitleBar 
{
    property string page
    property string titleText
    property bool titleTextVisibility : true;
    property bool logoVisibility : true;
    property bool closeVisibility
    property bool searchVisibility
    property bool settingsVisibility
    property bool downloadsVisibility
    property alias searchTextAlias : searchText
    
    signal closeButtonClicked();
    signal searched(string searchedText);

	appearance: TitleBarAppearance.Plain
	scrollBehavior: TitleBarScrollBehavior.Sticky
	kind: TitleBarKind.FreeForm
	
	kindProperties: FreeFormTitleBarKindProperties 
	{
	    content: 
		Container 
		{
		    id: titleBackground
            background: Color.create(_app.getSetting("colortheme", "bright") == "bright" ? Globals.defaultTitleBarColorBright : Globals.defaultTitleBarColorDark)
            //background: Color.create(Globals.defaultTitleBarColorBright);
		    layout: DockLayout {}
		    
            horizontalAlignment: HorizontalAlignment.Fill
		    preferredHeight: 124

			Container 
			{
			    layout: DockLayout {}
		
		        horizontalAlignment: HorizontalAlignment.Fill
		        verticalAlignment: VerticalAlignment.Fill
		        
		        leftPadding: 20
		        rightPadding: leftPadding
		        
		        Container 
		        {
                    visible: logoVisibility
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    
                    ImageView 
                    {
                        visible: logoVisibility
                        verticalAlignment: VerticalAlignment.Center
                        imageSource: "asset:///images/titleIcon.png"
                    }
                }
		        
		        Container 
		        {
                    visible: titleTextVisibility
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Left
                    
              		layout: StackLayout 
              		{
                    	orientation: LayoutOrientation.LeftToRight
                    }
              		
//                    ImageView 
//                    {
//                        visible: logoVisibility
//                        verticalAlignment: VerticalAlignment.Center
//                        preferredHeight: 50
//                        preferredWidth: 50
//                        imageSource: "asset:///images/titleIcon.png"
//                    }
                    
                    Label 
                    {
                        visible: titleTextVisibility
                        text: titleText
                        textStyle.color: Color.White
                        textStyle.fontSize: (page == "game" || page == "app" ? FontSize.Default : FontSize.Large)
                        textStyle.fontWeight: FontWeight.W100
                    }
              	}
		        
		        Container 
		        {
		            layout: DockLayout {}
                    visible: (page == "search")
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Left

                    TextField 
                    {
                        id: searchText
                        preferredWidth: 620
                        textStyle.color: Color.White
                        backgroundVisible: false
                        hintText: "Enter a Search Term"
                        
                        onTextChanged:
                        {
                            searched(searchText.text);
                        }
                        
                        keyListeners: 
                        [
                            KeyListener 
                            {
                                onKeyReleased: 
                                {  
                                    if(event.key == 13)
                                    {
                                        closeButton.requestFocus();
                                        searched(searchText.text);
                                    }
                                }        
                            }
                        ]
                    }
                    
                    Container 
                    {
                        topPadding: 60
                        leftPadding: 10
                        touchPropagationMode: TouchPropagationMode.None
                        verticalAlignment: VerticalAlignment.Center
                        
                        ImageView 
                        {
                            imageSource: "asset:///images/searchLineBar.png"
                        }
                    }
              	}

                ImageButton 
                {
                    id: closeButton
					visible: closeVisibility
					horizontalAlignment: HorizontalAlignment.Right   
					verticalAlignment: VerticalAlignment.Center
					preferredHeight: 70
					preferredWidth: 70
					defaultImageSource: "asset:///images/titleClose.png"
					onClicked: 
					{
						closeButtonClicked();
					}
                }
		        
		        Container 
		        {
                    visible: (searchVisibility || settingsVisibility || downloadsVisibility)
                    horizontalAlignment: HorizontalAlignment.Right   
                    verticalAlignment: VerticalAlignment.Center
                    
              		layout: StackLayout 
              		{
                    	orientation: LayoutOrientation.LeftToRight
                    }
              		
              		Container 
              		{
              		    visible: searchVisibility
              		    
              		      rightPadding: 30
              		    
	                      ImageButton 
	                      {
	                          preferredHeight: 70
	                          preferredWidth: 70
	                          defaultImageSource: "asset:///images/titleSearch.png"
	                          onClicked: 
	                          {
	                              var parameters = new Object();
	                              parameters.category = page;
	                              _app.openSearch(parameters);
	                          }
	                      }
                    }
              		
                    Container 
                    {
                        visible: downloadsVisibility
                        
                        rightPadding: 30
                        
                        ImageButton 
                        {
                            preferredHeight: 70
                            preferredWidth: 70
                            defaultImageSource: "asset:///images/ic_to_bottom.png"
                            onClicked: 
                            {
                                _app.openDownloads();
                            }
                        }
                    }

                    ImageButton 
                    {
                        visible: settingsVisibility
                        
                        preferredHeight: 70
                        preferredWidth: 70
                        defaultImageSource: "asset:///images/titleMenu.png"
                        onClicked: 
                        {
                            _app.openSettings();
                        }
                    }
              	}
		    }
		}
	}
}