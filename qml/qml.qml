import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import io.thp.pyotherside 1.3

ApplicationWindow {
    title: qsTr("Wi-Fi locator")
    id: mainWindow
    width: 720
    height: 860
    color: "black"
    property bool menu_shown: false
    /* this rectangle contains the "menu" */

    Rectangle {
        id: menuView
        anchors.fill: parent
        border.color: "black"
        border.width: 2
        radius: 10
        //color: "#303030";

        gradient: Gradient {
            GradientStop { position: 0.0
            color: "#11A6D4"
            }
            GradientStop { position: 1
            color: "#04A6BF"
            }
        }
        Image {
            id: logo
            rotation: 25;
            width: 200;
            height:200;
            x: 10
            source: "wifi-logo.png"
            smooth: true
        }
        opacity: mainWindow.menu_shown ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 300 } }
        /* this is my sample menu content (TODO: replace with your own) */
        ListView {
            anchors { fill: parent; margins: 5;  topMargin: parent.height/3; }
            model: ListModel {
                ListElement {
                    label: "Choose Wi-Fi"
                    source: "ScanPage"
                }
                ListElement {
                    label: "Choose Map"
                    source: "MapPage"
                }
                ListElement {
                    label: "Map"
                    source: "MapPage"
                }
                ListElement {
                    label: "Tutorial"
                    source: "MapPage"
                }
                ListElement {
                    label: "About"
                    source: "MapPage"
                }

            }
            spacing: 0

            delegate: Rectangle {
                height: 40;
                width: parent.width - 44;
               // color: "#009900"
                gradient: Gradient {
                    GradientStop { position: 0.0
                    color: "white"
                    }
                    GradientStop { position: 0.05
                    color: "#747c82"
                    }
                    GradientStop { position: 1
                    color: "#233a47"
                    }
                }
                border.color: "black"
                border.width: 1
                //border.top: 0
               // radius: 1
                Text {
                    anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
                    color: "white";
                    font.pixelSize: 20;
                    text: label;
                    font.bold: true;

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
        color: "#11A6D4"
        /* this is what moves the normal view aside */

        transform: Translate {
            id: normalViewTranslate
            x: 0
            Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutQuad } }
        }

        /* quick and dirty menu "button" for this demo (TODO: replace with your own) */
        Rectangle {
            id: topPanel

            color:parent.color
            width: parent.width
            height: Math.min(parent.height / 64 + 25, 40)
             x: 15

//            id: menu_bar_
            anchors.top: parent.top
            Rectangle {
                id: menu_button_
                Image {
                    id: menuLabel
                    width: 40;
                    height:40;
                   // x: 15

                    source: "arrow.png"
                    smooth: true
                }
                anchors {left: parent.left; verticalCenter: parent.verticalCenter; margins: 2 }
                color: parent.color; implicitWidth: menuLabel.width; height: parent.height ; smooth: true
                scale: ma_.pressed ? 1.2 : 1
               // border.color: "black"
               // border.width: 2


               // Text { id: menuLabel; anchors.centerIn: parent; anchors.margins: 10; font.pixelSize: 48; fontSizeMode: Text.VerticalFit; text: "" }
                MouseArea { id: ma_; anchors.fill: parent; onClicked: mainWindow.onMenu(); }
            }
        }

        //Put the name of the QML files containing your pages (without the '.qml')
        property variant pagesList  : [
            "ScanPage",
            "MapPage"
        ];

        // Set this property to another file name to change page
        property string  currentPage : "ScanPage";

        Repeater {
            model: normalView.pagesList;
            delegate: Loader {
                active: false;
                asynchronous: true;
                anchors.top: topPanel.bottom
                anchors { top: topPanel.bottom; bottom: parent.bottom; left: parent.left; right: parent.right; }
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
        Rectangle {
            anchors.fill: parent
            opacity: mainWindow.menu_shown ? 0.4 : 0
            Behavior on opacity { NumberAnimation { duration: 300 } }
            color: "#000"
        }

    }
    /* this functions toggles the menu and starts the animation */
    function onMenu()
    {
        normalViewTranslate.x = mainWindow.menu_shown ? 0 : mainWindow.width * 0.3
        mainWindow.menu_shown = !mainWindow.menu_shown;
    }
}
