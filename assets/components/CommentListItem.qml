import bb.cascades 1.0

Container 
{
    horizontalAlignment: HorizontalAlignment.Fill
    
    Label 
    {
        horizontalAlignment: HorizontalAlignment.Fill
        text: ListItemData.review
        multiline: true 
        textStyle.fontSize: FontSize.Small
        textStyle.fontStyle: FontStyle.Italic
        textStyle.fontWeight: FontWeight.W300
    }
    
    Label 
    {
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Right
        text: ListItemData.datetime
        multiline: true 
        textStyle.fontSize: FontSize.XXSmall
        textStyle.fontWeight: FontWeight.W100
    }
    
    Divider {
        
    }
}