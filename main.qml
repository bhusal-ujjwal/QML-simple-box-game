import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Rectangle app")

    Timer{
        id: mainTimer
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            mainRect.x=Math.random() * (mainRect.parent.width - mainRect.width)
            mainRect.y=Math.random() * (mainRect.parent.height - mainRect.height)
        }
    }

    Text{
        id:textCount
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 10
        anchors.topMargin: 5
        text:  qsTr("Click Count: ") + playGround.clickCount
    }

    //defining playground
    Rectangle{
        id: playGround
        property int clickCount: 0

        anchors.fill: parent
        anchors.margins: 10
        anchors.topMargin: 20
        color: "lightgrey"

        MouseArea{
            anchors.fill: parent
            onClicked: {
                playGround.clickCount -= 1
                mainTimer.interval += 10
                mainRect.animColor = "red"
                coloAnimationObject.start()


            }
        }



    Rectangle{
        id: mainRect
        property color animColor: "green"
        width: (mainRect.parent.width<400?mainRect.parent.width/4:100)
        height: (mainRect.parent.height<300?mainRect.parent.height/3:100)

        x: 100
        y: 100
        color: "lightblue"
        border.color: "black"
        border.width: 2
        radius: 10
        focus: true

        //diigng the text
        Text {
            anchors.centerIn: parent
            text: qsTr("Click Me")
        }

//        //rotation box
//        RotationAnimation{
//            id:rotate
//            target: mainRect
//            property: "rotation"
//            from : 0
//            to: 360
//            duration: 1000
//            direction: RotationAnimation.Clockwise

//        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
//                rotate.start()
                mainRect.x=Math.random() * (mainRect.parent.width - mainRect.width)
                mainRect.y=Math.random() * (mainRect.parent.height - mainRect.height)
                playGround.clickCount += 1
                mainTimer.interval -= 10
                mainRect.animColor = "green"
                coloAnimationObject.start()



            }

        }

        //define keyboard arrows for moving rectangle
        Keys.onRightPressed: mainRect.x += 50
        Keys.onLeftPressed: mainRect.x -= 50
        Keys.onUpPressed: mainRect.y -= 50
        Keys.onDownPressed: mainRect.y += 50

        //animate while moving on x and y axis
        Behavior on x{

            NumberAnimation {
                duration: mainTimer.interval
                easing.type: Easing.OutElastic
            }
        }

        Behavior on y{

            NumberAnimation {
                duration: mainTimer.interval
                easing.type: Easing.OutElastic
            }
        }

        SequentialAnimation{
            id: coloAnimationObject

            ColorAnimation {
                from: "lightblue"
                to: mainRect.animColor
                duration: mainTimer.interval/2
                target: mainRect
                property: "color"
            }

            ColorAnimation {
                to: "lightblue"
                from: mainRect.animColor
                duration: mainTimer.interval/2
                target: mainRect
                property: "color"
            }


        }


    }

   }

 }
