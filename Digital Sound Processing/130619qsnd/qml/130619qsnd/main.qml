import QtQuick 2.0

Rectangle {
    width: 200; height: 250

    Text {
        id: myText
        text: "Hello"
        color: "#dd44ee"
    }

    Component {
        id: myDelegate
        Text { text: model.color }
    }

    ListView {
        anchors.fill: parent
        anchors.topMargin: 30
        model: myText
        delegate: myDelegate
    }
}
