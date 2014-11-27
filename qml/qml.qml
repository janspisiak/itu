import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import io.thp.pyotherside 1.3

ApplicationWindow {
    title: qsTr("Hello World i3float")
    id: mainWindow
    width: 460
    height: 640
    color: "black"
    property bool menu_shown: false
    /* this rectangle contains the "menu" */
    Rectangle {
        id: menuView
        anchors.fill: parent
        color: "#303030";
        opacity: mainWindow.menu_shown ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 300 } }
        /* this is my sample menu content (TODO: replace with your own) */
        ListView {
            anchors { fill: parent; margins: 22 }
            model: ListModel {
                ListElement {
                    label: "Scan"
                    source: "ScanPage"
                }
                ListElement {
                    label: "Map"
                    source: "MapPage"
                }
            }
            spacing: 2
            delegate: Rectangle {
                height: 40;
                width: parent.width - 44;
                color: "#AAA"

                Text {
                    anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
                    color: "white";
                    font.pixelSize: 25;
                    text: label
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Loading " + source);
                        normalView.currentPage = source
                        mainWindow.onMenu();
                    }
                }
            }
        }
    }
    /* this rectangle contains the "normal" view in your app */
    Rectangle {
        id: normalView
        anchors.fill: parent
        color: "#333"
        /* this is what moves the normal view aside */
        transform: Translate {
            id: normalViewTranslate
            x: 0
            Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutQuad } }
        }

        /* quick and dirty menu "button" for this demo (TODO: replace with your own) */
        Rectangle {
            id: topPanel

            color: "#222222"
            width: parent.width
            height: Math.min(parent.height / 64 + 25, 40)

//            id: menu_bar_
            anchors.top: parent.top
            Rectangle {
                id: menu_button_
                anchors {left: parent.left; verticalCenter: parent.verticalCenter; margins: 2 }
                color: "white"; implicitWidth: menuLabel.width; height: parent.height - 2; smooth: true
                scale: ma_.pressed ? 1.2 : 1
                Text { id: menuLabel; anchors.centerIn: parent; anchors.margins: 10; font.pixelSize: 48; fontSizeMode: Text.VerticalFit; text: "Menu" }
                MouseArea { id: ma_; anchors.fill: parent; onClicked: mainWindow.onMenu(); }
            }
        }

        //Put the name of the QML files containing your pages (without the '.qml')
        property variant pagesList  : [
            "ScanPage",
            "MapPage"
        ];

        // Set this property to another file name to change page
        property string  currentPage : "MapPage";

        Repeater {
            model: normalView.pagesList;
            delegate: Loader {
                active: false;
                asynchronous: true;
                anchors.top: topPanel.bottom
                anchors { top: topPanel.bottom; bottom: parent.bottom; left: parent.left; right: parent.right; margins: 10 }
                visible: (normalView.currentPage === modelData);
                source: "%1.qml".arg(modelData)
                onVisibleChanged:      { loadIfNotLoaded(); }
                Component.onCompleted: { loadIfNotLoaded(); }

                function loadIfNotLoaded () {
                    // to load the file at first show
                    if (visible && !active) {
                        active = true;
                    }
                }
            }
        }
        /* put this last to "steal" touch on the normal window when menu is shown */
        MouseArea {
            anchors.fill: parent
            enabled: mainWindow.menu_shown
            onClicked: mainWindow.onMenu();
        }

    }
    /* this functions toggles the menu and starts the animation */
    function onMenu()
    {
        normalViewTranslate.x = mainWindow.menu_shown ? 0 : mainWindow.width * 0.9
        mainWindow.menu_shown = !mainWindow.menu_shown;
    }
}


//ApplicationWindow {
//    title: qsTr("Hello World i3float")
//    id: mainWindow
//    width: 320
//    height: 640
//    color: "#222222"

//    property bool menuOpen: false

//    function onMenu()
//    {
//        console.log("onMenu()");
//        game_translate_.x = mainWindow.menuOpen ? 0 : mainWindow.width * 0.9
//        mainWindow.menuOpen = !mainWindow.menuOpen;
//    }

//    Rectangle {
//        //z: 10
//        id: menuPanel
//        //height: menuWrapper.height + 2 * 4
//        anchors.fill: parent
//        //width: parent.width
//        //anchors.left: parent.left
//        //anchors.topMargin: -menuPanel.height
//        color: "#ceeb2f"
//        opacity: mainWindow.menuOpen ? 1 : 0
//        //state: "hiddenLeft"

//        Behavior on opacity { NumberAnimation { duration: 300 } }

//        Rectangle {
//            id: menuWrapper
//            anchors.fill: parent
//            anchors.top: parent.top
//            anchors.margins: 4
//            height: 4 * 34
//            color: "#ceeb2f"

//            ListView {
//                id: menuList
//                width: parent.width
//                anchors.fill: parent
//                spacing: 4
//                height: menuList.count * (30 + 4)

//                model: ListModel {
//                    ListElement {
//                        ssid: "Wifi List"
//                    }
//                    ListElement {
//                        ssid: "Signal Map"
//                    }
//                    ListElement {
//                        ssid: "Compass"
//                    }
//                    ListElement {
//                        ssid: "About"
//                    }
//                }

//                delegate: Rectangle {
//                    width: menuList.width
//                    implicitHeight: 30
//                    color: "#333"
//                    Text {
//                        text: ssid

//                        anchors.fill: parent
//                        anchors.margins: parent.height / 10 + 2
//                        font.pixelSize: 50
//                        fontSizeMode: Text.VerticalFit
//                        color: "#deed8a"
//                    }
//                }
//            }
//        }
//    }

//    Rectangle {
//        id: pageWrapper
//        anchors.fill: parent
//        color: "white"

//        // this is what moves the normal view aside
//        transform: Translate {
//            id: game_translate_
//            x: 0
//            Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutQuad } }
//        }


//        Rectangle {
//            //z: 2
//            id: topPanel

//            color: "#222222"

//            anchors.top: parent.top
//            width: parent.width
//            height: Math.min(parent.height / 64 + 20, 30)

//            Rectangle {
//                id: menuButton
//                color: "#ceeb2f"

//                height: parent.height
//                width: menuLabel.paintedWidth + menuLabel.anchors.margins * 2
//                anchors.left: parent.left

//                Text {
//                    id: menuLabel
//                    text: "Menu"

//                    color: "#111111"

//                    anchors.fill: parent
//                    anchors.margins: parent.height / 10 + 2
//                    font.pixelSize: 50
//                    fontSizeMode: Text.VerticalFit
//                }

//                MouseArea {
//                    anchors.fill: parent
//                    /*onClicked: {
//                    if (menuPanel.state == "hiddenLeft")
//                        menuPanel.state = "left"
//                    else
//                        menuPanel.state = "hiddenLeft"
//                }*/
//                    onClicked: function() {
//                        console.log("test");
//                    }
//                }

//                /*Rectangle {
//                    z: 1

//                    height: parent.height * 2
//                    width: parent.height

//                    color: parent.parent.color
//                    anchors.left: parent.right
//                    anchors.top: parent.top

//                    smooth: true
//                    transformOrigin: Item.TopLeft
//                    rotation: 30
//                }*/
//            }

//            Rectangle {
//                color: "transparent"

//                height: parent.height
//                width: menuLabel.paintedWidth + menuLabel.anchors.margins * 2
//                anchors.left: menuButton.right

//                Text {
//                    id: pageLabel
//                    text: "/ Wifi List"

//                    color: "#deed8a"

//                    anchors.fill: parent
//                    anchors.margins: parent.height / 10 + 2
//                    font.pixelSize: 30
//                    fontSizeMode: Text.VerticalFit
//                }
//            }

//            Rectangle {
//                id: settingsButton
//                color: "#ceeb2f"

//                height: parent.height
//                width: height
//                anchors.right: closeButton.left
//                anchors.rightMargin: 2

//                Text {
//                    id: settingsLabel
//                    text: "S"

//                    color: "#111111"

//                    anchors.fill: parent
//                    anchors.margins: parent.height / 10 + 2
//                    horizontalAlignment: Text.Center
//                    font.pixelSize: 50
//                    fontSizeMode: Text.VerticalFit
//                }
//            }

//            Rectangle {
//                id: closeButton
//                color: "#ceeb2f"

//                height: parent.height
//                width: height
//                anchors.right: parent.right

//                Text {
//                    id: closeLabel
//                    text: "X"

//                    color: "#111111"

//                    anchors.fill: parent
//                    anchors.margins: parent.height / 10 + 2
//                    horizontalAlignment: Text.Center
//                    font.pixelSize: 50
//                    fontSizeMode: Text.VerticalFit
//                }

//                /*Rectangle {
//                z: -1

//                height: parent.height * 2
//                width: parent.height

//                color: parent.color
//                anchors.left: parent.left
//                anchors.bottom: parent.bottom

//                smooth: true
//                transformOrigin: Item.BottomLeft
//                rotation: -30
//            }*/
//            }
//        }

//        // Put the name of the QML files containing your pages (without the '.qml')
//        property variant pagesList  : [
//            "ScanPage"
//        ];

//        // Set this property to another file name to change page
//        property string  currentPage : "ScanPage";

//        Repeater {
//            model: pageWrapper.pagesList;
//            delegate: Loader {
//                active: false;
//                asynchronous: true;
//                anchors.fill: parent;
//                visible: (pageWrapper.currentPage === modelData);
//                source: "%1.qml".arg(modelData)
//                onVisibleChanged:      { loadIfNotLoaded(); }
//                Component.onCompleted: { loadIfNotLoaded(); }

//                function loadIfNotLoaded () {
//                    // to load the file at first show
//                    if (visible && !active) {
//                        active = true;
//                    }
//                }
//            }
//        }

//        MouseArea {
//            anchors.fill: parent
//            enabled: mainWindow.menuOpen
//            onClicked: mainWindow.onMenu();
//        }
//    }
//}
