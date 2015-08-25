import bb.cascades 1.0

Container {
    id: greenButton
    signal clicked()
    property alias text: label.text;
    //    property ColorPaint textColor: Color.White
    minWidth: 140    
    minHeight: 90
    attachedObjects: [
        TextStyleDefinition {
            id: labelStyle
            color: Color.White
            fontSize: FontSize.PointValue
            //textAlign: TextAlign.Center
            fontSizeValue: 7
        },
        TextStyleDefinition {
            id: disabledLabelStyle
            color: Color.Gray
            fontSize: FontSize.PointValue
            fontSizeValue: 7
        }
    ]

    //visible: text.length > 0
    layout: DockLayout {
    }
    onEnabledChanged: {
        if (enabled) {
            label.textStyle.base = labelStyle.style
        } else {
            pressed.visible = false
            label.textStyle.base = disabledLabelStyle.style
        }
    }
    ImageView {
        id: disabled
        imageSource: "asset:///images/ButtonGreenDisabled.amd"
        visible: ! greenButton.enabled
        scalingMethod: ScalingMethod.Fill
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
    }
    ImageView {
        id: nonPressed
        imageSource: "asset:///images/ButtonGreenEnabled.amd"
        visible: greenButton.enabled
        scalingMethod: ScalingMethod.Fill
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
    }
    ImageView {
        id: pressed
        imageSource: "asset:///images/ButtonGreenEnabledPress.amd"
        visible: false
        scalingMethod: ScalingMethod.Fill
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
    }

    Label {
    horizontalAlignment: HorizontalAlignment.Center
    verticalAlignment: VerticalAlignment.Center
        id: label
        textStyle.base: labelStyle.style
        attachedObjects: [
            LayoutUpdateHandler {
                onLayoutFrameChanged: {
                    greenButton.preferredWidth = layoutFrame.width + 60
                }
            }
        ]
    }
       
    onTouch: {
        if (greenButton.enabled) {
            if (event.isDown()) {
                pressed.visible = true;
            } else if (event.isUp() || event.isCancel()) {
                if (pressed.visible) {
                    pressed.visible = false;
                    clicked();
                }
            }
        }
    }
}
