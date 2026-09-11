import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
  id: root

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSource]
  }

  Connections {
    target: Pipewire.defaultAudioSource?.audio

    function onMutedChanged() {
      root.shouldShowOsd = Pipewire.defaultAudioSource?.audio.muted;
    }
  }

  property bool shouldShowOsd: Pipewire.defaultAudioSource?.audio.muted

  LazyLoader {
    active: root.shouldShowOsd

    PanelWindow {
      anchors.top: true
      anchors.right: true
      margins.top: 48
      margins.right: 48
      exclusiveZone: 0

      implicitWidth: 50
      implicitHeight: 50
      color: "transparent"

      mask: Region {}

      Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: "#80000000"

        RowLayout {
          anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 15
          }

          IconImage {
            implicitSize: 30
            source: Quickshell.iconPath("microphone-sensitivity-muted")
          }
        }
      }
    }
  }
}

