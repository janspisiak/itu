import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
    id: scanPage
    anchors.fill: parent
    anchors.margins: 10
    //anchors.topMargin: topPanel.height + anchors.margins
    width: parent.width
    height: parent.height

    color: "#333333"

    ListView {
        id: wifiList
        width: parent.width
        spacing: 2
        height: parent.height

        model: ListModel {
            ListElement {
                ssid: "Wifi1"
                checked: false
            }
            ListElement {
                ssid: "Wifi2"
                checked: false
            }
            ListElement {
                ssid: "Wifi3"
                checked: false
            }
            ListElement {
                ssid: "Wifi4"
                checked: false
            }
            ListElement {
                ssid: "Wifi5"
                checked: false
            }
            ListElement {
                ssid: "Wifi6"
                checked: false
            }
            ListElement {
                ssid: "Wifi7"
                checked: false
            }
            ListElement {
                ssid: "Wifi8"
                checked: false
            }
        }

        delegate: Rectangle {
            width: wifiList.width
            implicitHeight: parent.height / 64 + 20
            color: checked ? "#aefb21" : "#334422"

            Text {
                text: ssid

                anchors.fill: parent
                anchors.margins: parent.height / 10 + 2
                font.pixelSize: 50
                fontSizeMode: Text.VerticalFit
                color: checked ? "black" : "white"
            }

            CheckBox {
                id: checkBox
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 10
                checked: model.checked
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: {
                    var item = wifiList.model.get(index);
                    item.checked = !item.checked;
                }
            }
        }

        populate: Transition {
            NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.OutBounce }
        }
    }
}
