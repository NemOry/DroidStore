import bb.cascades 1.0
import org.labsquare 1.0

Container 
{
    leftPadding: 10
    
    WebImageView 
    {
        id:img
        preferredHeight: 400
        scalingMethod: ScalingMethod.AspectFit
        url: ListItemData.toString()
    }
}