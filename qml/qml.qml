import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    title: qsTr("Hello World i3float")
    id: mainWindow
    width: 320
    height: 640
    color: "#222222"

    Rectangle {
        z: 2
        id: menuPanel
        height: menuWrapper.height + 2 * 4
        anchors.top: parent.top
        width: parent.width
        anchors.left: parent.left
        anchors.topMargin: -menuPanel.height
        color: "#ceeb2f"
        state: "hiddenLeft"

        states: [
            State {
                name: "hiddenTop"
                PropertyChanges { target: menuPanel; anchors.topMargin: -menuPanel.height; }
                PropertyChanges { target: topPanel; anchors.topMargin: 0; }
                //PropertyChanges { target: topPanel; anchors.top: mainWindow.top }
            },
            State {
                name: "hiddenLeft"
                PropertyChanges { target: menuPanel; width: 200; height: parent.height - topPanel.height; anchors.topMargin: topPanel.height; anchors.leftMargin: -menuPanel.width }
            },
            State {
                name: "top"
                PropertyChanges { target: menuPanel; width: parent.width; anchors.topMargin: 0; anchors.leftMargin: 0 }
                PropertyChanges { target: topPanel; anchors.topMargin: menuPanel.height; }
                //PropertyChanges { target: topPanel; anchors.top: menuPanel.bottom }
            },
            State {
                name: "left"
                PropertyChanges { target: menuPanel; width: 200; anchors.leftMargin: 0; }
            }
        ]

        transitions: [
            Transition {
                from: "hiddenTop"; to: "top"
                NumberAnimation { properties: "anchors.topMargin"; duration: 300 }
                NumberAnimation { target: topPanel; properties: "anchors.topMargin"; duration: 300 }
            },
            Transition {
                from: "top"; to: "hiddenTop"
                NumberAnimation { properties: "anchors.topMargin"; duration: 300 }
                NumberAnimation { target: topPanel; properties: "anchors.topMargin"; duration: 300 }
            },
            Transition {
                from: "hiddenLeft"; to: "left"
                NumberAnimation { properties: "anchors.leftMargin"; duration: 300 }
            },
            Transition {
                from: "left"; to: "hiddenLeft"
                NumberAnimation { properties: "anchors.leftMargin"; duration: 300 }
            }
        ]

        Rectangle {
            id: menuWrapper
            anchors.fill: parent
            anchors.top: parent.top
            anchors.margins: 4
            height: 4 * 34
            color: "#ceeb2f"

            ListView {
                id: menuList
                width: parent.width
                anchors.fill: parent
                spacing: 4
                height: menuList.count * (30 + 4)

                model: ListModel {
                    ListElement {
                        ssid: "Wifi List"
                    }
                    ListElement {
                        ssid: "Signal Map"
                    }
                    ListElement {
                        ssid: "Compass"
                    }
                    ListElement {
                        ssid: "About"
                    }
                }

                delegate: Rectangle {
                    width: menuList.width
                    implicitHeight: 30
                    color: "#333"
                    Text {
                        text: ssid

                        anchors.fill: parent
                        anchors.margins: parent.height / 10 + 2
                        font.pixelSize: 50
                        fontSizeMode: Text.VerticalFit
                        color: "#deed8a"
                    }
                }
            }
        }
    }

    Rectangle {
        z: 2
        id: topPanel

        color: "#222222"

        anchors.top: parent.top
        width: parent.width
        height: Math.min(parent.height / 64 + 20, 30)

        Rectangle {
            id: menuButton
            color: "#ceeb2f"

            height: parent.height
            width: menuLabel.paintedWidth + menuLabel.anchors.margins * 2
            anchors.left: parent.left

            Text {
                id: menuLabel
                text: "Menu"

                color: "#111111"

                anchors.fill: parent
                anchors.margins: parent.height / 10 + 2
                font.pixelSize: 50
                fontSizeMode: Text.VerticalFit
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (menuPanel.state == "hiddenLeft")
                        menuPanel.state = "left"
                    else
                        menuPanel.state = "hiddenLeft"
                }
            }
//            Rectangle {
//                z: 1

//                height: parent.height * 2
//                width: parent.height

//                color: parent.parent.color
//                anchors.left: parent.right
//                anchors.top: parent.top

//                smooth: true
//                transformOrigin: Item.TopLeft
//                rotation: 30
//            }
        }

        Rectangle {
            color: "transparent"

            height: parent.height
            width: menuLabel.paintedWidth + menuLabel.anchors.margins * 2
            anchors.left: menuButton.right

            Text {
                id: pageLabel
                text: "/ Wifi List"

                color: "#deed8a"

                anchors.fill: parent
                anchors.margins: parent.height / 10 + 2
                font.pixelSize: 30
                fontSizeMode: Text.VerticalFit
            }
        }

        Rectangle {
            id: settingsButton
            color: "#ceeb2f"

            height: parent.height
            width: height
            anchors.right: closeButton.left
            anchors.rightMargin: 2

            Text {
                id: settingsLabel
                text: "S"

                color: "#111111"

                anchors.fill: parent
                anchors.margins: parent.height / 10 + 2
                horizontalAlignment: Text.Center
                font.pixelSize: 50
                fontSizeMode: Text.VerticalFit
            }
        }

        Rectangle {
            id: closeButton
            color: "#ceeb2f"

            height: parent.height
            width: height
            anchors.right: parent.right

            Text {
                id: closeLabel
                text: "X"

                color: "#111111"

                anchors.fill: parent
                anchors.margins: parent.height / 10 + 2
                horizontalAlignment: Text.Center
                font.pixelSize: 50
                fontSizeMode: Text.VerticalFit
            }

            /*Rectangle {
                z: -1

                height: parent.height * 2
                width: parent.height

                color: parent.color
                anchors.left: parent.left
                anchors.bottom: parent.bottom

                smooth: true
                transformOrigin: Item.BottomLeft
                rotation: -30
            }*/
        }
    }

    Rectangle {
        id: wifiListPage
        anchors.fill: parent
        anchors.margins: 10
        anchors.topMargin: topPanel.height + anchors.margins
        width: parent.width

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
                implicitHeight: mainWindow.height / 64 + 20
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
}
