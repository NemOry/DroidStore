import bb.cascades 1.0

Container 
{
    property variant rating: 0
    property string numRatings: ''
    property string off: 'asset:///images/starBlank.png'
    property string half: 'asset:///images/starHalf.png'
    property string on: 'asset:///images/starFull.png'
    
    layout: StackLayout 
    {
        orientation: LayoutOrientation.LeftToRight
    }

    ImageView 
    {
        id: s1
        imageSource: star(1)
    }
    ImageView 
    {
        id: s2
        imageSource: star(2)
    }
    ImageView 
    {
        id: s3
        imageSource: star(3)
    }
    ImageView 
    {
        id: s4
        imageSource: star(4)
    }
    ImageView 
    {
        id: s5
        imageSource: star(5)
    }
    
    Label 
    {
        visible: numRatings.length > 0
        text: numRatings + ''
        leftMargin: 10
        textStyle 
        {
            base: SystemDefaults.TextStyles.SmallText
            color: Color.create('#cccccc')
        }
    }
    
    function star(level)
    {
        if(rating > level ) return on;
        if(rating >= level - 0.5) return half
        return off;
    }
}
