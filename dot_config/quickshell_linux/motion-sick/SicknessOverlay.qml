import QtQuick
import Quickshell
import Quickshell.Wayland

Scope {
  id: root

  // --- CONFIGURATION ---
  property int lineLength: 300
  property int lineThickness: 6
  property real lineOpacity: 0.3
  property color lineColor: Qt.rgba(1.0, 0.498, 0.314, root.lineOpacity)

  property bool linesVisible: false
  // ---------------------

  PanelWindow {
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "sickness-anchor"
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"

    visible: root.linesVisible

    anchors {
      left: true
      right: true
      top: true
      bottom: true
    }

    mask: Region {
      intersection: Intersection.Combine
    }

    Item {
      anchors.fill: parent

      Rectangle {
        id: leftLine
        color: root.lineColor
        radius: 3
        width: root.lineLength * 3
        height: root.lineThickness
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
      }

      Rectangle {
        id: rightLine
        color: root.lineColor
        radius: 3
        width: root.lineLength * 3
        height: root.lineThickness
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
      }

      Rectangle {
        id: topLine
        color: root.lineColor
        radius: 3
        width: root.lineThickness
        height: root.lineLength
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
      }

      Rectangle {
        id: bottomLine
        color: root.lineColor
        radius: 3
        width: root.lineThickness
        height: root.lineLength
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
      }
    }
  }
}
