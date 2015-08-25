import bb.cascades 1.0
import org.labsquare 1.0
import nemory.DroidStoreAPI 1.0
import nemory.Downloader 1.0

Container 
{
    onCreationCompleted: 
    {
        console.log("DOWNLOADING: " + ListItemData.packageid + ", EVOZI_KEY: " + ListItemData.evozi_key);
        droidStoreAPI.getDownloadURL(ListItemData.packageid, ListItemData.evozi_key);
    }
    
    verticalAlignment: VerticalAlignment.Center
    horizontalAlignment: HorizontalAlignment.Fill
    bottomPadding: 10
    topPadding: 10
    
    layout: DockLayout {}
    
    Container 
    {
        layout: StackLayout
        {
            orientation: LayoutOrientation.LeftToRight
        }
        
        WebImageView 
        {
            id:img
            preferredHeight: 130
            preferredWidth: 130
            url: ListItemData.iconURL
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
                    text: ListItemData.name
                    //text: "Instagram"
                }
            }
            
            Container 
            {
                topPadding: 20
                
                ProgressIndicator 
                {
                    id: progressBar
                	fromValue: 0
                    value: downloader.progressValue
                    toValue: downloader.progressTotal
                }
            }
            
            Container 
            {
                topPadding: 10
                
                Label 
                {
                    id: statusMessage
                    visible: false
                    text: downloader.progressMessage + " - " + bytesToSize(downloader.progressTotal)
                    textStyle.color: Color.DarkGray
                    textStyle.fontSize: FontSize.XSmall
                }
                
                Label 
                {
                    id: otherStatusMessage
                    text: "Downloading..."
                    textStyle.color: Color.DarkGray
                    textStyle.fontSize: FontSize.XSmall
                }
            }
        }
        
        Container
        {
            visible: false
            verticalAlignment: VerticalAlignment.Center
            
            leftPadding: 30
            
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
        
        CustomButton
        {
            id: openButton
            visible: false
            leftPadding: 20
            text: "Install"
            horizontalAlignment: HorizontalAlignment.Right
            onClicked: 
            {
                root.ListItem.view.openWithInstaller(ListItemData.packageid);
            }
        }
    }
    
    Divider {}
    
    attachedObjects: 
    [
        DroidStoreAPI
        {
            id: droidStoreAPI
            onComplete: 
            {
                console.log("FETCHED: " + response);
                var responseJSON = JSON.parse(response);
                downloader.download(responseJSON.url, ListItemData.packageid);
                otherStatusMessage.visible = false;
                statusMessage.visible = true;
            }
        },
        Downloader
        {
            id: downloader
            onDownloadDone: 
            {
            	statusMessage.text = "Completed";
                progressBar.visible = false;
                openButton.visible = true;
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