import Quickshell
import Quickshell.Io

ShellRoot {
  // 1. Place the IPC Handler at the root so the CLI tool can find it instantly
  IpcHandler {
    target: "sicknessOverlay"

    function setVisible(state: bool): void {
      sicknessOverlayWindow.linesVisible = state;
    }
  }

  // 2. Load your custom sickness component and give it an ID
  SicknessOverlay {
    id: sicknessOverlayWindow
  }
}
