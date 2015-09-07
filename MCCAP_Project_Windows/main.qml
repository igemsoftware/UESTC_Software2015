import QtQuick 2.2
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtMultimedia 5.4
import QtWebKit 3.0
import QtQuick.Dialogs 1.2
ApplicationWindow {
    id: zy000
    objectName: "rootMCCAP"
    title: qsTr("MCCAP")
    visible: true
    width: 1000
    height: 600
    minimumWidth: 950
    minimumHeight: 570
    maximumWidth: 1050
    maximumHeight: 630
    property int pagenum: 0
    property int vanishflag: 0
    
    /** custom slot, contact with C++ **/
    function on_response_cluster(jsonStr, count) {
        list1.clear();
        list2.clear();
        list3.clear();
        list4.clear();
        var objArr = JSON.parse(jsonStr);
        for(var i = 0;i < count;i++) {
            switch(objArr[i].category) {
            case 1:
                list1.append({"name" : objArr[i].accessNum, "description" : objArr[i].description});
                break;
            case 2:
                list2.append({"name" : objArr[i].accessNum, "description" : objArr[i].description});
                break;
            case 3:
                list3.append({"name" : objArr[i].accessNum, "description" : objArr[i].description});
                break;
            case 4:
                list4.append({"name" : objArr[i].accessNum, "description" : objArr[i].description});
                break;
            }
        }
    }

    /** custom slot, contact with C++ **/
    function on_response_web_load(url) {
        webview.url = url;
    }

    /** custom slot, contact with C++ **/
    function on_response_compare(jsonStr, count, jsonStatics) {
        c1_result.clear();
        c2_result.clear();
        c3_result.clear();
        var objArr = JSON.parse(jsonStr);
        var statics = JSON.parse(jsonStatics);
        for(var i = 0;i < count;i++) {
            switch(objArr[i].group) {
            case 1:
                c1_result.append({"name": objArr[i].accessNum, "type": objArr[i].category, "description": objArr[i].description});
            case 2:
                c2_result.append({"name": objArr[i].accessNum, "type": objArr[i].category, "description": objArr[i].description});
            case 3:
                c3_result.append({"name": objArr[i].accessNum, "type": objArr[i].category, "description": objArr[i].description});
            }
        }
    }

    //buttons flow
    MouseArea {
        id: dragRegion
        anchors.fill: parent
        onEntered: {
            fudong.start()
        }
    }

    //MainPage
    Item {
        id: mainpage
        visible: true
        anchors.fill:parent

        //background picture        //背景图
        Image {
            anchors.fill: parent
            opacity: 0.95
            source: "qrc:/images/mainpage_background.png"
        }

        //MCCAP
        Image {
            id: mccap
            source: "qrc:/images/mccap1.gif"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height*0.1
            anchors.leftMargin: parent.width*0.618
            MouseArea {
                anchors.fill: parent
                anchors.margins: 26
                hoverEnabled: true
                onEntered: {
                    mccap.source = "qrc:/images/mccap2.gif"
                    touchmccap.start()
                }
                onExited: {
                    mccap.source = "qrc:/images/mccap1.gif"
                    leavemccap.start()
                    jianxiepaopao2.start()
                }
            }
        }

        //Animation of entering MCCAP  //碰触MCCAP效果
        SequentialAnimation{
            id: touchmccap
            RotationAnimation {
                target:	mccap
                property: "scale"
                to:	0.98
                duration: 150
            }
        }

        //Animation of leaving MCCAP   //离开MCCAP效果
        SequentialAnimation{
            id: leavemccap
            RotationAnimation {
                target:	mccap
                property: "scale"
                to:	1.0
                duration: 150
            }
        }

        //Bottom left link "UESTC software team"
        Rectangle {
            width: parent.width
            height: 25
            color: "transparent"
            opacity: 0.7
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            Text {
                id: uestc
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: parent.top
                anchors.topMargin: 0
                text: "UESTC Software Team"
                font.pixelSize: 16
                font.bold: true
                font.family: "Segoe Script"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        uestc.font.bold = true
                        uestc.font.pixelSize = 17
                        uestc.anchors.leftMargin = 22
                        uestc.anchors.topMargin = -2
                        jianxiepaopao1.start()
                    }
                    onExited: {
                        uestc.font.bold = false
                        uestc.font.pixelSize = 16
                        uestc.anchors.leftMargin = 25
                        uestc.anchors.topMargin = 0
                    }
                    onClicked: {
                        //link to our wiki page
                        Qt.openUrlExternally("http://2015.igem.org/Team:UESTC_Software")
                    }
                }
            }
        }

        //Button1---start
        Button {
            property real y4: 0
            id: go2p1
            width:  parent.width*0.23//200
            height: parent.width*0.23//200
            opacity: 1.0
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.1
            anchors.top: parent.top
            anchors.topMargin: parent.height/3 + y4

            style: ButtonStyle {
                background: BorderImage {
                    source: control.hovered ? "qrc:/images/sjq2.png" : "qrc:/images/sjq1.png"
                    Text {
                        id: b1text
                        anchors.centerIn: parent
                        text: "Start "
                        color: "#444444"
                        font.family: "Segoe Script"
                        font.bold: true
                        font.pixelSize: control.hovered ? 31 : 25
                    }
                }
            }
            onClicked: {
                page_1.visible = true
                page_1_ani.start()
                mainpage_close.start()
            }
            Timer{
                id:mainpage_close
                interval: 250
                onTriggered: {
                    mainpage.visible=false
                }
            }
        }

        //Button2---help
        Button {
            property real y5: 0
            id: go2p2
            width: parent.width*0.19//165
            height: parent.width*0.19//165
            opacity: 1.0
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.31
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.21 + y5
            style: ButtonStyle {
                background: BorderImage {
                    source: control.hovered ? "qrc:/images/sjq2.png" : "qrc:/images/sjq1.png"
                    Text {
                        id: b2text
                        anchors.centerIn: parent
                        text: "Help "
                        color: "#7B9977"
                        font.family: "Segoe Script"
                        font.bold: true
                        font.pixelSize: control.hovered ? 27 : 21
                    }
                }
            }
            onClicked: {
                mainpage.visible = false
                page_help.visible = true
            }
        }

        //button3---empty
        Button {
            property real y6: 0
            id: go2p3
            width: parent.width*0.14//125
            height: parent.width*0.14//125
            opacity: 1.0
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.45
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.5 + y6
            style: ButtonStyle {
                background: BorderImage {
                    source: control.hovered ? "qrc:/images/sjq2.png" : "qrc:/images/sjq1.png"
                }
            }
            onClicked: {
            }
        }

        //button4---empty
        Button {
            property real y7: 0
            id: go2p4
            width:  parent.width*0.075//60
            height: parent.width*0.075//60
            opacity: 0.8
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.62
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.64 + y7
            style: ButtonStyle {
                background: BorderImage {
                    source: control.hovered ? "qrc:/images/sjq2.png" : "qrc:/images/sjq1.png"
                }
            }
            onClicked: {
            }
        }

        //Buttom left bubble 1
        Image {
            id: paopao1
            width: 40
            height: 40
            x: mainpage.width*0.125
            y: mainpage.height*1.0625
            source: "qrc:/images/sjq1.png"
        }

        //Buttom left bubble 2
        Image {
            id: paopao2
            width: 35
            height: 35
            x: mainpage.width*0.125
            y: mainpage.height*1.0625
            source: "qrc:/images/sjq1.png"
        }

        //Buttom left bubble 3
        Image {
            id: paopao3
            width: 25
            height: 25
            x: mainpage.width*0.0625
            y: mainpage.height*1.0625
            source: "qrc:/images/sjq1.png"
        }

        //Buttom right bubble 4
        Image {
            id: paopao4
            width: 40
            height: 40
            x: mainpage.width*0.90625
            y: mainpage.height*1.0625
            source: "qrc:/images/sjq1.png"
        }

        //Buttom right bubble 5
        Image {
            id: paopao5
            width: 35
            height: 35
            x: mainpage.width*0.90625
            y: mainpage.height*1.0625
            source: "qrc:/images/sjq1.png"
        }

        //Buttom right bubble 6
        Image {
            id: paopao6
            width: 25
            height: 25
            x: mainpage.width*0.9625
            y: mainpage.height*1.0625
            source: "qrc:/images/sjq1.png"
        }

        //Animation of buttom left bubbles
        ParallelAnimation {
            id: jianxiepaopao1
            //pp1
            PropertyAnimation {
                target: paopao1
                property: "x"
                easing.type: Easing.OutCubic
                from: mainpage.width*0.125
                to: -mainpage.width*0.0125
                duration: 600
            }
            PropertyAnimation {
                target: paopao1
                property: "y"
                from: mainpage.height*1.0625
                to: -mainpage.height*0.21
                duration: 600
            }
            PropertyAnimation {
                target: paopao1
                properties: "width, height"
                from: 40
                to: 85
                duration: 600
            }
            //pp2
            PropertyAnimation {
                target: paopao2
                property: "x"
                easing.type: Easing.OutCubic
                from: mainpage.width*0.125
                to: mainpage.width*0.025
                duration: 750
            }
            PropertyAnimation {
                target: paopao2
                property: "y"
                from: mainpage.height*1.0625
                to: -mainpage.height*0.17
                duration: 750
            }
            PropertyAnimation {
                target: paopao2
                properties: "width, height"
                from: 35
                to: 80
                duration: 750
            }
            //pp3
            PropertyAnimation {
                target: paopao3
                property: "x"
                easing.type: Easing.OutCubic
                from: mainpage.width*0.0625
                to: mainpage.width*0.07
                duration: 900
            }
            PropertyAnimation {
                target: paopao3
                property: "y"
                from: mainpage.height*1.0625
                to: -mainpage.height*0.13
                duration: 900
            }
            PropertyAnimation {
                target: paopao3
                properties: "width, height"
                from: 25
                to: 65
                duration: 900
            }
        }

        //Animation of buttom right bubbles
        ParallelAnimation {
            id: jianxiepaopao2
            //pp4
            PropertyAnimation {
                target: paopao4
                property: "x"
                easing.type: Easing.OutCubic
                from: mainpage.width*0.90625
                to: mainpage.width*0.9625
                duration: 600
            }
            PropertyAnimation {
                target: paopao4
                property: "y"
                from: mainpage.height*1.0625
                to: -mainpage.height*0.2083
                duration: 600
            }
            PropertyAnimation {
                target: paopao4
                properties: "width, height"
                from: 40
                to: 80
                duration: 600
            }
            //pp5
            PropertyAnimation {
                target: paopao5
                property: "x"
                easing.type: Easing.OutCubic
                from: mainpage.width*0.90625
                to: mainpage.width*0.95
                duration: 800
            }
            PropertyAnimation {
                target: paopao5
                property: "y"
                from: mainpage.height*1.0625
                to: -mainpage.height*0.167
                duration: 800
            }
            PropertyAnimation {
                target: paopao5
                properties: "width, height"
                from: 35
                to: 75
                duration: 800
            }
            //pp6
            PropertyAnimation {
                target: paopao6
                property: "x"
                easing.type: Easing.OutCubic
                from: mainpage.width*0.9625
                to: mainpage.width*0.875
                duration: 900
            }
            PropertyAnimation {
                target: paopao6
                property: "y"
                from: mainpage.height*1.0625
                to: -mainpage.height*0.15
                duration: 900
            }
            PropertyAnimation {
                target: paopao6
                properties: "width, height"
                from: 25
                to: 60
                duration: 900
            }
        }

        //Animation of flowing buttons  //按钮浮动效果
        ParallelAnimation {
            id: fudong
            SequentialAnimation {
                NumberAnimation {
                    targets: go2p1
                    property: "y4"
                    from: 0
                    to: 5
                    duration: 1550
                }
                NumberAnimation {
                    targets: go2p1
                    property: "y4"
                    to: 0
                    duration: 1000
                }
                NumberAnimation {
                    targets: go2p1
                    property: "y4"
                    to: -5
                    duration: 1200
                }
                NumberAnimation {
                    targets: go2p1
                    property: "y4"
                    to: 0
                    duration: 1350
                }
            }
            SequentialAnimation {
                NumberAnimation {
                    targets: go2p2
                    property: "y5"
                    from: 0
                    to: -4
                    duration: 1000
                }
                NumberAnimation {
                    targets: go2p2
                    property: "y5"
                    to: -8
                    duration: 1200
                }
                NumberAnimation {
                    targets: go2p2
                    property: "y5"
                    to: -4
                    duration: 1350
                }
                NumberAnimation {
                    targets: go2p2
                    property: "y5"
                    to: 0
                    duration: 1550
                }
            }
            SequentialAnimation {
                NumberAnimation {
                    targets: go2p3
                    property: "y6"
                    from: 0
                    to: 3
                    duration: 1200
                }
                NumberAnimation {
                    targets: go2p3
                    property: "y6"
                    to: 6
                    duration: 1350
                }
                NumberAnimation {
                    targets: go2p3
                    property: "y6"
                    to: 3
                    duration: 1550
                }
                NumberAnimation {
                    targets: go2p3
                    property: "y6"
                    to: 0
                    duration: 1000
                }
            }
            SequentialAnimation {
                NumberAnimation {
                    targets: go2p4
                    property: "y7"
                    from: 0
                    to: -3
                    duration: 1250
                }
                NumberAnimation {
                    targets: go2p4
                    property: "y7"
                    to: 0
                    duration: 1450
                }
                NumberAnimation {
                    targets: go2p4
                    property: "y7"
                    to: 3
                    duration: 900
                }
                NumberAnimation {
                    targets: go2p4
                    property: "y7"
                    to: 0
                    duration: 1100
                }
            }
            loops: Animation.Infinite
        }
    }

    //page_help
    Item {
        id: page_help
        visible: false
        anchors.fill: parent

        //title---helpdocument
        Image {
            id: helptitle
            x: parent.width*0.5 - helptitle.width*0.2
            y: parent.height*0.2 - helptitle.height
            source: "qrc:/helpimage/help_image/helpdocument.gif"
        }

        //The left page button  //左翻页按钮
        Button {
            id: lefthelp
            visible: false
            width: 60
            height: 70
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.04
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.45
            style: ButtonStyle {
                background: BorderImage {
                    anchors.fill: parent
                    source: control.hovered ? (control.pressed ? "qrc:/helpimage/help_image/left_pressed.png" : "qrc:/helpimage/help_image/left_entered.png") : "qrc:/helpimage/help_image/left_normal.png"
                }
            }

            onClicked: {
                if (pagenum >= 1){
                    pagenum --;
                    righthelp.visible = true;
                    if (pagenum == 0){
                        lefthelp.visible = false;
                    }
                }
                if (pagenum == 0){
                    p0.visible = true
                    p1.visible = false
                    p2.visible = false
                    p3.visible = false
                    p4.visible = false
                    p5.visible = false
                }
                if (pagenum == 1){
                    p0.visible = false
                    p1.visible = true
                    p2.visible = false
                    p3.visible = false
                    p4.visible = false
                    p5.visible = false
                }
                if (pagenum == 2){
                    p0.visible = false
                    p1.visible = false
                    p2.visible = true
                    p3.visible = false
                    p4.visible = false
                    p5.visible = false
                }
                if (pagenum == 3){
                    p0.visible = false
                    p1.visible = false
                    p2.visible = false
                    p3.visible = true
                    p4.visible = false
                    p5.visible = false
                }
                if (pagenum == 4){
                    p0.visible = false
                    p1.visible = false
                    p2.visible = false
                    p3.visible = false
                    p4.visible = true
                    p5.visible = false
                }
                if (pagenum == 5){
                    p0.visible = false
                    p1.visible = false
                    p2.visible = false
                    p3.visible = false
                    p4.visible = false
                    p5.visible = true
                }
            }
        }

        //The right page button  //右翻页按钮
        Button {
            id: righthelp
            visible: true
            width: 60
            height: 70
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.885
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.45
            style: ButtonStyle {
                background: BorderImage {
                    anchors.fill: parent
                    source: control.hovered ? (control.pressed ? "qrc:/helpimage/help_image/right_pressed.png" : "qrc:/helpimage/help_image/right_entered.png") : "qrc:/helpimage/help_image/right_normal.png"
                }
            }

            onClicked: {
                if (pagenum <= 4){
                    pagenum ++;
                    lefthelp.visible = true;
                    if (pagenum == 5){
                        righthelp.visible = false;
                    }
                }
                if (pagenum == 0){
                    p0.visible = true
                    p1.visible = false
                    p2.visible = false
                    p3.visible = false
                    p4.visible = false
                    p5.visible = false
                }
                if (pagenum == 1){
                    p0.visible = false
                    p1.visible = true
                    p2.visible = false
                    p3.visible = false
                    p4.visible = false
                    p5.visible = false
                }
                if (pagenum == 2){
                    p0.visible = false
                    p1.visible = false
                    p2.visible = true
                    p3.visible = false
                    p4.visible = false
                    p5.visible = false
                }
                if (pagenum == 3){
                    p0.visible = false
                    p1.visible = false
                    p2.visible = false
                    p3.visible = true
                    p4.visible = false
                    p5.visible = false
                }
                if (pagenum == 4){
                    p0.visible = false
                    p1.visible = false
                    p2.visible = false
                    p3.visible = false
                    p4.visible = true
                    p5.visible = false
                }
                if (pagenum == 5){
                    p0.visible = false
                    p1.visible = false
                    p2.visible = false
                    p3.visible = false
                    p4.visible = false
                    p5.visible = true
                }
            }
        }

        //helppage 0
        Image {
            id: p0
            visible: true
            width: parent.width*0.7625//610
            height: parent.height*0.7//340
            x: parent.width*0.12
            y: parent.height*0.2
            source: "qrc:/helpimage/help_image/p0.png"
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onWheel: {
                    if(wheel.angleDelta.y<-90)
                        righthelp.clicked()
                    else if(wheel.angleDelta.y>90)
                        lefthelp.clicked()
                }
            }
        }

        //helppage 1
        Image {
            id: p1
            visible: false
            width: parent.width*0.7625//610
            height: parent.height*0.7//340
            x: parent.width*0.12
            y: parent.height*0.2
            source: "qrc:/helpimage/help_image/p1.png"
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onWheel: {
                    if(wheel.angleDelta.y<-90)
                        righthelp.clicked()
                    else if(wheel.angleDelta.y>90)
                        lefthelp.clicked()
                }
            }
        }

        //helppage 2
        Image {
            id: p2
            visible: false
            width: parent.width*0.7625//610
            height: parent.height*0.7//340
            x: parent.width*0.12
            y: parent.height*0.2
            source: "qrc:/helpimage/help_image/p2.png"
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onWheel: {
                    if(wheel.angleDelta.y<-90)
                        righthelp.clicked()
                    else if(wheel.angleDelta.y>90)
                        lefthelp.clicked()
                }
            }
        }

        //helppage 3
        Image {
            id: p3
            visible: false
            width: parent.width*0.7625//610
            height: parent.height*0.7//340
            x: parent.width*0.12
            y: parent.height*0.2
            source: "qrc:/helpimage/help_image/p3.png"
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onWheel: {
                    if(wheel.angleDelta.y<-90)
                        righthelp.clicked()
                    else if(wheel.angleDelta.y>90)
                        lefthelp.clicked()
                }
            }
        }

        //helppage 4
        Image {
            id: p4
            visible: false
            width: parent.width*0.7625//610
            height: parent.height*0.7//340
            x: parent.width*0.12
            y: parent.height*0.2
            source: "qrc:/helpimage/help_image/p4.png"
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onWheel: {
                    if(wheel.angleDelta.y<-90)
                        righthelp.clicked()
                    else if(wheel.angleDelta.y>90)
                        lefthelp.clicked()
                }
            }
        }

        //helppage 5
        Image {
            id: p5
            visible: false
            width: parent.width*0.7625//610
            height: parent.height*0.7//340
            x: parent.width*0.12
            y: parent.height*0.2
            source: "qrc:/helpimage/help_image/p5.png"
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onWheel: {
                    if(wheel.angleDelta.y<-90)
                        righthelp.clicked()
                    else if(wheel.angleDelta.y>90)
                        lefthelp.clicked()
                }
            }
        }

        //button return to mainpage
        Button {
            height: 40
            width: 40
            opacity: pressed?0.8:1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.02
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.92
            tooltip: "Back"
            style: ButtonStyle {
                background: Rectangle {
                    anchors.fill: parent
                    color: control.hovered ? "#AAAAAA" : "transparent"
                    Image {
                        width: 30
                        height: 30
                        anchors.centerIn: parent
                        source: control.hovered ? "qrc:/images/back1.png" : "qrc:/images/back.png"
                    }
                }
            }
            onClicked: {
                page_help.visible = false
                mainpage.visible = true
            }
        }
    }

    //Page_1
    Item {
        id: page_1
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        visible: false
        opacity: 1.0

        NumberAnimation on width{
            id: page_1_ani
            from: 0
            to: zy000.width
            duration: 250
        }

        Image {
            anchors.fill: parent
            source: "qrc:/images/background2.png"
        }

        //Left heading  //左侧标题
        Rectangle {
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.05
            anchors.leftMargin: parent.width*0.05
            width: parent.width*0.45
            height: parent.height*0.1
            color: "transparent"
            Text {
                anchors.centerIn: parent
                wrapMode: Text.Wrap
                text: qsTr("Plese choose the spcies that you want to study!")
                font.family: "Segoe UI"
                font.bold: true
                color: "black"
                font.pixelSize: 15
            }
        }

        //Right heading  //右侧标题
        Rectangle {
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.05
            width:parent.width*0.45
            anchors.left: unselect.right
            anchors.leftMargin: 20
            height: 50
            color:"transparent"
            Text {
                anchors.centerIn: parent
                wrapMode: Text.Wrap
                text:qsTr("The spcies that have been selected")
                font.family: "Segoe UI"
                font.bold: true
                color: "black"
                font.pixelSize: 15
            }
        }

        //Left list---unselect      //左侧未选择列表
        Item {
            id: unselect
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height*0.15
            anchors.leftMargin: parent.width*0.05
            width: parent.width*0.38
            height: parent.height*0.7
            focus: true
            Keys.onPressed: {
                if(event.key == Qt.Key_Up){
                    slider.value++
                }
                else if(event.key==Qt.Key_Down){
                    slider.value--
                }
                else if(event.key==Qt.Key_Right||event.key==Qt.Key_Enter){
                    var index=unselectlist.currentIndex
                    ogCtl.add2SelOg(ogCtl.tran2ID(unselect_sp.get(index).name)); /** Add organism to list, contact with C++ **/
                    select_sp.append(unselect_sp.get(index))
                    unselect_sp.remove(index)
                }
            }

            Timer {
                id: moveup
                interval: 200
                repeat: true
                onTriggered: {
                    if(unselectlist.currentIndex>0)
                        unselectlist.currentIndex=unselectlist.currentIndex-1
                }
            }
            Timer {
                id: movedown
                interval: 200
                repeat: true
                onTriggered: {
                    if(unselectlist.currentIndex<unselectlist.count-1)
                        unselectlist.currentIndex=unselectlist.currentIndex+1
                }
            }
            ListView {
                id: unselectlist
                width: parent.width
                height: parent.height-60
                anchors.top: parent.top
                anchors.topMargin: 10
                clip: true
                model: unselect_sp
                /** define organisms list **/
                ListModel {
                    id: unselect_sp
                    ListElement {
                        name: "Acinetobacter baylyi ADP1"
                    }
                    ListElement {
                        name: "Bacillus subtilis 168"
                    }
                    ListElement {
                        name: "Escherichia coli MG1655"
                    }
                    ListElement {
                        name: "Francisella novicida U112"
                    }
                    ListElement {
                        name: "Haemophilus influenzae Rd KW20"
                    }
                    ListElement {
                        name: "Helicobacter pylori 26695"
                    }
                    ListElement {
                        name: "Mycoplasma genitalium G37"
                    }
                    ListElement {
                        name: "Mycoplasma pulmonis UAB CTIP"
                    }
                    ListElement {
                        name: "Mycobacterium tuberculosis H37Rv"
                    }
                    ListElement {
                        name: "Pseudomonas aeruginosa UCBPP-PA14"
                    }
                    ListElement {
                        name: "Staphylococcus aureus NCTC 8325"
                    }
                    ListElement {
                        name: "Streptococcus pneumoniae"
                    }
                    ListElement {
                        name: "Staphylococcus aureus N315"
                    }
                    ListElement {
                        name: "Salmonella typhimurium LT2"
                    }
                    ListElement {
                        name: "Salmonella enterica serovar Typhi"
                    }
                    ListElement {
                        name: "Vibrio cholerae N16961"
                    }
                    ListElement {
                        name: "Caulobacter crescentus"
                    }
                    ListElement {
                        name: "Streptococcus sanguinis"
                    }
                    ListElement {
                        name: "Porphyromonas gingivalis ATCC 33277"
                    }
                    ListElement {
                        name: "Bacteroides thetaiotaomicron VPI-5482"
                    }
                    ListElement {
                        name: "Burkholderia thailandensis E264"
                    }
                    ListElement {
                        name: "Sphingomonas wittichii RW1"
                    }
                    ListElement {
                        name: "Shewanella oneidensis MR-1"
                    }
                    ListElement {
                        name: "Salmonella enterica serovar Typhimurium SL1344"
                    }
                    ListElement {
                        name: "Bacteroides fragilis 638R"
                    }
                    ListElement {
                        name: "Burkholderia pseudomallei K96243"
                    }
                    ListElement {
                        name: "Salmonella enterica subsp. enterica serovar Typhimurium str. 14028S"
                    }
                    ListElement {
                        name: "Pseudomonas aeruginosa PAO1"
                    }
                    ListElement {
                        name: "Campylobacter jejuni subsp. jejuni NCTC 11168 = ATCC 700819"
                    }
                }

                //项目属性
                delegate: Item {
                    id: itemdelegate
                    width: parent.width
                    height: 30
                    Image {
                        anchors.fill: parent
                        source: "qrc:/images/frame.png"
                        visible: unselectlist.currentIndex==index
                    }
                    Behavior on height {
                        SmoothedAnimation { velocity:100 }
                    }
                    //拖动属性
                    Drag.active: mouseaction.drag.active
                    Drag.dragType: Drag.Automatic
                    Drag.mimeData: { "index":index,"type":"unselect" }
                    Drag.onDragStarted: {
                        frame.visible=true
                    }
                    Drag.onDragFinished: {
                        frame.visible=false
                        ani.visible=false
                    }
                    //外观
                    Rectangle {
                        id: rec
                        anchors.fill: parent
                        color: "transparent"
                        Text {
                            id: rec_text
                            anchors.left: parent.left
                            anchors.leftMargin: 5
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 5
                            text: name
                            color: "black"
                            font.pixelSize: unselectlist.currentIndex==index?17:15//unselectlist.currentIndex==index?parent.height-12:parent.height-5
                            font.family: "Microsoft YaHei"
                        }
                    }
                    //鼠标
                    MouseArea {
                        id: mouseaction
                        anchors.fill: parent
                        hoverEnabled: true
                        z: 10
                        onEntered: {
                            unselectlist.currentIndex=index
                            slider.value=unselectlist.count-index-1
                        }
                        onReleased: {
                            parent.x=0
                            var i=index
                            unselect_sp.insert(index,unselect_sp.get(index))
                            unselect_sp.remove(index)
                            unselectlist.currentIndex=i
                        }
                        onPressed: {
                            rec_text.color="red"
                        }
                        onDoubleClicked:{
                            ogCtl.add2SelOg(ogCtl.tran2ID(unselect_sp.get(index).name)); /** Add organism to list, contact with C++ **/
                            select_sp.append(unselect_sp.get(index))
                            unselect_sp.remove(index)
                            //slider.maximumValue=unselectlist.count-1
                        }
                        drag.target: parent
                    }
                }
            }

            Slider {
                id: slider
                width: 10
                value: unselectlist.count-1
                height: unselectlist.height
                anchors.left: unselectlist.right
                anchors.top: unselectlist.top
                orientation: Qt.Vertical
                maximumValue: unselectlist.count-1
                minimumValue: 0
                stepSize: 1.0

                onValueChanged: {
                    unselectlist.currentIndex=unselectlist.count-value-1
                }
            }
        }

        //Right list---selected     //右侧已选择列表
        Item {
            id: rightlist
            width: parent.width*0.40
            height: unselect.height-40
            anchors.top:unselect.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.51
            clip: true
            ListView {
                id: selectlist
                anchors.fill: parent
                model: select_sp
                spacing: 3
                Image {
                    id: frame
                    visible: false
                    anchors.fill: parent
                    source: "qrc:/images/listframe.png"
                }

                ListModel {
                    id: select_sp

                }
                delegate: Item {
                    width: parent.width
                    height: 30

                    Rectangle {
                        anchors.fill: parent
                        radius: parent.height*0.2
                        color: "transparent"
                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            text: name
                            color: "black"
                            font.pixelSize: 15
                            font.family: "Segoe UI"
                        }
                    }
                    Drag.active: _mouseaction.drag.active
                    Drag.dragType: Drag.Automatic
                    Drag.mimeData: { "index":index,"type":"select" }
                    Drag.onDragFinished: {
                        ani.visible=false
                    }
                    MouseArea {
                        id: _mouseaction
                        anchors.fill: parent
                        drag.target: parent
                        onReleased: {
                            parent.x=0
                            select_sp.insert(index,select_sp.get(index))
                            select_sp.remove(index)
                        }
                        onDoubleClicked: {
                            ogCtl.delFromSelOg(ogCtl.tran2ID(select_sp.get(index).name));
                            unselect_sp.append(select_sp.get(index))
                            select_sp.remove(index)
                        }
                    }
                }
            }
        }

        //Black border  //边框
        Rectangle {
            id: kuangkuang
            width: rightlist.width
            height: rightlist.height
            radius: 5
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.95 - rightlist.width
            anchors.top: unselect.top
            color: "transparent"
            border.color: "transparent"
            border.width: 5
        }

        //Drag and drop property settings   //拖动目标释放属性设置
        DropArea {
            anchors.fill: parent
            onEntered: {

            }
            onPositionChanged: {
                drag.accepted=true
                ani.x=drag.x+10
                ani.y=drag.y-5
                ani.visible=true
            }

            onExited: {
            }
            onDropped: {
                ani.visible=false
                if(drop.proposedAction==Qt.MoveAction&&drop.x>width*0.5&&drop.getDataAsString("type")==="unselect"){
                    select_sp.append(unselect_sp.get(parseInt(drop.getDataAsString("index"))))
                    ogCtl.add2SelOg(ogCtl.tran2ID(unselect_sp.get(parseInt(drop.getDataAsString("index"))).name)); /** Add organism to list, contact with C++ **/
                    unselect_sp.remove(parseInt(drop.getDataAsString("index")),1)
                }
                else if(drop.proposedAction==Qt.MoveAction&&drop.x<width*0.5&&drop.getDataAsString("type")==="select"){
                    unselect_sp.append(select_sp.get(parseInt(drop.getDataAsString("index"))))
                    ogCtl.delFromSelOg(ogCtl.tran2ID(select_sp.get(parseInt(drop.getDataAsString("index"))).name)); /** Delete organism from list, contact with C++ **/
                    select_sp.remove(parseInt(drop.getDataAsString("index")),1)
                }
            }
        }

        //Pictures when you drag and drop   //拖动时跟随的图片
        Item {
            id: ani
            visible: false
            width: ani_image.width
            height: ani_image.height
            Image {
                id: ani_image
                source: "qrc:/images/drag.png"
            }
            z: 5
        }

        //Sort button   //排序按钮
        Button {
            id: sort
            height: 42
            width: 42
            opacity: pressed?0.8:1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.02
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.1-width*0.5
            tooltip: "Sort"
            style: ButtonStyle {
                background: Rectangle {
                    radius: 5
                    anchors.fill: parent
                    color: control.hovered ? "#AAAAAA" : "transparent"
                    Image {
                        width: 35
                        height: 35
                        anchors.centerIn: parent
                        source: control.hovered ? "qrc:/images/sort1(1).png" : "qrc:/images/sort(1).png"
                    }
                }
            }
            onClicked: {
                for(var i=0;i<unselect_sp.count;i++){
                    for(var j=i+1;j<unselect_sp.count;j++){
                        if(unselect_sp.get(i).name>unselect_sp.get(j).name){
                            var s=unselect_sp.get(i).name
                            unselect_sp.setProperty(i,"name",unselect_sp.get(j).name)
                            unselect_sp.setProperty(j,"name",s)
                        }
                    }
                }
            }
        }

        //Submit button
        Button {
            height: 42
            width: 42
            opacity: pressed?0.8:1
            anchors.bottom:parent.bottom
            anchors.bottomMargin:parent.height*0.02
            anchors.left:parent.left
            anchors.leftMargin: parent.width*0.9-width*0.5
            tooltip: "Next"
            style: ButtonStyle {
                background: Rectangle {
                    radius: 20
                    anchors.fill: parent
                    color: control.hovered ? "#757575" : "transparent"
                    Image {
                        width: 35
                        height: 35
                        anchors.centerIn: parent
                        source: control.hovered ? "qrc:/images/next1.png" : "qrc:/images/next.png"
                    }
                }
            }
            onClicked: {
                if(select_sp.count<4){
                    message.show()
                }
                else{
                    ogCtl.submit_cluster() /** Load minimal gene set filtered, contact with C++ **/
                    page_1.visible = false
                    page_2.visible = true
                    ruchuang.start()
                    wait3pao.start()    //注意！延时启动浮动效果fudong_p2.start()
                }
            }
        }

        //Home button
        Button {
            height: 42
            width: 42
            opacity: pressed?0.8:1
            anchors.bottom:parent.bottom
            anchors.bottomMargin:parent.height*0.02
            anchors.left:parent.left
            anchors.leftMargin: parent.width*0.5-width*0.5
            tooltip: "Home"
            style: ButtonStyle {
                background: Rectangle {
                    radius: 5
                    anchors.fill: parent
                    color: control.hovered ? "#AAAAAA" : "transparent"
                    Image {
                        width: 35
                        height: 35
                        anchors.centerIn: parent
                        source: control.hovered ? "qrc:/images/home1.png" : "qrc:/images/home.png"
                    }
                }
            }
            onClicked: {
                page_1.visible = false
                mainpage.visible = true
            }
        }

        //File button   //存档按钮
        Button {
            id: record
            height: 42
            width: 42
            opacity: pressed?0.8:1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.02
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.6-width*0.5
            tooltip: "Save"
            style: ButtonStyle {
                background: Rectangle {
                    radius: 6
                    anchors.fill: parent
                    color: control.hovered ? "#AAAAAA" : "transparent"
                    Image {
                        width: 35
                        height: 35
                        anchors.centerIn: parent
                        source: control.hovered ? "qrc:/images/record1.png" : "qrc:/images/record.png"
                    }
                }
            }
            onClicked: {
                if(select_sp.count<4){
                    message.show()
                }
                else{
                    var label =new String
                    label =Qt.formatDateTime(new Date(), "MM-dd-hh-mm-ss")
                    var n=select_sp.count
                    var s=new String
                    for(var i=0;i<n;i++)
                        s=s+ogCtl.tran2ID(select_sp.get(i).name)
                    recordlist.append({"label":label,"source":s,"flag":0})
                    var ok=recordlist.count;
                    for(i=recordlist.count-2;i>=0;i--){
                        if(recordlist.get(i).source===recordlist.get(recordlist.count-1).source){
                            ok=i
                            break
                        }
                    }
                    if(ok!=recordlist.count){
                        cover._open(ok)
                    }
                    else
                        narrow.start()
                }
                nodata.n=recordlist.count

            }
        }

        //History button    //历史按钮
        Button {
            height: 42
            width: 42
            opacity: pressed?0.8:1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.02
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.7-width*0.5
            tooltip: "History"
            style: ButtonStyle {
                background: Rectangle {
                    radius: 20
                    anchors.fill: parent
                    color: control.hovered ? "#AAAAAA" : "transparent"
                    Image {
                        width: 35
                        height: 35
                        anchors.centerIn: parent
                        source: control.hovered ? "qrc:/images/history1.png" : "qrc:/images/history.png"
                    }
                }
            }
            onClicked: {
                recorditem.show()
            }
        }

        //Clear button  //清除选择按钮
        Button {
            height: 43
            width: 43
            opacity: pressed?0.8:1
            anchors.leftMargin: parent.width*0.8-width*0.5
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.02
            tooltip: "Reset"
            style: ButtonStyle {
                background: Rectangle {
                    radius: 20
                    anchors.fill: parent
                    color: control.hovered ? "#AAAAAA" : "transparent"
                    Image {
                        width: 35
                        height: 35
                        anchors.centerIn: parent
                        source: control.hovered ? "qrc:/images/clear1.png" : "qrc:/images/clear.png"
                    }
                }
            }
            onClicked: {
                ogCtl.clear(); /** Clear organism list, contact with C++ **/
                for(var i=select_sp.count-1;i>=0;i--){
                    unselect_sp.append(select_sp.get(i))
                    select_sp.remove(i)
                }
                sort.clicked()
            }
        }

        //Prompt    //提示
        Item {
            id: message
            height: 30
            width: parent.width*0.4
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.14
            x: parent.width
            visible: true
            Rectangle {
                anchors.fill: parent
                color: "black"
                radius: 3
                opacity:0.6
                Text {
                    anchors.centerIn: parent
                    text: "Please choose 4 spcies at least!"
                    color: "white"
                    font.family: "Microsoft Yahei"
                }
            }
            function show(){
                message_show.start()
                message_ani.start()
            }
        }

        PropertyAnimation{
            id:message_show
            target: message
            duration: 500
            property: "x"
            to:page_1.width-message.width
        }
        PropertyAnimation{
            id:message_hide
            duration: 500
            target: message
            property:"x"
            to:page_1.width
        }
        Timer{
            id:message_ani
            interval: 3000
            onTriggered: {
                message_hide.start()
            }
        }

        //Animatio of saving    //存档时缩小动画
        SequentialAnimation {
            id: narrow
            ParallelAnimation {
                PropertyAnimation {
                    target:	kuangkuang
                    properties:	"border.color"
                    to:	"black"
                    duration: 300
                    easing.type: Easing.OutQuad
                }
                PropertyAnimation {
                    target:	kuangkuang
                    properties:	"width,height"
                    to:	0
                    duration: 300
                    easing.type: Easing.OutQuad
                }
                PropertyAnimation {
                    target:	kuangkuang
                    properties:	"anchors.leftMargin"
                    to: record.x + 3
                    duration: 300
                    easing.type: Easing.OutQuad
                }
                PropertyAnimation {
                    target:	kuangkuang
                    properties:	"anchors.topMargin"
                    to:	record.y - record.height
                    duration: 300
                    easing.type: Easing.OutQuad
                }
            }

            ParallelAnimation {
                PropertyAnimation {
                    target:	kuangkuang
                    properties:	"border.color"
                    to:	"transparent"
                    duration: 0
                }
                PropertyAnimation {
                    target:	kuangkuang
                    properties:	"width"
                    to:	rightlist.width
                    duration: 0
                }
                PropertyAnimation {
                    target:	kuangkuang
                    properties:	"height"
                    to:	rightlist.height
                    duration: 0
                }
                PropertyAnimation {
                    target:	kuangkuang
                    properties:	"anchors.leftMargin"
                    to:	page_1.width*0.95 - rightlist.width
                    duration: 0
                }
                PropertyAnimation {
                    target:	kuangkuang
                    properties:	"anchors.topMargin"
                    to:	0
                    duration: 0
                }
            }
        }
    }

    //Window of showing contrast results    //对比结果显示窗口
    Item {
        id: compareitem
        anchors.fill: parent
        visible: false
        //
        Item {
            height: 40
            width: 40
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            z: 5
            Rectangle {
                anchors.fill: parent
                id: view_rec
                color: "transparent"
            }

            Image {
                id: image
                width: 30
                height: 30
                anchors.centerIn: parent
                source: "qrc:/images/view.png"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    if(comparetab.currentIndex==0){
                        viewitem1.visible=true
                        view_rec.color="#444444"
                    }
                    else if(comparetab.currentIndex==1){
                        viewitem2.visible=true
                        view_rec.color="#444444"
                    }
                }
                onExited: {
                    view_rec.color="transparent"
                    viewitem1.visible=false
                    viewitem2.visible=false
                }
            }
        }

        //Results view list
        Item {
            id: viewitem1
            visible: false
            width: 300
            height: view1model.count*20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            anchors.left: parent.left
            z: 5
            ListView {
                anchors.fill: parent
                model: view1model
                delegate: Item {
                    height: 20
                    width: 300
                    Rectangle {
                        anchors.fill: parent
                        color: index%2==0?"#AAAAAA":"#444444"
                    }
                    Text {
                        text: name
                        anchors.centerIn: parent
                        color: index%2==0?"#444444":"#AAAAAA"
                    }
                }
            }
        }
        Item {
            id: viewitem2
            visible: false
            width: 300
            height: view2model.count*20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            anchors.left: parent.left
            z: 5
            ListView{
                anchors.fill: parent
                model: view2model
                delegate: Item {
                    height: 20
                    width: 300
                    Rectangle {
                        anchors.fill: parent
                        color: index%2==0?"#AAAAAA":"#444444"
                    }
                    Text {
                        text: name
                        anchors.centerIn: parent
                        color: index%2==0?"#444444":"#AAAAAA"
                    }
                }
            }
        }

        //tab
        ListView {
            id:comparetab
            boundsBehavior:Flickable.StopAtBounds
            orientation: ListView.Horizontal
            height: 40
            width: parent.width
            highlightMoveVelocity: 800
            model: ListModel {
                ListElement {
                    name:"Group 1"
                }
                ListElement {
                    name:"Group 2"
                }
                ListElement {
                    name:"Common"
                }
            }
            highlight: Component {
                Rectangle {
                    height: 40
                    width: compareitem.width*0.2
                    Image {
                        anchors.fill: parent
                        source: "qrc:/images/cover.png"
                    }
                }
            }
            delegate: Component {
                Item {
                    height: 40
                    width: compareitem.width*0.2
                    Text {
                        anchors.centerIn: parent
                        text: name
                        font.pixelSize: 20
                        color: index==comparetab.currentIndex?"white":"black"
                        font.family: "Microsoft Yahei UI"
                    }
                    MouseArea{
                        anchors.fill: parent
                        //hoverEnabled:true
                        onClicked: {
                            comparetab.currentIndex=index
                            comparetabitem.currentIndex=index
                        }
                        onWheel: {
                            if(wheel.angleDelta.y>90&&comparetab.currentIndex>0){
                                comparetab.currentIndex--
                                comparetabitem.currentIndex=comparetab.currentIndex
                            }
                            else if(wheel.angleDelta.y<-90&&comparetab.currentIndex<2){
                                comparetab.currentIndex++
                                comparetabitem.currentIndex=comparetab.currentIndex
                            }
                        }

                    }
                }
            }
        }

        //model
        ListModel {
            id: c1_result
        }
        ListModel {
            id: c2_result
        }
        ListModel {
            id: c3_result
        }
        ListModel {
            id: view1model
        }
        ListModel {
            id: view2model
        }

        //表格
        TabView {
            id: comparetabitem
            width: parent.width
            height: parent.height*0.8
            anchors.top: parent.top
            anchors.topMargin: 40
            frameVisible: false
            tabsVisible: false
            x: parent.width*0.5-width*0.5
            y: parent.height*0.1
            Tab {
                title:"1"
                TableView {
                    anchors.fill: parent
                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                    }
                    //只有1的model
                    model: c1_result
                    TableViewColumn {
                        title: "Name"
                        role: "name"
                    }
                    TableViewColumn {
                        title: "Type"
                        role: "type"
                    }
                    TableViewColumn {
                        title: "Description"
                        role: "description"
                    }
                    headerDelegate: Rectangle {
                        height: 30
                        Text {
                            text: styleData.value
                            anchors.left: parent.left
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 5
                            anchors.bottomMargin: 5
                            font.pixelSize: 20
                            font.family: "SimHei"
                        }
                    }

                    itemDelegate: Rectangle {
                        Text {
                            text:styleData.value
                            anchors.left: parent.left
                            anchors.leftMargin: 7
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 2
                            font.pointSize: 10
                            font.family: "Microsoft Yahei"
                        }
                    }

                    rowDelegate: Rectangle{
                        height: 20
                        color:"transparent"
                    }

                }
            }
            Tab {
                title: "2"
                TableView {
                    anchors.fill: parent
                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                    }

                    model:c2_result
                    TableViewColumn {
                        title: "Name"
                        role: "name"
                    }
                    TableViewColumn {
                        title: "Type"
                        role: "type"
                    }
                    TableViewColumn {
                        title: "Description"
                        role: "description"
                    }
                    headerDelegate: Rectangle {
                        color:"white"
                        height: 30

                        Text{
                            text: styleData.value
                            anchors.left: parent.left
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 5
                            anchors.bottomMargin: 5
                            font.pixelSize: 20
                            font.family: "SimHei"
                        }
                    }

                    itemDelegate: Rectangle {
                        height: 30
                        Text {
                            text: styleData.value
                            anchors.left: parent.left
                            anchors.leftMargin: 7
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 2
                            font.pointSize: 10
                            font.family: "Microsoft Yahei"
                        }
                    }

                    rowDelegate: Rectangle {
                        height: 20
                        color: "transparent"
                    }
                }

            }
            Tab {
                title: "3"
                TableView {
                    anchors.fill: parent
                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                    }

                    model: c3_result
                    TableViewColumn {
                        title: "Name"
                        role: "name"
                    }
                    TableViewColumn {
                        title: "Type"
                        role: "type"
                    }
                    TableViewColumn {
                        title: "Description"
                        role: "description"
                    }
                    headerDelegate: Rectangle {
                        color: "white"
                        height: 30
                        width: styleData.column===0?80:100
                        Text {
                            text: styleData.value
                            anchors.left: parent.left
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 5
                            anchors.bottomMargin: 5
                            font.pixelSize: 20
                            font.family: "SimHei"
                        }
                    }

                    itemDelegate: Rectangle {
                        Text {
                            text: styleData.value
                            anchors.left: parent.left
                            anchors.leftMargin: 7
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 2
                            font.pointSize: 10
                            font.family: "Microsoft Yahei"
                        }
                    }

                    rowDelegate: Rectangle {
                        height: 20
                        color: "transparent"
                    }
                }
            }
        }
        //back
        Button {
            height: 40
            width: 40
            opacity: pressed?0.8:1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.02
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.9-20
            tooltip: "Back"
            style: ButtonStyle {
                background: Rectangle {
                    anchors.fill: parent
                    color: control.hovered?"#AAAAAA":"transparent"
                    Image {
                        width: 30
                        height: 30
                        anchors.centerIn: parent
                        source: control.hovered?"qrc:/images/back1.png":"qrc:/images/back.png"
                    }
                }
            }
            onClicked: {
                compareitem.visible=false
                page_1.visible=true
            }
        }
        Rectangle {
            width: 300
            height:parent.height*0.1
            color: "transparent"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: 5
            anchors.leftMargin: 10
            Text {
                anchors.centerIn: parent
                font.pixelSize: 15
            }
        }
    }

    //Dialog to ask whether to cover
    MessageDialog {
        id: cover
        visible: false
        title: "Attention"
        icon: StandardIcon.Information
        text: "The project already exists, whether to cover it?"
        standardButtons: StandardButton.Yes|StandardButton.No
        property int n
        function _open(a){
            n=a
            cover.open()
        }
        onYes: {
            if(recordlist.get(n).flag)
                recorditem.num--
            recordlist.remove(n)
            narrow.start()
        }
        onNo: {
            recordlist.remove(recordlist.count-1)
        }
        onRejected: {
            recordlist.remove(recordlist.count-1)
        }
    }

    //Page_2
    Item {
        id: page_2
        visible: false
        width: parent.width
        height: parent.height

        //background picture    //设置背景图片
        Image {
            id: p2background
            anchors.fill: parent
            source: "qrc:/images/background_3.png"
        }

        //btn1----result
        Image {
            property real y1: 0
            id: resultbtn
            width:  parent.width*0.25
            height: parent.width*0.25
            opacity: 0.0
            source: "qrc:/images/sjq1.png"
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.22
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.2 + y1
            Text {
                id: resultbtntext
                anchors.centerIn: parent
                text: "Result "
                font.pixelSize: 24
                font.family: "Segoe Script"
                font.bold: true
                color: "black"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    resultbtn.source = "qrc:/images/sjq2.png"
                    resultbtntext.font.pixelSize = 30
                    res1.visible = true
                    res2.visible = true
                    res3.visible = true
                    res4.visible = true
                    closeres.stop()     //让4泡消失的计时暂停
                    closeresvis.stop()
                    showres.start()     //4泡渐变出现
                }
                onExited: {
                    resultbtn.source = "qrc:/images/sjq1.png"
                    resultbtntext.font.pixelSize = 24
                    closeres.start()
                    closeresvis.start()
                }
                onPressed: {
                    resultbtn.source = "qrc:/images/sjq1.png"
                }
                onReleased: {
                    resultbtn.source = "qrc:/images/sjq2.png"
                    shackres.start()
                }
            }
        }

        //btn1_1:
        Image {
            id: res1
            width: parent.width*0.225
            height: parent.width*0.225
            opacity: 0.0
            source: "qrc:/images/sjq1.png"
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.12
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.55
            Text {
                id: res1text
                anchors.centerIn: parent
                text: " Transport&  \nMetabolism  "
                font.family: "Segoe UI Light"
                font.pixelSize: 16
                font.bold: true
                color: "black"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    res1.source = "qrc:/images/sjq2.png"
                    res1text.font.pixelSize = 17
                    closeres.stop()     //让4泡消失的计时暂停
                    closeresvis.stop()
                }
                onExited: {
                    res1.source = "qrc:/images/sjq1.png"
                    res1text.font.pixelSize = 16
                    if(vanishflag == 0){
                        closeres.start()
                        closeresvis.start()
                    }
                }
                onPressed: {
                    res1.source = "qrc:/images/sjq1.png"
                }
                onReleased: {
                    res1.source = "qrc:/images/sjq2.png"
                    tanchuang1.visible = true
                    tanchuang2.visible = false
                    tanchuang3.visible = false
                    tanchuang4.visible = false
                    resultbtn.visible = false
                    pathwaybtn.visible = false
                    modulebtn.visible = false
                    p2download.visible = false
                    p2return.visible = false
                    p2home.visible = false
                    showtanchuang1.start()
                    hide3pao.start()
                    tanchuang2_leave.start()
                    tanchuang3_leave.start()
                    tanchuang4_leave.start()
                    res1toleft.start()
                    p2background.source = "qrc:/images/pure_background.png"
                    vanishflag = 1
                }
            }
        }

        //btn1_2:
        Image {
            id: res2
            width: parent.width*0.15625//125
            height: parent.width*0.15625
            source: "qrc:/images/sjq1.png"
            opacity: 0.0
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.13
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.11
            Text {
                id: res2text
                anchors.centerIn: parent
                text: " Translation&  \nTranscription"
                font.family: "Segoe UI Light"
                font.pixelSize: 13
                font.bold: true
                color: "black"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    res2.source = "qrc:/images/sjq2.png"
                    res2text.font.pixelSize = 14
                    closeres.stop()     //让4泡消失的计时暂停
                    closeresvis.stop()
                }
                onExited: {
                    res2.source = "qrc:/images/sjq1.png"
                    res2text.font.pixelSize = 13
                    if(vanishflag == 0){
                        closeres.start()
                        closeresvis.start()
                    }
                }
                onPressed: {
                    res2.source = "qrc:/images/sjq1.png"
                }
                onReleased: {
                    res2.source = "qrc:/images/sjq2.png"
                    tanchuang1.visible = false
                    tanchuang2.visible = true
                    tanchuang3.visible = false
                    tanchuang4.visible = false
                    resultbtn.visible = false
                    pathwaybtn.visible = false
                    modulebtn.visible = false
                    p2download.visible = false
                    p2return.visible = false
                    p2home.visible = false
                    showtanchuang2.start()
                    hide3pao.start()
                    tanchuang1_leave.start()
                    tanchuang3_leave.start()
                    tanchuang4_leave.start()
                    res2toleft.start()
                    p2background.source = "qrc:/images/pure_background.png"
                    vanishflag = 1
                }
            }
        }

        //btn1_3:
        Image {
            id: res3
            width: parent.width*0.19375//155
            height: parent.width*0.19375
            source: "qrc:/images/sjq1.png"
            opacity: 0.0
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.06
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.32
            Text {
                id: res3text
                anchors.centerIn: parent
                text: "General function  \n prediction only"
                font.family: "Segoe UI Light"
                font.pixelSize: 13
                font.bold: true
                color: "black"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    res3.source = "qrc:/images/sjq2.png"
                    res3text.font.pixelSize = 14
                    closeres.stop()     //让4泡消失的计时暂停
                    closeresvis.stop()
                }
                onExited: {
                    res3.source = "qrc:/images/sjq1.png"
                    res3text.font.pixelSize = 13
                    if(vanishflag == 0){
                        closeres.start()
                        closeresvis.start()
                    }
                }
                onPressed: {
                    res3.source = "qrc:/images/sjq1.png"
                }
                onReleased: {
                    res3.source = "qrc:/images/sjq2.png"
                    tanchuang1.visible = false
                    tanchuang2.visible = false
                    tanchuang3.visible = true
                    tanchuang4.visible = false
                    resultbtn.visible = false
                    pathwaybtn.visible = false
                    modulebtn.visible = false
                    p2download.visible = false
                    p2return.visible = false
                    p2home.visible = false
                    showtanchuang3.start()
                    hide3pao.start()
                    tanchuang1_leave.start()
                    tanchuang2_leave.start()
                    tanchuang4_leave.start()
                    res3toleft.start()
                    p2background.source = "qrc:/images/pure_background.png"
                    vanishflag = 1
                }
            }
        }

        //btn1_4:
        Image {
            id: res4
            width: parent.width*0.125//100
            height: parent.width*0.125
            source: "qrc:/images/sjq1.png"
            opacity: 0.0
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.26
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.03
            Text {
                id: res4text
                anchors.centerIn: parent
                text: "Others"
                font.family: "Segoe UI Light"
                font.pixelSize: 14
                font.bold: true
                color: "black"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    res4.source = "qrc:/images/sjq2.png"
                    res4text.font.pixelSize = 15
                    closeres.stop()     //让4泡消失的计时暂停
                    closeresvis.stop()
                }
                onExited: {
                    res4.source = "qrc:/images/sjq1.png"
                    res4text.font.pixelSize = 14
                    if(vanishflag == 0){
                        closeres.start()
                        closeresvis.start()
                    }
                }
                onPressed: {
                    res4.source = "qrc:/images/sjq1.png"
                }
                onReleased: {
                    res4.source = "qrc:/images/sjq2.png"
                    tanchuang1.visible = false
                    tanchuang2.visible = false
                    tanchuang3.visible = false
                    tanchuang4.visible = true
                    resultbtn.visible = false
                    pathwaybtn.visible = false
                    modulebtn.visible = false
                    p2download.visible = false
                    p2return.visible = false
                    p2home.visible = false
                    showtanchuang4.start()
                    hide3pao.start()
                    tanchuang1_leave.start()
                    tanchuang2_leave.start()
                    tanchuang3_leave.start()
                    res4toleft.start()
                    p2background.source = "qrc:/images/pure_background.png"
                    vanishflag = 1
                }
            }
        }

        //btn2----pathway
        Image {
            property real y2: 0
            id: pathwaybtn
            width: parent.width*0.2375//190
            height: parent.width*0.23
            source: "qrc:/images/sjq1.png"
            opacity: 0.0
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.55
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.1 + y2
            Text {
                id: pathwaybtntext
                anchors.centerIn: parent
                text: "Pathway"
                font.family: "Segoe Script"
                font.pixelSize: 20
                font.bold: true
                color: "black"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    pathwaybtn.source = "qrc:/images/sjq2.png"
                    pathwaybtntext.font.pixelSize = 26
                    closepath.stop()     ////让p双泡消失的计时暂停
                    closepathvis.stop()
                    showpath.start()     //2泡渐变出现
                    pwg.visible = true
                    pwm.visible = true
                }
                onExited: {
                    pathwaybtn.source = "qrc:/images/sjq1.png"
                    pathwaybtntext.font.pixelSize = 20
                    closepath.start()
                    closepathvis.start()
                }
                onPressed: {
                    pathwaybtn.source = "qrc:/images/sjq1.png"
                }
                onReleased: {
                    pathwaybtn.source = "qrc:/images/sjq2.png"
                    shackpath.start()
                }
            }
        }

        //btn2_1: pathway with whole gene
        Image {
            id: pwg
            visible: true
            width: parent.width*0.10625//85
            height: parent.width*0.10625
            source: "qrc:/images/sjq1.png"
            opacity: 0.0
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.74
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.06
            Text {
                id: pwgtext
                anchors.centerIn: parent
                text: "Gene"
                font.family: "Segoe UI Light"
                font.pixelSize: 15
                font.bold: true
                color: "black"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    pwg.source = "qrc:/images/sjq2.png"
                    pwgtext.font.pixelSize = 17
                    closepath.stop()    //让p双泡消失的计时暂停
                    closepathvis.stop()
                }
                onExited: {
                    pwg.source = "qrc:/images/sjq1.png"
                    pwgtext.font.pixelSize = 15
                    closepath.start()
                    closepathvis.start()
                }
                onPressed: {
                    pwg.source = "qrc:/images/sjq1.png"
                }
                onReleased: {
                    pwg.source = "qrc:/images/sjq2.png"
                    ogCtl.submit_wholePw(); /** Load pathway with all of essential gene, contact with C++ **/
                    webpage.visible = true
                }
            }
        }

        //btn2_2: pathway with meta
        Image {
            id: pwm
            visible: true
            width:  parent.width*0.125//100
            height: parent.width*0.125
            source: "qrc:/images/sjq1.png"
            opacity: 0.0
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.76
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.2
            Text {
                id: pwmtext
                anchors.centerIn: parent
                text: "Meta"
                font.family: "Segoe UI Light"
                font.pixelSize: 15
                font.bold: true
                color: "black"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    pwm.source = "qrc:/images/sjq2.png"
                    pwmtext.font.pixelSize = 17
                    closepath.stop()    //让p双泡消失的计时暂停
                    closepathvis.stop()
                }
                onExited: {
                    pwm.source = "qrc:/images/sjq1.png"
                    pwmtext.font.pixelSize = 15
                    closepath.start()
                    closepathvis.start()
                }
                onPressed: {
                    pwm.source = "qrc:/images/sjq1.png"
                }
                onReleased: {
                    pwm.source = "qrc:/images/sjq2.png"
                    ogCtl.submit_metaPw(); /** Load pathway with essential gene about metabolism only, contact with C++ **/
                    webpage.visible = true
                }
            }
        }

        //btn3----module
        Image {
            property real y3: 0
            id: modulebtn
            width: parent.width*0.2//180
            height: parent.width*0.2
            source: "qrc:/images/sjq1.png"
            opacity: 0.0
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.58
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.47 + y3
            Text {
                id: modulebtntext
                anchors.centerIn: parent
                text: "Module"
                font.family: "Segoe Script"
                font.pixelSize: 20
                font.bold: true
                color: "black"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    modulebtn.source = "qrc:/images/sjq2.png"
                    modulebtntext.font.pixelSize = 26
                    closemodule.stop()     ////让m双泡消失的计时暂停
                    closemodulevis.stop()
                    showmodule.start()     //2泡渐变出现
                    mwg.visible = true
                    mwm.visible = true
                }
                onExited: {
                    modulebtn.source = "qrc:/images/sjq1.png"
                    modulebtntext.font.pixelSize = 20
                    closemodule.start()
                    closemodulevis.start()
                }
                onPressed: {
                    modulebtn.source = "qrc:/images/sjq1.png"
                }
                onReleased: {
                    modulebtn.source = "qrc:/images/sjq2.png"
                    shackmodule.start()
                }
            }
        }

        //btn3_1: module with whole gene
        Image {
            id: mwg
            visible: true
            width: parent.width*0.10625
            height: parent.width*0.10625
            source: "qrc:/images/sjq1.png"
            opacity: 0.0
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.77
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.42
            Text {
                id: mwgtext
                anchors.centerIn: parent
                text: "Gene"
                font.family: "Segoe UI Light"
                font.pixelSize: 15
                font.bold: true
                color: "black"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    mwg.source = "qrc:/images/sjq2.png"
                    mwgtext.font.pixelSize = 17
                    closemodule.stop()    //让m双泡消失的计时暂停
                    closemodulevis.stop()
                }
                onExited: {
                    mwg.source = "qrc:/images/sjq1.png"
                    mwgtext.font.pixelSize = 15
                    closemodule.start()
                    closemodulevis.start()
                }
                onPressed: {
                    mwg.source = "qrc:/images/sjq1.png"
                }
                onReleased: {
                    mwg.source = "qrc:/images/sjq2.png"
                    ogCtl.submit_wholeMd(); /** Load module with all of essential gene, contact with C++ **/
                    webpage.visible = true;
                }
            }
        }

        //btn3_2: module with meta
        Image {
            id: mwm
            visible: true
            width: parent.width*0.125//100
            height: parent.width*0.125
            source: "qrc:/images/sjq1.png"
            opacity: 0.0
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.79
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.57
            Text {
                id: mwmtext
                anchors.centerIn: parent
                text: "Meta"
                font.family: "Segoe UI Light"
                font.pixelSize: 15
                font.bold: true
                color: "black"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    mwm.source = "qrc:/images/sjq2.png"
                    mwmtext.font.pixelSize = 17
                    closemodule.stop()    //让m双泡消失的计时暂停
                    closemodulevis.stop()
                }
                onExited: {
                    mwm.source = "qrc:/images/sjq1.png"
                    mwmtext.font.pixelSize = 15
                    closemodule.start()
                    closemodulevis.start()
                }
                onPressed: {
                    mwm.source = "qrc:/images/sjq1.png"
                }
                onReleased: {
                    mwm.source = "qrc:/images/sjq2.png"
                    ogCtl.submit_metaMd(); /** Load module of essential gene about metabolism only, contact with C++ **/
                    webpage.visible = true;
                }
            }
        }

        //Download button   //下载按钮
        Button {
            id: p2download
            height: 40
            width: 40
            opacity: pressed?0.8:1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.02
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.8-width*0.5
            tooltip: "Download"
            style: ButtonStyle {
                background: Rectangle {
                    radius: 20
                    anchors.fill: parent
                    color: control.hovered ? "#AAAAAA" : "transparent"
                    Image {
                        width: 35
                        height: 35
                        anchors.centerIn: parent
                        source:control.hovered?"qrc:/images/download1.png":"qrc:/images/download.png"
                    }
                }
            }
            onClicked: {
                var url="http://cefg.cn/Igem2015/mccap-server/api/download/cegCSV.php?id="
                var n=select_sp.count
                for(var i=0;i<n;i++)
                    url=url+ogCtl.tran2ID(select_sp.get(i).name)

                Qt.openUrlExternally(url)
            }
        }

        //Return page_1 button  //返回page_1按钮
        Button {
            id: p2return
            height: 40
            width: 40
            opacity: pressed?0.8:1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.02
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.9-width*0.5
            tooltip: "Back"
            style: ButtonStyle {
                background: Rectangle {
                    radius: 20
                    anchors.fill: parent
                    color: control.hovered ? "#AAAAAA" : "transparent"
                    Image {
                        width: 35
                        height: 35
                        anchors.centerIn: parent
                        source:control.hovered?"qrc:/images/back1.png":"qrc:/images/back.png"
                    }
                }
            }
            onClicked: {
                hide3pao.start()
                fudong_p2.stop()
                page_2.visible = false
                page_1.visible = true
            }
        }

        //Home button
        Button {
            id: p2home
            height: 40
            width: 40
            opacity: pressed?0.8:1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.02
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.7-width*0.5
            tooltip: "Home"
            style: ButtonStyle {
                background: Rectangle {
                    radius: 5
                    anchors.fill: parent
                    color: control.hovered ? "#AAAAAA" : "transparent"
                    Image {
                        width: 35
                        height: 35
                        anchors.centerIn: parent
                        source:control.hovered?"qrc:/images/home1.png":"qrc:/images/home.png"
                    }
                }
            }
            onClicked: {
                hide3pao.start()
                fudong_p2.stop()
                page_2.visible = false
                mainpage.visible = true
            }
        }

        //buttons entry animation  //btn123入场动画
        ParallelAnimation {
            id: ruchuang
            //btn1
            PropertyAnimation {
                target:	resultbtn
                properties: "width,height"
                from: 20
                to:	page_2.width*0.25
                duration: 500
            }
            PropertyAnimation {
                target:	resultbtn
                property: "anchors.leftMargin"
                from: page_2.width*0.48
                to:	page_2.width*0.22
                duration: 500
            }
            PropertyAnimation {
                target:	resultbtn
                property: "anchors.topMargin"
                from: page_2.height*0.4
                to:	page_2.height*0.2
                duration: 500
            }
            PropertyAnimation {
                targets: [resultbtn, resultbtntext]
                property: "opacity"
                from: 0.0
                to:	1.0
                duration: 500
            }
            //btn2
            PropertyAnimation {
                target:	pathwaybtn
                properties: "width,height"
                from: 20
                to:	page_2.width*0.23
                duration: 500
            }
            PropertyAnimation {
                target:	pathwaybtn
                property: "anchors.leftMargin"
                from: page_2.width*0.48
                to:	page_2.width*0.55
                duration: 500
            }
            PropertyAnimation {
                target:	pathwaybtn
                property: "anchors.topMargin"
                from: page_2.height*0.4
                to:	page_2.height*0.1
                duration: 500
            }
            PropertyAnimation {
                targets: [pathwaybtn, pathwaybtntext]
                property: "opacity"
                from: 0.0
                to:	1.0
                duration: 500
            }
            //btn3
            PropertyAnimation {
                target:	modulebtn
                properties: "width,height"
                from: 20
                to:	page_2.width*0.2
                duration: 500
            }
            PropertyAnimation {
                target:	modulebtn
                property: "anchors.leftMargin"
                from: page_2.width*0.48
                to:	page_2.width*0.58
                duration: 500
            }
            PropertyAnimation {
                target:	modulebtn
                property: "anchors.topMargin"
                from: page_2.height*0.4
                to:	page_2.height*0.47
                duration: 500
            }
            PropertyAnimation {
                targets: [modulebtn, modulebtntext]
                property: "opacity"
                from: 0.0
                to:	1.0
                duration: 500
            }

            //res1
            PropertyAnimation {
                target:	res1
                properties: "width,height"
                from: 0
                to:	page_2.width*0.225//180
                duration: 300
            }
            PropertyAnimation {
                target:	res1
                property: "anchors.leftMargin"
                from: page_2.width*0.35
                to:	page_2.width*0.12
                duration: 300
            }
            PropertyAnimation {
                target:	res1
                property: "anchors.topMargin"
                from: page_2.height*0.4
                to:	page_2.height*0.55
                duration: 300
            }
            //res2
            PropertyAnimation {
                target:	res2
                properties: "width,height"
                from: 0
                to:	page_2.width*0.15625
                duration: 300
            }
            PropertyAnimation {
                target:	res2
                property: "anchors.leftMargin"
                from: page_2.width*0.35
                to:	page_2.width*0.13
                duration: 300
            }
            PropertyAnimation {
                target:	res2
                property: "anchors.topMargin"
                from: page_2.height*0.4
                to:	page_2.height*0.11
                duration: 300
            }
            //res3
            PropertyAnimation {
                target:	res3
                properties: "width,height"
                from: 0
                to:	page_2.width*0.19375
                duration: 300
            }
            PropertyAnimation {
                target:	res3
                property: "anchors.leftMargin"
                from: page_2.width*0.35
                to:	page_2.width*0.06
                duration: 300
            }
            PropertyAnimation {
                target:	res3
                property: "anchors.topMargin"
                from: page_2.height*0.4
                to:	page_2.height*0.32
                duration: 300
            }
            //res4
            PropertyAnimation {
                target:	res4
                properties: "width,height"
                from: 0
                to:	page_2.width*0.125
                duration: 300
            }
            PropertyAnimation {
                target:	res4
                property: "anchors.leftMargin"
                from: page_2.width*0.35
                to:	page_2.width*0.26
                duration: 300
            }
            PropertyAnimation {
                target:	res4
                property: "anchors.topMargin"
                from: page_2.height*0.4
                to:	page_2.height*0.03
                duration: 300
            }

            //pwg
            PropertyAnimation {
                target:	pwg
                properties: "width,height"
                from: 0
                to:	page_2.width*0.10625
                duration: 300
            }
            PropertyAnimation {
                target:	pwg
                property: "anchors.leftMargin"
                from: page_2.width*0.65
                to:	page_2.width*0.74
                duration: 300
            }
            PropertyAnimation {
                target:	pwg
                property: "anchors.topMargin"
                from: page_2.height*0.25
                to:	page_2.height*0.06
                duration: 300
            }
            //pwm
            PropertyAnimation {
                target:	pwm
                properties: "width,height"
                from: 0
                to:	page_2.width*0.125
                duration: 300
            }
            PropertyAnimation {
                target:	pwm
                property: "anchors.leftMargin"
                from: page_2.width*0.65
                to:	page_2.width*0.76
                duration: 300
            }
            PropertyAnimation {
                target:	pwm
                property: "anchors.topMargin"
                from: page_2.height*0.25
                to:	page_2.height*0.2
                duration: 300
            }
            //mwg
            PropertyAnimation {
                target:	mwg
                properties: "width,height"
                from: 0
                to:	page_2.width*0.10625
                duration: 300
            }
            PropertyAnimation {
                target:	mwg
                property: "anchors.leftMargin"
                from: page_2.width*0.65
                to:	page_2.width*0.77
                duration: 300
            }
            PropertyAnimation {
                target:	mwg
                property: "anchors.topMargin"
                from: page_2.height*0.5
                to:	page_2.height*0.42
                duration: 300
            }
            //mwm
            PropertyAnimation {
                target:	mwm
                properties: "width,height"
                from: 0
                to:	page_2.width*0.125
                duration: 300
            }
            PropertyAnimation {
                target:	mwm
                property: "anchors.leftMargin"
                from: page_2.width*0.65
                to:	page_2.width*0.79
                duration: 300
            }
            PropertyAnimation {
                target:	mwm
                property: "anchors.topMargin"
                from: page_2.height*0.5
                to:	page_2.height*0.57
                duration: 300
            }
        }

        //buttons flow animation    //3泡浮动效果
        ParallelAnimation {
            id: fudong_p2
            //btn1
            SequentialAnimation {
                NumberAnimation {
                    target: resultbtn
                    property: "y1"
                    from: 0
                    to: 6
                    easing.type: Easing.InOutQuad
                    duration: 1500
                }
                NumberAnimation {
                    target: resultbtn
                    property: "y1"
                    to: 0
                    easing.type: Easing.InOutQuad
                    duration: 1500
                }
            }
            //btn2
            SequentialAnimation {
                NumberAnimation {
                    target: pathwaybtn
                    property: "y2"
                    from: 0
                    to: -6
                    easing.type: Easing.InOutQuad
                    duration: 1500
                }
                NumberAnimation {
                    target: pathwaybtn
                    property: "y2"
                    to: 0
                    easing.type: Easing.InOutQuad
                    duration: 1500
                }
            }
            //btn3
            SequentialAnimation {
                NumberAnimation {
                    target: modulebtn
                    property: "y3"
                    from: 0
                    to: 6
                    easing.type: Easing.InOutQuad
                    duration: 1500
                }
                NumberAnimation {
                    target: modulebtn
                    property: "y3"
                    to: 0
                    easing.type: Easing.InOutQuad
                    duration: 1500
                }
            }
            loops: Animation.Infinite
        }

        //buttons dilution effect  //btn123淡化效果
        ParallelAnimation {
            id: hide3pao
            PropertyAnimation {
                targets: [resultbtn, pathwaybtn, modulebtn]
                property: "opacity"
                to:	0.0
                duration: 200
            }
        }

        //buttons gradient appears effect   //btn123强化效果
        ParallelAnimation {
            id: show3pao
            PropertyAnimation {
                targets: [resultbtn, pathwaybtn, modulebtn]
                property: "opacity"
                to:	1.0
                duration: 200
            }
        }

        //btn1x dilution effect   //btn1子泡泡淡化效果
        ParallelAnimation {
            id: hideres
            PropertyAnimation {
                targets: [res1, res2, res3, res4]
                property: "opacity"
                to:	0.0
                duration: 200
            }
        }

        //btn1x gradient appears effect   //btn1子泡泡强化效果
        ParallelAnimation {
            id: showres
            PropertyAnimation {
                targets: [res1, res2, res3, res4]
                property: "opacity"
                to:	1.0
                duration: 300
            }
        }

        //btn1x jitter effect   //btn1子泡泡颤抖效果
        SequentialAnimation	{
            id: shackres
            ParallelAnimation {
                //res1
                PropertyAnimation {
                    target:	res1
                    property: "anchors.leftMargin"
                    from: page_2.width*0.12
                    to: page_2.width*0.11
                    duration: 200
                }
                PropertyAnimation {
                    target:	res1
                    property: "anchors.topMargin"
                    from: page_2.height*0.55
                    to: page_2.height*0.56
                    duration: 200
                }
                //res2
                PropertyAnimation {
                    target:	res2
                    property: "anchors.leftMargin"
                    from: page_2.width*0.13
                    to: page_2.width*0.12
                    duration: 200
                }
                PropertyAnimation {
                    target:	res2
                    property: "anchors.topMargin"
                    from: page_2.height*0.11
                    to: page_2.height*0.1
                    duration: 200
                }
                //res3
                PropertyAnimation {
                    target:	res3
                    property: "anchors.leftMargin"
                    from: page_2.width*0.06
                    to: page_2.width*0.05
                    duration: 200
                }
                PropertyAnimation {
                    target:	res3
                    property: "anchors.topMargin"
                    from: page_2.height*0.32
                    to: page_2.height*0.325
                    duration: 200
                }
                //res4
                PropertyAnimation {
                    target:	res4
                    property: "anchors.leftMargin"
                    from: page_2.width*0.26
                    to: page_2.width*0.255
                    duration: 200
                }
                PropertyAnimation {
                    target:	res4
                    property: "anchors.topMargin"
                    from: page_2.height*0.03
                    to: page_2.height*0.02
                    duration: 200
                }
            }
            ParallelAnimation {
                //res1
                PropertyAnimation {
                    target:	res1
                    property: "anchors.leftMargin"
                    easing.type: Easing.InOutCubic
                    to: page_2.width*0.13
                    duration: 300
                }
                PropertyAnimation {
                    target:	res1
                    property: "anchors.topMargin"
                    easing.type: Easing.InOutCubic
                    to: page_2.height*0.54
                    duration: 300
                }
                //res2
                PropertyAnimation {
                    target:	res2
                    property: "anchors.leftMargin"
                    easing.type: Easing.InOutCubic
                    to: page_2.width*0.14
                    duration: 300
                }
                PropertyAnimation {
                    target:	res2
                    property: "anchors.topMargin"
                    easing.type: Easing.InOutCubic
                    to: page_2.height*0.12
                    duration: 300
                }
                //res3
                PropertyAnimation {
                    target:	res3
                    property: "anchors.leftMargin"
                    easing.type: Easing.InOutCubic
                    to: page_2.width*0.07
                    duration: 300
                }
                PropertyAnimation {
                    target:	res3
                    property: "anchors.topMargin"
                    easing.type: Easing.InOutCubic
                    to: page_2.height*0.315
                    duration: 300
                }
                //res4
                PropertyAnimation {
                    target:	res4
                    property: "anchors.leftMargin"
                    easing.type: Easing.InOutCubic
                    to: page_2.width*0.265
                    duration: 300
                }
                PropertyAnimation {
                    target:	res4
                    property: "anchors.topMargin"
                    easing.type: Easing.InOutCubic
                    to: page_2.height*0.04
                    duration: 300
                }
            }
            ParallelAnimation {
                //res1
                PropertyAnimation {
                    target:	res1
                    property: "anchors.leftMargin"
                    easing.type: Easing.InOutQuad
                    to: page_2.width*0.12
                    duration: 150
                }
                PropertyAnimation {
                    target:	res1
                    property: "anchors.topMargin"
                    easing.type: Easing.InOutQuad
                    to: page_2.height*0.55
                    duration: 150
                }
                //res2
                PropertyAnimation {
                    target:	res2
                    property: "anchors.leftMargin"
                    easing.type: Easing.InOutQuad
                    to: page_2.width*0.13
                    duration: 150
                }
                PropertyAnimation {
                    target:	res2
                    property: "anchors.topMargin"
                    easing.type: Easing.InOutQuad
                    to: page_2.height*0.11
                    duration: 150
                }
                //res3
                PropertyAnimation {
                    target:	res3
                    property: "anchors.leftMargin"
                    easing.type: Easing.InOutQuad
                    to: page_2.width*0.06
                    duration: 150
                }
                PropertyAnimation {
                    target:	res3
                    property: "anchors.topMargin"
                    easing.type: Easing.InOutQuad
                    to: page_2.height*0.32
                    duration: 150
                }
                //res4
                PropertyAnimation {
                    target:	res4
                    property: "anchors.leftMargin"
                    easing.type: Easing.InOutQuad
                    to: page_2.width*0.26
                    duration: 150
                }
                PropertyAnimation {
                    target:	res4
                    property: "anchors.topMargin"
                    easing.type: Easing.InOutQuad
                    to: page_2.height*0.03
                    duration: 150
                }
            }
        }

        //btn2x dilution effect   //btn2子泡泡淡化效果
        ParallelAnimation {
            id: hidepath
            PropertyAnimation {
                targets: [pwg, pwm]
                property: "opacity"
                to:	0.0
                duration: 200
            }
        }

        //btn2x gradient appears effect   //btn2子泡泡强化效果
        ParallelAnimation {
            id: showpath
            PropertyAnimation {
                targets: [pwg, pwm]
                property: "opacity"
                to:	1.0
                duration: 200
            }
        }

        //btn2x jitter effect   //btn2子泡泡颤抖效果
        SequentialAnimation	{
            id: shackpath
            ParallelAnimation {
                //pwg
                PropertyAnimation {
                    target:	pwg
                    property: "anchors.leftMargin"
                    from: page_2.width*0.74
                    to: page_2.width*0.75
                    duration: 200
                }
                PropertyAnimation {
                    target:	pwg
                    property: "anchors.topMargin"
                    from: page_2.height*0.06
                    to: page_2.height*0.055
                    duration: 200
                }
                //pwm
                PropertyAnimation {
                    target:	pwm
                    property: "anchors.leftMargin"
                    from: page_2.width*0.76
                    to: page_2.width*0.77
                    duration: 200
                }
                PropertyAnimation {
                    target:	pwm
                    property: "anchors.topMargin"
                    from: page_2.height*0.2
                    to: page_2.height*0.202
                    duration: 200
                }
            }
            ParallelAnimation {
                //pwg
                PropertyAnimation {
                    target:	pwg
                    property: "anchors.leftMargin"
                    to: page_2.width*0.735
                    duration: 200
                }
                PropertyAnimation {
                    target:	pwg
                    property: "anchors.topMargin"
                    to: page_2.height*0.065
                    duration: 200
                }
                //pwm
                PropertyAnimation {
                    target:	pwm
                    property: "anchors.leftMargin"
                    to: page_2.width*0.755
                    duration: 200
                }
                PropertyAnimation {
                    target:	pwm
                    property: "anchors.topMargin"
                    to: page_2.height*0.198
                    duration: 200
                }
            }
            ParallelAnimation {
                //pwg
                PropertyAnimation {
                    target:	pwg
                    property: "anchors.leftMargin"
                    to: page_2.width*0.74
                    duration: 200
                }
                PropertyAnimation {
                    target:	pwg
                    property: "anchors.topMargin"
                    to: page_2.height*0.06
                    duration: 200
                }
                //pwm
                PropertyAnimation {
                    target:	pwm
                    property: "anchors.leftMargin"
                    to: page_2.width*0.76
                    duration: 200
                }
                PropertyAnimation {
                    target:	pwm
                    property: "anchors.topMargin"
                    to: page_2.height*0.2
                    duration: 200
                }
            }
        }

        //btn3x dilution effect   //btn3子泡泡淡化效果
        ParallelAnimation {
            id: hidemodule
            PropertyAnimation {
                targets: [mwg, mwm]
                property: "opacity"
                to:	0.0
                duration: 200
            }
        }

        //btn3x gradient appears effect   //btn3子泡泡强化效果
        ParallelAnimation {
            id: showmodule
            PropertyAnimation {
                targets: [mwg, mwm]
                property: "opacity"
                to:	1.0
                duration: 200
            }
        }

        //btn3x jitter effect   //btn3子泡泡颤抖效果
        SequentialAnimation	{
            id: shackmodule
            ParallelAnimation {
                //mwg
                PropertyAnimation {
                    target:	mwg
                    property: "anchors.leftMargin"
                    from: page_2.width*0.77
                    to: page_2.width*0.78
                    duration: 200
                }
                PropertyAnimation {
                    target:	mwg
                    property: "anchors.topMargin"
                    from: page_2.height*0.42
                    to: page_2.height*0.415
                    duration: 200
                }
                //mwm
                PropertyAnimation {
                    target:	mwm
                    property: "anchors.leftMargin"
                    from: page_2.width*0.79
                    to: page_2.width*0.8
                    duration: 200
                }
                PropertyAnimation {
                    target:	mwm
                    property: "anchors.topMargin"
                    from: page_2.height*0.57
                    to: page_2.height*0.574
                    duration: 200
                }
            }
            ParallelAnimation {
                //mwg
                PropertyAnimation {
                    target:	mwg
                    property: "anchors.leftMargin"
                    to: page_2.width*0.765
                    duration: 200
                }
                PropertyAnimation {
                    target:	mwg
                    property: "anchors.topMargin"
                    to: page_2.height*0.425
                    duration: 200
                }
                //mwm
                PropertyAnimation {
                    target:	mwm
                    property: "anchors.leftMargin"
                    to: page_2.width*0.785
                    duration: 200
                }
                PropertyAnimation {
                    target:	mwm
                    property: "anchors.topMargin"
                    to: page_2.height*0.568
                    duration: 200
                }
            }
            ParallelAnimation {
                //mwg
                PropertyAnimation {
                    target:	mwg
                    property: "anchors.leftMargin"
                    to: page_2.width*0.77
                    duration: 200
                }
                PropertyAnimation {
                    target:	mwg
                    property: "anchors.topMargin"
                    to: page_2.height*0.42
                    duration: 200
                }
                //mwm
                PropertyAnimation {
                    target:	mwm
                    property: "anchors.leftMargin"
                    to: page_2.width*0.79
                    duration: 200
                }
                PropertyAnimation {
                    target:	mwm
                    property: "anchors.topMargin"
                    to: page_2.height*0.57
                    duration: 200
                }
            }
        }

        //btn1x disappear  //result区按钮计时消失(动画)
        Timer {
            id: closeres
            interval: 800
            onTriggered: {
                hideres.start()
            }
            repeat: false
        }

        //btn1x disappear   //result区按钮计时消失(visiable)
        Timer {
            id: closeresvis
            interval: closeres.interval + 200
            onTriggered: {
                res1.visible = false
                res2.visible = false
                res3.visible = false
                res4.visible = false
            }
            repeat: false
        }

        //btn2x disappear   //pathway区按钮计时消失（动画）
        Timer {
            id: closepath
            interval: 300
            onTriggered: {
                hidepath.start()
            }
            repeat: false
        }

        //btn2x disappear   //pathway区按钮计时消失（visiable）
        Timer {
            id: closepathvis
            interval: closepath.interval + 200
            onTriggered: {
                pwg.visible = false
                pwm.visible = false
            }
            repeat: false
        }

        //btn3x disappear   //module区按钮计时消失(动画)
        Timer {
            id: closemodule
            interval: 300
            onTriggered: {
                hidemodule.start()
            }
            repeat: false
        }

        //btn3x disappear   //module区按钮计时消失(visiable)
        Timer {
            id: closemodulevis
            interval: closemodule.interval + 200
            onTriggered: {
                mwg.visible = false
                mwm.visible = false
            }
            repeat: false
        }

        //start flow until admission animation stop     //等待3泡入场后再浮动
        Timer {
            id: wait3pao
            interval: 500
            onTriggered: {
                fudong_p2.start()
            }
            repeat: false
        }

        //btn1x goto left (while res1 clicked)      //btn1_x滚去左侧(res1选中)
        ParallelAnimation {
            id: res1toleft
            //res2-4
            PropertyAnimation {
                targets: [res2, res3, res4]
                properties: "width,height"
                to:	page_2.height*0.3
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                targets: [res2, res3, res4]
                property: "anchors.leftMargin"
                to:	page_2.width*0.01
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                targets: [res2text, res3text, res4text]
                properties: "color"
                to:	"black"
            }
            //res1
            PropertyAnimation {
                target: res1
                properties: "width,height"
                to:	page_2.height*0.38
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                target: res1
                property: "anchors.leftMargin"
                to:	-page_2.width*0.01
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                target:	res1
                property: "anchors.topMargin"
                to:	page_2.height*0.67
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                target: res1text
                properties: "color"
                to:	"red"
            }
            //res2
            PropertyAnimation {
                target:	res2
                property: "anchors.topMargin"
                to:	page_2.height*0.22
                easing.type: Easing.OutQuad
                duration: 400
            }
            //res3
            PropertyAnimation {
                target:	res3
                property: "anchors.topMargin"
                to:	page_2.height*0.45
                easing.type: Easing.OutQuad
                duration: 400
            }
            //res4
            PropertyAnimation {
                target:	res4
                property: "anchors.topMargin"
                to:	-page_2.height*0.01
                easing.type: Easing.OutQuad
                duration: 400
            }
        }

        //btn1x goto left (while res2 clicked)      //btn1_x滚去左侧(res2选中)
        ParallelAnimation {
            id: res2toleft
            //res1,3,4
            PropertyAnimation {
                targets: [res1, res3, res4]
                properties: "width,height"
                to:	page_2.height*0.3
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                targets: [res1, res3, res4]
                property: "anchors.leftMargin"
                to:	page_2.width*0.01
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                targets: [res1text, res3text, res4text]
                properties: "color"
                to:	"black"
            }
            //res1
            PropertyAnimation {
                target:	res1
                property: "anchors.topMargin"
                to:	page_2.height*0.73
                easing.type: Easing.OutQuad
                duration: 400
            }
            //res2
            PropertyAnimation {
                target: res2
                properties: "width,height"
                to:	page_2.height*0.38
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                target: res2
                property: "anchors.leftMargin"
                to:	-page_2.width*0.01
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                target:	res2
                property: "anchors.topMargin"
                to:	page_2.height*0.21
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                target: res2text
                properties: "color"
                to:	"red"
            }
            //res3
            PropertyAnimation {
                target:	res3
                property: "anchors.topMargin"
                to:	page_2.height*0.5
                easing.type: Easing.OutQuad
                duration: 400
            }
            //res4
            PropertyAnimation {
                target:	res4
                property: "anchors.topMargin"
                to:	-page_2.height*0.01
                easing.type: Easing.OutQuad
                duration: 400
            }
        }

        //btn1x goto left (while res3 clicked)      //btn1_x滚去左侧(res3选中)
        ParallelAnimation {
            id: res3toleft
            //res1,2,4
            PropertyAnimation {
                targets: [res1, res2, res4]
                properties: "width,height"
                to:	page_2.height*0.3
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                targets: [res1, res2, res4]
                property: "anchors.leftMargin"
                to:	page_2.width*0.01
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                targets: [res1text, res2text, res4text]
                properties: "color"
                to:	"black"
            }
            //res1
            PropertyAnimation {
                target:	res1
                property: "anchors.topMargin"
                to:	page_2.height*0.73
                easing.type: Easing.OutQuad
                duration: 400
            }
            //res2
            PropertyAnimation {
                target:	res2
                property: "anchors.topMargin"
                to:	page_2.height*0.22
                easing.type: Easing.OutQuad
                duration: 400
            }
            //res3
            PropertyAnimation {
                target: res3
                properties: "width,height"
                to:	page_2.height*0.38
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                target: res3
                property: "anchors.leftMargin"
                to:	-page_2.width*0.01
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                target:	res3
                property: "anchors.topMargin"
                to:	page_2.height*0.44
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                target: res3text
                properties: "color"
                to:	"red"
            }
            //res4
            PropertyAnimation {
                target:	res4
                property: "anchors.topMargin"
                to:	-page_2.height*0.01
                easing.type: Easing.OutQuad
                duration: 400
            }
        }

        //btn1x goto left (while res4 clicked)      //btn1_x滚去左侧(res4选中)
        ParallelAnimation {
            id: res4toleft
            //res1,2,3
            PropertyAnimation {
                targets: [res1, res2, res3]
                properties: "width,height"
                to:	page_2.height*0.3
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                targets: [res1, res2, res3]
                property: "anchors.leftMargin"
                to:	page_2.width*0.01
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                targets: [res1text, res2text, res3text]
                properties: "color"
                to:	"black"
            }
            //res1
            PropertyAnimation {
                target:	res1
                property: "anchors.topMargin"
                to:	page_2.height*0.73
                easing.type: Easing.OutQuad
                duration: 400
            }
            //res2
            PropertyAnimation {
                target:	res2
                property: "anchors.topMargin"
                to:	page_2.height*0.27
                easing.type: Easing.OutQuad
                duration: 400
            }
            //res3
            PropertyAnimation {
                target:	res3
                property: "anchors.topMargin"
                to:	page_2.height*0.5
                easing.type: Easing.OutQuad
                duration: 400
            }
            //res4
            PropertyAnimation {
                target: res4
                properties: "width,height"
                to:	page_2.height*0.38
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                target: res4
                property: "anchors.leftMargin"
                to:	-page_2.width*0.01
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                target:	res4
                property: "anchors.topMargin"
                to:	-page_2.height*0.015
                easing.type: Easing.OutQuad
                duration: 400
            }
            PropertyAnimation {
                target: res4text
                properties: "color"
                to:	"red"
            }
        }

        //btn1x return to initial position      //btn1_x由左侧回到原位置
        ParallelAnimation {
            id: resgoback
            //res1-4
            PropertyAnimation {
                targets: [res1, res2, res3, res4]
                property: "opacity"
                to:	0.0
                duration: 0
            }
            PropertyAnimation {
                targets: [res1text, res2text, res3text, res4text]
                properties: "color"
                to:	"black"
            }
            //res1
            PropertyAnimation {
                target:	res1
                properties: "width,height"
                to:	page_2.width*0.225//180
                duration: 0
            }
            PropertyAnimation {
                target:	res1
                property: "anchors.leftMargin"
                to:	page_2.width*0.12
                duration: 0
            }
            PropertyAnimation {
                target:	res1
                property: "anchors.topMargin"
                to:	page_2.height*0.55
                duration: 0
            }
            //res2
            PropertyAnimation {
                target:	res2
                properties: "width,height"
                to:	page_2.width*0.15625//125
                duration: 0
            }
            PropertyAnimation {
                target:	res2
                property: "anchors.leftMargin"
                to:	page_2.width*0.13
                duration: 0
            }
            PropertyAnimation {
                target:	res2
                property: "anchors.topMargin"
                to:	page_2.height*0.11
                duration: 0
            }
            //res3
            PropertyAnimation {
                target:	res3
                properties: "width,height"
                to:	page_2.width*0.19375//155
                duration: 0
            }
            PropertyAnimation {
                target:	res3
                property: "anchors.leftMargin"
                to:	page_2.width*0.06
                duration: 0
            }
            PropertyAnimation {
                target:	res3
                property: "anchors.topMargin"
                to:	page_2.height*0.32
                duration: 0
            }
            //res4
            PropertyAnimation {
                target:	res4
                properties: "width,height"
                to:	page_2.width*0.125//100
                duration: 0
            }
            PropertyAnimation {
                target:	res4
                property: "anchors.leftMargin"
                to:	page_2.width*0.26
                duration: 0
            }
            PropertyAnimation {
                target:	res4
                property: "anchors.topMargin"
                to:	page_2.height*0.03
                duration: 0
            }
        }

        //Animation of showing popup1    //弹窗1出场
        ParallelAnimation {
            id: showtanchuang1
            PropertyAnimation {
                 target: tanchuang1
                 property: "anchors.leftMargin"
                 easing.type: Easing.OutBack
                 to: page_2.width*0.15
                 duration: 400
            }
        }

        //Animation of showing popup2    //弹窗2出场
        ParallelAnimation {
            id: showtanchuang2
            PropertyAnimation {
                 target: tanchuang2
                 property: "anchors.leftMargin"
                 easing.type: Easing.OutBack
                 to: page_2.width*0.15
                 duration: 400
            }
        }

        //Animation of showing popup3    //弹窗3出场
        ParallelAnimation {
            id: showtanchuang3
            PropertyAnimation {
                 target: tanchuang3
                 property: "anchors.leftMargin"
                 easing.type: Easing.OutBack
                 to: page_2.width*0.15
                 duration: 400
            }
        }

        //Animation of showing popup4    //弹窗4出场
        ParallelAnimation {
            id: showtanchuang4
            PropertyAnimation {
                 target: tanchuang4
                 property: "anchors.leftMargin"
                 easing.type: Easing.OutBack
                 to: page_2.width*0.15
                 duration: 400
            }
        }

        //popup1    //弹窗1
        Item {
            id: tanchuang1
            visible: false
            opacity: 0.98
            anchors.left: parent.left
            anchors.leftMargin: parent.width
            anchors.top: parent.top
            width: parent.width*0.875
            height: parent.height
            focus: true

            //title + list
            Image {
                id: listsquare1
                anchors.fill: parent
                source: "qrc:/images/glass4.png"
            }

            //left title    //左标题 Gene名称
            Rectangle {
                id: leftgenetitle1
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.05
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.07
                width: parent.width*0.26
                height: parent.height*0.11
                color: "transparent"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("   Cluster of\nEssential Gene")
                    font.family: "Segoe UI"
                    font.bold: true
                    color: "black"
                    font.pixelSize: 22
                }
            }

            //right title   //右标题 Description
            Rectangle {
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.03
                anchors.left: leftgenetitle1.right
                anchors.leftMargin: 0
                width: parent.width*0.88 - leftgenetitle1.width
                height: parent.height*0.13
                color: "transparent"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Description")
                    font.family: "Segoe UI"
                    font.bold: true
                    color: "black"
                    font.pixelSize: 27
                }
            }

            //list
            ListView {
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.12
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.16
                width: parent.width*0.8
                height: parent.height*0.66
                clip: true
                model: list1

                ListModel {
                    id: list1
                }
                delegate: Item {
                    width: parent.width
                    height: 40
                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                        Text {
                            id: list1text
                            anchors.leftMargin: 10
                            anchors.left: parent.left
                            text: name + "            " + description
                            color: "black"
                            font.pixelSize: 20
                            font.family: "Segoe UI"
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            list1text.font.pixelSize = 21
                        }
                        onExited: {
                            list1text.font.pixelSize = 20
                        }
                        onPressed: {
                            list1text.color = "red"
                        }
                        onReleased: {
                            list1text.color = "black"
                            console.log(list1.get(index).name)
                            var accessNum = list1.get(index).name
                            mainCtl.openClusterDetail(accessNum)
                            webpage.visible = true;
                        }
                    }
                }
            }

            //close popup1 button  //关闭弹窗1按钮
            Button {
                height: 40
                width: 40
                opacity: pressed?0.8:1
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height*0.018
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.9-width*0.5
                tooltip: "Back"
                style: ButtonStyle {
                    background: Rectangle {
                        radius: 20
                        anchors.fill: parent
                        color: control.hovered ? "#AAAAAA" : "transparent"
                        Image {
                            width: 35
                            height: 35
                            anchors.centerIn: parent
                            source: control.hovered ? "qrc:/images/back1.png" : "qrc:/images/back.png"
                        }
                    }
                }
                onClicked: {
                    tanchuang1_leave.start()
                    resgoback.start()
                    vanishflag = 0
                    show3pao.start()
                    p2background.source = "qrc:/images/background_3.png"
                    resultbtn.visible = true
                    pathwaybtn.visible = true
                    modulebtn.visible = true
                    p2download.visible = true
                    p2return.visible = true
                    p2home.visible = true
                }
            }


            //消失于右侧
            PropertyAnimation {
                id: tanchuang1_leave
                target: tanchuang1
                property: "anchors.leftMargin"
                easing.type: Easing.OutCubic
                to: page_2.width
                duration: 500
            }
        }

        //popup2    //弹窗2
        Item {
            id: tanchuang2
            visible: false
            opacity: 0.98
            anchors.left: parent.left
            anchors.leftMargin: parent.width
            anchors.top: parent.top
            width: parent.width*0.875
            height: parent.height

            //title + list
            Image {
                id: listsquare2
                anchors.fill: parent
                source: "qrc:/images/glass4.png"
            }

            //左标题 Gene名称
            Rectangle {
                id: leftgenetitle2
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.05
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.07
                width: parent.width*0.26
                height: parent.height*0.11
                color: "transparent"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("   Cluster of\nEssential Gene")
                    font.family: "Segoe UI"
                    font.bold: true
                    color: "black"
                    font.pixelSize: 22
                }
            }

            //右标题 Description
            Rectangle {
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.03
                anchors.left: leftgenetitle2.right
                anchors.leftMargin: 0
                width: parent.width*0.88 - leftgenetitle2.width
                height: parent.height*0.13
                color: "transparent"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Description")
                    font.family: "Segoe UI"
                    font.bold: true
                    color: "black"
                    font.pixelSize: 27
                }
            }

            //list表
            ListView {
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.12
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.16
                width: parent.width*0.8
                height: parent.height*0.66
                clip: true
                model: list2

                ListModel{
                    id: list2
                }
                delegate: Item {
                    width: parent.width
                    height: 40
                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                        Text {
                            id: list2text
                            anchors.leftMargin: 10
                            anchors.left: parent.left
                            text: name + "            " + description
                            color: "black"
                            font.pixelSize: 20
                            font.family: "Segoe UI"
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            list2text.font.pixelSize = 21
                        }
                        onExited: {
                            list2text.font.pixelSize = 20
                        }
                        onPressed: {
                            list2text.color = "red"
                        }
                        onReleased: {
                            list2text.color = "black"
                            console.log(list2.get(index).name)
                            var accessNum = list2.get(index).name
                            mainCtl.openClusterDetail(accessNum)
                            webpage.visible = true;
                        }
                    }
                }
            }

            //close popup2 button  //关闭弹窗2按钮
            Button {
                height: 40
                width: 40
                opacity: pressed?0.8:1
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height*0.018
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.9-width*0.5
                tooltip: "Back"
                style: ButtonStyle {
                    background: Rectangle {
                        radius: 20
                        anchors.fill: parent
                        color: control.hovered ? "#AAAAAA" : "transparent"
                        Image {
                            width: 35
                            height: 35
                            anchors.centerIn: parent
                            source: control.hovered ? "qrc:/images/back1.png" : "qrc:/images/back.png"
                        }
                    }
                }
                onClicked: {
                    tanchuang2_leave.start()
                    resgoback.start()
                    vanishflag = 0
                    show3pao.start()
                    p2background.source = "qrc:/images/background_3.png"
                    resultbtn.visible = true
                    pathwaybtn.visible = true
                    modulebtn.visible = true
                    p2download.visible = true
                    p2return.visible = true
                    p2home.visible = true
                }
            }


            PropertyAnimation {
                id: tanchuang2_leave
                target: tanchuang2
                property: "anchors.leftMargin"
                easing.type: Easing.OutCubic
                to: page_2.width
                duration: 500
            }
        }

        //popup3    //弹窗3
        Item {
            id: tanchuang3
            visible: false
            opacity: 0.98
            anchors.left: parent.left
            anchors.leftMargin: parent.width
            anchors.top: parent.top
            width: parent.width*0.875
            height: parent.height

            //title + list
            Image {
                id: listsquare3
                anchors.fill: parent
                source: "qrc:/images/glass4.png"
            }

            //左标题 Gene名称
            Rectangle {
                id: leftgenetitle3
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.05
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.07
                width: parent.width*0.26
                height: parent.height*0.11
                color: "transparent"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("   Cluster of\nEssential Gene")
                    font.family: "Segoe UI"
                    font.bold: true
                    color: "black"
                    font.pixelSize: 22
                }
            }

            //右标题 Description
            Rectangle {
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.03
                anchors.left: leftgenetitle3.right
                anchors.leftMargin: 0
                width: parent.width*0.88 - leftgenetitle3.width
                height: parent.height*0.13
                color: "transparent"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Description")
                    font.family: "Segoe UI"
                    font.bold: true
                    color: "black"
                    font.pixelSize: 27
                }
            }

            //list表
            ListView {
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.12
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.16
                width: parent.width*0.8
                height: parent.height*0.66
                clip: true
                model: list3

                ListModel{
                    id: list3
                }
                delegate: Item {
                    width: parent.width
                    height: 40
                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                        Text {
                            id: list3text
                            anchors.leftMargin: 10
                            anchors.left: parent.left
                            text: name + "            " + description
                            color: "black"
                            font.pixelSize: 20
                            font.family: "Segoe UI"
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            list3text.font.pixelSize = 21
                        }
                        onExited: {
                            list3text.font.pixelSize = 20
                        }
                        onPressed: {
                            list3text.color = "red"
                        }
                        onReleased: {
                            list3text.color = "black"
                            console.log(list3.get(index).name)
                            var accessNum = list3.get(index).name
                            mainCtl.openClusterDetail(accessNum)
                            webpage.visible = true;
                        }
                    }
                }
            }

            //close popup3 button  //关闭弹窗3按钮
            Button {
                height: 40
                width: 40
                opacity: pressed?0.8:1
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height*0.018
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.9-width*0.5
                tooltip: "Back"
                style: ButtonStyle {
                    background: Rectangle {
                        radius: 20
                        anchors.fill: parent
                        color: control.hovered ? "#AAAAAA" : "transparent"
                        Image {
                            width: 35
                            height: 35
                            anchors.centerIn: parent
                            source: control.hovered ? "qrc:/images/back1.png" : "qrc:/images/back.png"
                        }
                    }
                }
                onClicked: {
                    tanchuang3_leave.start()
                    resgoback.start()
                    vanishflag = 0
                    show3pao.start()
                    p2background.source = "qrc:/images/background_3.png"
                    resultbtn.visible = true
                    pathwaybtn.visible = true
                    modulebtn.visible = true
                    p2download.visible = true
                    p2return.visible = true
                    p2home.visible = true
                }
            }


            PropertyAnimation {
                id: tanchuang3_leave
                target: tanchuang3
                property: "anchors.leftMargin"
                easing.type: Easing.OutCubic
                to: page_2.width
                duration: 500
            }
        }

        //popup4    //弹窗4
        Item {
            id: tanchuang4
            visible: false
            opacity: 0.98
            anchors.left: parent.left
            anchors.leftMargin: parent.width
            anchors.top: parent.top
            width: parent.width*0.875
            height: parent.height

            //title + list
            Image {
                id: listsquare4
                anchors.fill: parent
                source: "qrc:/images/glass4.png"
            }

            //左标题 Gene名称
            Rectangle {
                id: leftgenetitle4
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.05
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.07
                width: parent.width*0.26
                height: parent.height*0.11
                color: "transparent"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("   Cluster of\nEssential Gene")
                    font.family: "Segoe UI"
                    font.bold: true
                    color: "black"
                    font.pixelSize: 22
                }
            }

            //右标题 Description
            Rectangle {
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.03
                anchors.left: leftgenetitle4.right
                anchors.leftMargin: 0
                width: parent.width*0.88 - leftgenetitle4.width
                height: parent.height*0.13
                color: "transparent"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Description")
                    font.family: "Segoe UI"
                    font.bold: true
                    color: "black"
                    font.pixelSize: 27
                }
            }
            //list表
            ListView {
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.12
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.16
                width: parent.width*0.8
                height: parent.height*0.66
                clip: true
                model: list4

                ListModel{
                    id: list4
                }
                delegate: Item {
                    width: parent.width
                    height: 40
                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                        Text {
                            id: list4text
                            anchors.leftMargin: 10
                            anchors.left: parent.left
                            text: name + "            " + description
                            color: "black"
                            font.pixelSize: 20
                            font.family: "Segoe UI"
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            list4text.font.pixelSize = 21
                        }
                        onExited: {
                            list4text.font.pixelSize = 20
                        }
                        onPressed: {
                            list4text.color = "red"
                        }
                        onReleased: {
                            list4text.color = "black"
                            console.log(list4.get(index).name)
                            var accessNum = list4.get(index).name
                            mainCtl.openClusterDetail(accessNum)
                            webpage.visible = true;
                        }
                    }
                }
            }

            //close popup4 button  //关闭弹窗4按钮
            Button {
                height: 40
                width: 40
                opacity: pressed?0.8:1
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height*0.018
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.9-width*0.5
                tooltip: "Back"
                style: ButtonStyle {
                    background: Rectangle {
                        radius: 20
                        anchors.fill: parent
                        color: control.hovered ? "#AAAAAA" : "transparent"
                        Image {
                            width: 35
                            height: 35
                            anchors.centerIn: parent
                            source: control.hovered ? "qrc:/images/back1.png" : "qrc:/images/back.png"
                        }
                    }
                }
                onClicked: {
                    tanchuang4_leave.start()
                    resgoback.start()
                    vanishflag = 0
                    show3pao.start()
                    p2background.source = "qrc:/images/background_3.png"
                    resultbtn.visible = true
                    pathwaybtn.visible = true
                    modulebtn.visible = true
                    p2download.visible = true
                    p2return.visible = true
                    p2home.visible = true
                }
            }


            PropertyAnimation {
                id: tanchuang4_leave
                target: tanchuang4
                property: "anchors.leftMargin"
                easing.type: Easing.OutCubic
                to: page_2.width
                duration: 500
            }
        }
    }

    //Web_Page
    Item {
        id: webpage
        visible: false
        anchors.fill: parent
        ScrollView {
            width: parent.width
            height: parent.height
            anchors.left: parent.left
            anchors.top: parent.top
            WebView {
                id: webview
                url: ""
                onNavigationRequested: {
                    var schemaRE = /^\w+:/;
                    if (schemaRE.test(request.url)) {
                        request.action = WebView.AcceptRequest;
                    } else {
                        request.action = WebView.IgnoreRequest;
                    }
                }
            }
        }

        //Revoke button     //撤销按钮
        Button {
            height: 40
            width: 40
            opacity: pressed?0.8:1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.02
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.79
            tooltip: "Back"
            style: ButtonStyle {
                background: Rectangle {
                    radius: 20
                    anchors.fill: parent
                    color: control.hovered ? "#AAAAAA" : "transparent"
                    Image {
                        width: 30
                        height: 30
                        anchors.centerIn: parent
                        source: control.hovered ? "qrc:/images/back1.png" : "qrc:/images/back.png"
                    }
                }
            }
            onClicked: {
                webview.goBack()
            }
        }

        //go ahead button       //前进按钮
        Button {
            height: 40
            width: 40
            opacity: pressed?0.8:1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.02
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.86
            tooltip: "Next"
            style: ButtonStyle {
                background: Rectangle {
                    radius: 20
                    anchors.fill: parent
                    color: control.hovered ? "#AAAAAA" : "transparent"
                    Image {
                        width:30
                        height: 30
                        anchors.centerIn: parent
                        source: control.hovered ? "qrc:/images/next1.png" : "qrc:/images/next.png"
                    }
                }
            }
            onClicked: {
                webview.goForward()
            }
        }

        //return to page2 button    //返回page_2按钮
        Button {
            height: 40
            width: 40
            opacity: pressed?0.8:1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.02
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.93
            tooltip: "Cancle"
            style: ButtonStyle {
                background: Rectangle {
                    radius: 20
                    anchors.fill: parent
                    color: control.hovered ? "#AAAAAA" : "transparent"
                    Image {
                        width: 30
                        height: 30
                        anchors.centerIn: parent
                        source: control.hovered ? "qrc:/images/NO1.png" : "qrc:/images/NO.png"
                    }
                }
            }
            onClicked: {
                webpage.visible = false
                page_2.visible = true
            }
        }

    }

    //record window     //记录窗口
    Window {
        id: recorditem
        width: 450
        height: 300
        flags: Qt.FramelessWindowHint
        modality: Qt.ApplicationModal
        property int num:0
        MouseArea {
            anchors.fill:parent
            property variant clickPos: "1,1"

            onPressed: {
                clickPos  = Qt.point(mouse.x,mouse.y)
            }

            onPositionChanged: {
                var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                recorditem.x = recorditem.x+delta.x
                recorditem.y= recorditem.y+delta.y
            }

        }

        Item {
            anchors.fill: parent
            Rectangle {
                anchors.fill: parent
                color:"#DDDDDD"
            }

            //close button  //关闭按钮
            Button {
                width: 30
                height: 30
                anchors.right:parent.right
                anchors.top: parent.top
                anchors.rightMargin: 5
                anchors.topMargin: 5
                style: ButtonStyle {
                    background: Rectangle {
                        radius: 15
                        anchors.fill: parent
                        color: control.hovered ? "red" : "transparent"
                        Image {
                            width: 25
                            height: 25
                            anchors.centerIn: parent
                            source: control.hovered ? "qrc:/images/NO1.png" : "qrc:/images/NO.png"
                        }
                    }
                }
                onClicked: {
                    recorditem.close()
                }
            }

            //nodata
            Rectangle {
                id:nodata
                property int n: 0
                anchors.fill: parent
                visible: n==0?true:false
                color: "transparent"
                Text {
                    anchors.centerIn: parent
                    font.family: "Segoe Script"
                    text:"No Data!"
                    font.pixelSize: 30
                }
            }
            //记录model
            ListModel {
                id: recordlist
            }
            //记录列表
            ListView {
                id: recordlistitem
                anchors.top: parent.top
                anchors.topMargin: 50
                height: parent.height-80
                width: parent.width
                model: recordlist
                delegate: Item {
                    width: parent.width
                    height: 30
                    //background
                    Rectangle {
                        id: record_show_rec
                        height: parent.height
                        width: parent.width-15
                        visible: false
                        color: "lightblue"
                    }
                    //假@复选框
                    Button {
                        id: check
                        anchors.right: parent.right
                        anchors.rightMargin: 8
                        height: 30
                        width: 30
                        Rectangle {
                            radius: 1
                            anchors.fill: parent
                            Image {
                                id: checked
                                anchors.fill: parent
                                source: "qrc:/images/check1.png"
                                visible: false
                            }
                            color: "transparent"
                        }

                        onClicked: {
                            if(checked.visible===true){
                                recorditem.num=recorditem.num-1
                                checked.visible=false
                                recordlist.get(index).flag=0
                            }
                            else{
                                if(recorditem.num===2)
                                    return
                                else{
                                    checked.visible=true
                                    recorditem.num=recorditem.num+1
                                    recordlist.get(index).flag=1
                                }
                            }
                        }
                    }
                    //delete button     //删除
                    Button {
                        id: del
                        height: parent.height
                        width: 30
                        tooltip: "Delete this item"
                        style: ButtonStyle {
                            background: Rectangle {
                                radius: 3
                                anchors.fill: parent
                                color: control.hovered ? "red" : "transparent"
                                Image {
                                    width: 25
                                    height: 25
                                    anchors.centerIn: parent
                                    source: control.hovered ? "qrc:/images/delete1.png" : "qrc:/images/delete.png"
                                }
                            }
                        }

                        onClicked: {
                            if(recordlist.get(index).flag)
                                recorditem.num--
                            recordlist.remove(index)
                            nodata.n=recordlist.count
                        }
                    }

                    Rectangle {
                        height: parent.height-2
                        anchors.left: del.right
                        width: parent.width-check.width-del.width-check.anchors.rightMargin-3
                        radius: 3
                        color:"transparent"
                        Text {
                            anchors.centerIn: parent
                            text: label
                            font.family: "Microsoft YaHei"
                        }
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                record_show_rec.visible=true
                                record_show_list.clear()
                                for(var i=1;i<recordlist.get(index).source.length;i+=2){
                                    var s=String(recordlist.get(index).source.charAt(i-1)+recordlist.get(index).source.charAt(i))
                                    record_show_list.append({"name":ogCtl.tran2Name(s)})
                                }
                                record_show.x=recorditem.x+recorditem.width
                                record_show.y=recorditem.y+30
                                record_show.height=20*record_show_list.count
                                record_show.show()
                                record_show_t.start()
                            }
                            onExited: {
                                record_show_t.stop()
                                record_show.close()
                                record_show_rec.visible=false
                            }
                        }
                    }
                    Rectangle {
                        height: parent.width
                        width: 2
                        rotation: 90
                        y: -height*0.5+parent.height
                        x: parent.width*0.5
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "#DDDDDD" }
                            GradientStop { position: 0.8; color: "#DDDDDD" }
                            GradientStop { position: 1.0; color: "black" }
                        }
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 30
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 40
                visible: !nodata.visible
                color: "transparent"
                Text {
                    anchors.centerIn: parent
                    text: "You can only choose two items to compare."
                    font.family: "Segoe Script"
                }
            }
            Timer {
                id: record_show_t
                interval: 1
                onTriggered: {
                    record_show.close()
                    record_show.show()
                }
            }
            //submit button     //提交按钮
            Button {
                width: 40
                height: 40
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.right: parent.right
                anchors.rightMargin: 5
                visible: !nodata.visible
                style: ButtonStyle {
                    background: Rectangle {
                        radius: 20
                        anchors.fill: parent
                        color: control.hovered ? "#757575" : "transparent"
                        Image {
                            width: 33
                            height: 33
                            anchors.centerIn: parent
                            source: control.hovered ? "qrc:/images/next1.png" : "qrc:/images/next.png"
                        }
                    }
                }
                onClicked: {
                    var s=new String
                    var s1=new String
                    if(recorditem.num!=2)
                        return

                    var ok=true
                    for(var i=0;i<recordlist.count;i++){
                        if(recordlist.get(i).flag)
                        {
                            if(ok)
                                s=recordlist.get(i).source
                            else
                                s1=recordlist.get(i).source
                            if(!ok)
                                break
                            ok=false
                        }
                    }
                    ogCtl.submit_compare(s,s1);

                    view1model.clear()
                    view2model.clear()

                    for(i=1;i<s.length;i+=2){
                        view1model.append({"name":ogCtl.tran2Name(s.charAt(i-1)+s.charAt(i))})
                    }
                    for(i=1;i<s1.length;i+=2){
                        view2model.append({"name":ogCtl.tran2Name(s1.charAt(i-1)+s1.charAt(i))})
                    }
                    recorditem.close()
                    page_1.visible=false
                    compareitem.visible=true

                }
            }
        }

        //show record window    //记录展示窗口
        Window {
            id:record_show
            color: "gray"
            opacity: 0.9
            visible: false
            flags: Qt.FramelessWindowHint
            width: 300

            Item {
                anchors.fill: parent

                ListModel {
                    id: record_show_list
                }
                ListView {
                    anchors.fill: parent
                    model: record_show_list
                    delegate: Rectangle {
                        width: parent.width
                        height: 20
                        color: index%2?"white":"#444444"
                        Text {
                            anchors.centerIn: parent
                            color: index%2?"#444444":"white"
                            text: name
                            font.family: "Microsoft YaHei"
                        }
                    }
                }
            }
        }
    }
}
