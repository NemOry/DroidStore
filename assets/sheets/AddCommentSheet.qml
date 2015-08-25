import bb.cascades 1.0

Sheet 
{
    id: sheet
    peekEnabled: false
    
    onClosed: 
    {
        loading.visible = false;
        post.enabled = true;
    }
    
    property string packageid : "";
    
    Page 
    {
        titleBar: TitleBar 
        {
            title: "Add Comment"
            dismissAction: ActionItem 
            {
                title: "Cancel"
                imageSource: "asset:///images/close.png"
                onTriggered: 
                {
                    sheet.close();
                }
            }
            acceptAction: ActionItem 
            {
                title: "Post"
                imageSource: "asset:///images/tabSend.png"
                onTriggered: 
                {
                    post.enabled = false;
                    postComment();
                }
            }
        }
        
        ScrollView 
        {
            Container 
            {
                topPadding: 40
                leftPadding: 20
                rightPadding: 20
                bottomPadding: 20
                
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                
                Container 
                {
                    id: loading
                    visible: false
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    
                    ActivityIndicator 
                    {
                        running: true
                        preferredHeight: 200
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                    
                    Label 
                    {
                        text: "Posting your comment..."
                        textStyle.fontStyle: FontStyle.Italic
                    }
                }
                
                Container 
                {
                    visible: !loading.visible
                        
                    Label 
                    {
                        text: "Your Comment"
                    }
                    
                    TextArea 
                    {
                        id: comment
                        preferredHeight: 400
                    }
                }
            }
        }
        
        actions:
        [
            ActionItem 
            {
                id: post
                ActionBar.placement: ActionBarPlacement.OnBar
                title: "Post Comment"
                imageSource: "asset:///images/tabSend.png"
                onTriggered: 
                {
                    enabled = false;
                    postComment();
                }
            }
        ]
    }
    
    function postComment() 
    {
        loading.visible = true;
        
        var request = new XMLHttpRequest();
        
        request.onreadystatechange=function() 
        {
            if(request.readyState === XMLHttpRequest.DONE) 
            {
                if (request.status === 200) 
                {
                    console.log(request.responseText);

                    if(request.responseText == "success")
                    {
                        _app.showToast("Your comment was posted.")
                        sheet.close();
                    }
                }
                else 
                {
                    loading.visible = false;
                    post.enabled = true;
                    _app.showDialog("Error", "Unable to post your comment. The server may be down or your connection is not stable.")
                }
            }
        }
        
        request.open("POST", host + addcommentURL, true);
        request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        request.send("review=" + comment.text + "&itemtype=" + packageid);
    }
}