import bb.cascades 1.0
import org.labsquare 1.0

Container 
{
    preferredWidth: 160
    maxHeight: 210
    minHeight: maxHeight
    maxWidth: preferredWidth
    bottomPadding: 10
    topPadding: 10
    horizontalAlignment: HorizontalAlignment.Center
    //background: Color.Red
    
    WebImageView
    {
        id:img
        preferredWidth: 140
        minWidth: preferredWidth
        minHeight: preferredWidth
        scalingMethod: ScalingMethod.AspectFit
        url: ListItemData.icon_72
        //imageSource: "asset:///icontest.png"
    }
    
    Container 
    {
        Label 
        {
            verticalAlignment: VerticalAlignment.Top
            text: ListItemData.title
            //text: "Instagram Oh Yeah Yeah"
            textStyle.fontSize: FontSize.XXSmall
            textStyle.textAlign: TextAlign.Center
        }
    }
}