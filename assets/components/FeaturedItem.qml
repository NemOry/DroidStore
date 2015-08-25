import bb.cascades 1.0
import org.labsquare 1.0

Container 
{
    id: featuredRestoItem

    layout: DockLayout {}
    
    leftPadding: 5

    preferredWidth: 604
    preferredHeight: 342
    
    maxWidth: preferredWidth
    maxHeight: preferredHeight
    
    ActivityIndicator 
    {
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        preferredHeight: 150
        preferredWidth: 150
        visible: (img.loading < 1.0)
        running: (img.loading < 1.0)
    }
    
    WebImageView 
    {
        id:img
        url: ListItemData.picture
        loadEffect: ImageViewLoadEffect.FadeZoom
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        scalingMethod: ScalingMethod.AspectFill
    }
    
    Container 
    {
        id: photoContainer
        layout: DockLayout {}
        
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Bottom
        
	    Container 
	    {
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Bottom

            Label 
            {
                id: restoName
                visible: false
                text: ListItemData.appname
		        textStyle.fontWeight: FontWeight.W100
		        textStyle.fontSize: FontSize.Large

		        minWidth:  {
                    return (featuredRestoItem.preferredWidth - (photoContainer * 2)) 
		        }
		    }
		}
    }
}
