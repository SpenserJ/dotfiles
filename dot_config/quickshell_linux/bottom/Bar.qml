import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Widgets
import Quickshell.Services.SystemTray

Scope {
  id: root
  property var theme: DefaultTheme {}

  Variants {
    model: Quickshell.screens;

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        bottom: true
        left: true
        right: true
      }

      implicitHeight: 30
      color: root.theme.bgBase

      Item {
        id: trayItem

        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8

	function iconSource(item) {
          if (item.icon)
            return item.icon;
          return Quickshell.iconPath("application-x-executable", true);
        }

        // Workspaces
        Row {
          spacing: 4

          Repeater {
            model: Hyprland.workspaces

            Rectangle {
              id: wsPill
              required property var modelData
              property bool urgentBlink: false
      
              Accessible.role: Accessible.Button
              Accessible.name: "Workspace " + modelData.id + (modelData.focused ? ", active" : "") + (modelData.urgent ? ", urgent" : "")
      
              width: modelData.focused ? 32 : 24
              height: 24
              radius: 12
              color: modelData.focused ? root.theme.accentPrimary :
                     modelData.urgent && urgentBlink ? root.theme.accentRed : root.theme.bgSurface
      
              Behavior on color {
                 ColorAnimation { duration: 150 }
              }
    
              SequentialAnimation {
                loops: Animation.Infinite
                running: wsPill.modelData.urgent && !wsPill.modelData.focused
    
                PropertyAction { target: wsPill; property: "urgentBlink"; value: true }
                PauseAnimation { duration: 500 }
                PropertyAction { target: wsPill; property: "urgentBlink"; value: false }
                PauseAnimation { duration: 500 }
    
                onStopped: wsPill.urgentBlink = false
              }
    
              Text {
                anchors.centerIn: parent
                text: wsPill.modelData.id
                color: wsPill.modelData.focused ? root.theme.bgBase : root.theme.textPrimary
                font.pixelSize: 11
                font.family: root.font
                font.bold: wsPill.modelData.focused
              }
    
              MouseArea {
                anchors.fill: parent
                onClicked: wsPill.modelData.activate()
              }
    
              Behavior on width {
                NumberAnimation { duration: 150 }
              }
            }
          }
        }

        Row {
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          spacing: 8

          Rectangle {
            implicitHeight: 24
            implicitWidth: trayIcons.implicitWidth + 4
            radius: 12
            color: root.theme.bgSurface

            RowLayout {
              id: trayIcons
              anchors.centerIn: parent
              spacing: 2

              Repeater {
                model: SystemTray.items

                MouseArea {
                  id: trayDelegate
                  required property SystemTrayItem modelData

                  Accessible.role: Accessible.Button
                  Accessible.name: modelData.tooltipTitle || modelData.title || "System tray item"

                  Layout.preferredWidth: 24
                  Layout.preferredHeight: 24

                  acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                  onClicked: (mouse) => {
                    if (mouse.button === Qt.LeftButton) {
                      modelData.activate()
                    } else if (mouse.button === Qt.RightButton) {
                      if (modelData.hasMenu) {
                        menuAnchor.open()
                      }
                    } else if (mouse.button === Qt.MiddleButton) {
                      modelData.secondaryActivate()
                    }
                  }

                  IconImage {
                    anchors.centerIn: parent
                    source: trayItem.iconSource(trayDelegate.modelData)
                    implicitSize: 16
                  }

                  QsMenuAnchor {
                    id: menuAnchor
                    menu: trayDelegate.modelData.menu

                    anchor.window: trayDelegate.QsWindow.window
                    anchor.adjustment: PopupAdjustment.Flip
                    anchor.onAnchoring: {
                      const window = trayDelegate.QsWindow.window;
                      const widgetRect = window.contentItem.mapFromItem(
                        trayDelegate, 0, trayDelegate.height,
                        trayDelegate.width, trayDelegate.height);
                      menuAnchor.anchor.rect = widgetRect;
                    }
                  }
                }
              }
            }
          }

	  ClockWidget {
	    color: root.theme.textPrimary
	  }
        }
      }
    }
  }
}
