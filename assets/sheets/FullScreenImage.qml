import bb.cascades 1.0
import org.labsquare 1.0

Sheet 
{
    id: sheet
    property string imageURL : "";
    
    Page 
    {
        titleBar: TitleBar 
        {
            title: "Application Icon"
            dismissAction: ActionItem 
            {
                title: "Close"
                imageSource: "asset:///images/close.png"
                onTriggered: 
                {
                    sheet.close();
                }
            }
        }
        
        Container 
        {
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            
            layout: DockLayout {
            
            }
            
            ActivityIndicator 
            {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                preferredWidth: 720
                preferredHeight: 720
                minHeight: 720
                minWidth: 720
                visible: (img.loading < 1.0)
                running: (img.loading < 1.0)
            }

            WebImageView 
            {
                id:img
                preferredWidth: 720
                preferredHeight: 720
                minHeight: 720
                minWidth: 720
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                scalingMethod: ScalingMethod.AspectFit
                url: imageURL.replace("=w340-rw", "=w720");
                visible: (img.loading == 1.0)
            }
        } 
    }
}