import bb.cascades 1.0
import bb.multimedia 1.0
import bb.cascades.pickers 1.0
import nemory.Downloader 1.0

import "../components"
import nemory.DroidStoreAPI 1.0

Sheet 
{
    id: sheet
    
    Page 
    {
        titleBar: DroidStoreTitleBar 
        {
            page: "downloads"
            titleText: "Downloads"
            closeVisibility: true
            logoVisibility: false
            onCloseButtonClicked: 
            {
                close();
            }
        }
        
        Container 
        {
            topPadding: 20
            leftPadding: 20
            rightPadding: 20
            bottomPadding: 40
            
            layout: DockLayout {}
            
            Label 
            {
                visible: _droidStoreAPI.downloadsDataModel.size() == 0
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                text: "No Downloads."
            }

            ListView 
            {
                horizontalAlignment: HorizontalAlignment.Center
                dataModel: _droidStoreAPI.downloadsDataModel

                listItemComponents: 
                [
                    ListItemComponent 
                    {
                        DownloadItem
                        {
                        	id: root
                        }
                    }
                ]
                
                function setStatus(package_name, value)
                {
                    for (var i = 0; i < _droidStoreAPI.downloadsDataModel.size(); i++)
                    {
                        var indexPath = new Array();
                        indexPath[0] = i;
                        
                        var listItem = _droidStoreAPI.downloadsDataModel.data(indexPath);
                        
                        if(listItem.id == package_name)
                        {
                            listItem.status = value;
                            _droidStoreAPI.downloadsDataModel.replace(indexPath, listItem);
                        }
                    }
                }
                
                function openWithInstaller(packageid)
                {
                    var apkLocation = _app.getSetting("saveLocation", "/accounts/1000/shared/downloads/") + packageid + ".apk";
                    _app.invokeInstaller("file://" + apkLocation);
                    
                    _app.flurryLogEvent("INSTALLING");
                }
            }
        }
    }
}