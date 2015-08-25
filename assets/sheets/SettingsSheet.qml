import bb.cascades 1.0
import bb.multimedia 1.0
import bb.cascades.pickers 1.0

import "../components"

Sheet 
{
    id: sheet
    peekEnabled: false
    property bool firstRun : true;
    property bool firstRunTheme : true;

    Page 
    {
        titleBar: DroidStoreTitleBar 
        {
            page: "settings"
            titleText: "Settings"
            closeVisibility: true
            logoVisibility: false
            onCloseButtonClicked: 
            {
                close();
            }
        }
        
        ScrollView 
        {
            Container 
            {
                topPadding: 20
                leftPadding: 20
                rightPadding: 20
                bottomPadding: 40
                
                DropDown 
                {
                    id: theme
                    title: "Application Color Theme"
                    selectedIndex: (_app.getSetting("colortheme", "bright") == "bright" ? 0 : 1);
                    options: 
                    [
                        Option
                        {
                            text: "Bright"
                            imageSource: "asset:///images/bright.png"
                        },
                        Option
                        {
                            text: "Dark"
                            imageSource: "asset:///images/dark.png"
                        }
                    ]
                    
                    onSelectedValueChanged: 
                    {
                        if(!firstRunTheme)
                        {
                            _app.setSetting("colortheme", selectedOption.text.toLowerCase());
                            _app.showDialog("Attention", "Changing Color Theme requires an App Restart.")
                        }
                        
                        firstRunTheme = false; 
                    }
                }

                Label 
                {
                    text: "Downloaded APKs Location"
                }
                
                Container
                {
                    layout: StackLayout 
                    {
                        orientation: LayoutOrientation.LeftToRight 
                    }
                    
                    TextField 
                    {
                        id: saveLocation
                        enabled: false
                        hintText: "Downloaded APKs Location"
                        text: _app.getSetting("saveLocation", "/accounts/1000/shared/downloads/")
                        layoutProperties: StackLayoutProperties 
                        {
                            spaceQuota: 5
                        }
                    }
                    
                    Button 
                    {
                        horizontalAlignment: HorizontalAlignment.Fill
                        imageSource: "asset:///images/folder.png"
                        layoutProperties: StackLayoutProperties 
                        {
                            spaceQuota: 1
                        }
                        onClicked: 
                        {
                            filePicker.open();
                        }
                        attachedObjects: FilePicker 
                        {
                            id: filePicker
                            type: FileType.Other
                            mode: FilePickerMode.SaverMultiple
                            title : "Save Location"
                            onFileSelected :
                            {
                                var folder = selectedFiles[0] + "/";
                                _app.setSetting("saveLocation", folder);
                                saveLocation.text = folder;
                            }
                        }
                    }
                }
            } 
        }
    }
}