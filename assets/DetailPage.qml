import bb.cascades 1.0

Page {
    //-- page with a picture detail
    id: pgDetail
    actions: [
        //-- create navigation panel actions here
        ActionItem {
            title: qsTr("Break")
            onTriggered: {
                imgView2.imageSource = "asset:///images/picture1br.png";
            }
        }
    ]
    Container {
        layout: StackLayout {
        }
        Label {
            layoutProperties: StackLayoutProperties {
                horizontalAlignment: HorizontalAlignment.Center
            }
            text: qsTr("Page 2")
            textStyle {
                base: SystemDefaults.TextStyles.TitleText
            }
        }
        ImageView {
            id: imgView2
            imageSource: "asset:///images/picture1.png"
            scalingMethod: ScalingMethod.AspectFit
            layoutProperties: StackLayoutProperties {
                horizontalAlignment: HorizontalAlignment.Center
            }
        }
        Label {
            layoutProperties: StackLayoutProperties {
                horizontalAlignment: HorizontalAlignment.Center
                //-- set space quota to make label fill all free place on the parent container
                spaceQuota: 1.0
            }
            text: qsTr("Picture description")
        }
    }
}
