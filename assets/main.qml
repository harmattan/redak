import bb.cascades 1.0

NavigationPane {
    id: navigationPane
    Page {
        //-- page with a picture thumbnail
        Container {
            layout: StackLayout {
            }
            Container {
                //-- use expandable container above button to center button position verticaly
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1.0
                }
            }
            Button {
                text: qsTr ("Show detail")
                imageSource: "asset:///images/picture1thumb.png"
                layoutProperties: StackLayoutProperties {
                    horizontalAlignment: HorizontalAlignment.Center
                }
                onClicked: {
                    //-- show detail page when the button is clicked
                    navigationPane.deprecatedPushQmlByString("DetailPage.qml")
                }
            }
            Container {
                //-- use expandable container below button to center button position verticaly
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1.0
                }
            }
        }
    }
}
