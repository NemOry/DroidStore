import bb.cascades 1.0
import bb.multimedia 1.0
import bb.cascades.pickers 1.0

import "../js/globals.js" as Globals
import "../components"

Sheet 
{
    id: sheet
    peekEnabled: false
    property bool firstRun : true;
    property bool firstRunTheme : true;
    
    onOpened: 
    {
        _app.flurryLogEvent("OPENED ABOUT");
    }
    
    Page 
    {
        titleBar: DroidStoreTitleBar 
        {
            page: "about"
            titleText: "About - " + Globals.applicationName
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
                
                Label 
                {
                    text: "Cheer Store About Page"
                }
            } 
        }
    }
}