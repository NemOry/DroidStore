import bb.cascades 1.0
import org.labsquare 1.0

Container 
{
    verticalAlignment: VerticalAlignment.Center
    horizontalAlignment: HorizontalAlignment.Fill
    leftPadding: 20
    rightPadding: leftPadding
    topPadding: 20
    
    Container 
    {
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Fill
        layout: DockLayout {}
        
        Label 
        {
            text: ListItemData.searchText
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Center
        }
        
        ImageButton 
        {
            preferredHeight: 50
            preferredWidth: preferredHeight
            defaultImageSource: "asset:///images/recentSearchesClear.png"
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Center
            onClicked: 
            {
                root.ListItem.view.removeRecentSearch(ListItemData.searchText);
            }
        }    
    }
    
    Divider { }
}