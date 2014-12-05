import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2


Rectangle {

    //border.color: "white"
    //border.width: 1
    //radius: 5

    gradient: Gradient {
        GradientStop {
            position: 0.15
            color: "#09556D"
        }
        GradientStop {
            position: 1.05
            color: "#06061B" //"#04A6BF"
        }
    }

    Text {
        x: parent.width*0.4
        y:parent.height*0.005
        text: "Wi-fi locator";
        font.pointSize: 19
        font.bold : true
        color: "white"
    }
    Text {
        x: parent.width*0.3
        y:parent.height*0.05
        text: "How to use this application\n";
        font.pointSize: 16
        font.bold : true
        color: "white"
    }

    Text {
         x:parent.width*0.2
         y:parent.height*0.1

        text:
        "Application searches for all Wi-Fi Access points around.\n"+
        "You can:\n"+
        " -choose specific Wi-Fi you want to show on map.\n"+
        " -get details about every Wi-Fi around.\n"+
        " -access menu clicking on icon in left top corner.\n"+
        " -choose one map, and point up your location.\n"+
        " -add new maps:\n"+
        "  create a folder(name of folder will be location) and file in format:\n"+
        "  mapX.png, X is integer number, represends floor n. in building (can be negative).\n\n"+


        "Sequence of operations can be followed:\n"+
        "  -from Wi-Fi list pick one or more (will be on the map)\n"+
        "  -choose map from map list\n"+
        "  -click on map for place where you are, make step and repeat this process.\n"+
        "According to this instructions you will see calculated location of Wi-Fi APs.";
        font.pointSize: 10
        color: "white"
    }
    Text {
        x:parent.width*0.45
        y:parent.height*0.45
        text: "About";
        font.pointSize: 16
        font.bold : true
        color: "white"
    }
    Text {
        x: parent.width*0.2
        y:parent.height*0.5


        text:"Autors:           Ladislav Sulak & Jan Spisiak, FIT VUTBR - 3BIT\n"+
             "Contact:         xsulak04@stud.fit.vutbr.cz or xspisi03@stud.fit.vutbr.cz\n"+
             "Technology:   QML5, Python3, Pyotherside\n"+
             "Year:              Implemented in 11/2014";

        font.pointSize: 10
        color: "white"
    }
}
