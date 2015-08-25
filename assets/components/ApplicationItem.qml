import bb.cascades 1.0
import org.labsquare 1.0

Container 
{
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
            url: ListItemData.icon_72
            //imageSource: "asset:///instagramicon.png"
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
                    text: ListItemData.title
                    //text: "Instagram"
                }
            }
            
            Container 
            {
                topPadding: 5
                
                Label 
                {
                    verticalAlignment: VerticalAlignment.Center
                    text: ListItemData.description
                    //text: "This is a short description for instagram application for blackberry 10"
                    textStyle.fontSize: FontSize.XSmall
                    textStyle.color: Color.DarkGray
                }
            }
            
            StarRating 
            {
                topPadding: 5
                rating: ListItemData.rating
            }
        }
        
        Container 
        {
            verticalAlignment: VerticalAlignment.Center
            
            leftPadding: 20
            rightPadding: 20
            
            Label 
            {
                text: (ListItemData.price_numeric == 0 ? "Free" : ListItemData.price_numeric)
                textStyle.fontSize: FontSize.Small
                textStyle.color: Color.DarkGray
            }
        }
    }
}