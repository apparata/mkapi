import SwiftUI

struct MainWindow: Scene {

    var body: some Scene {
        WindowGroup {
            WindowWrapper()
                .frame(minWidth: 700, maxWidth: 700,
                       minHeight: 500, maxHeight: 1000)
        }
        .windowResizability(.contentSize)
        .commands {
            SidebarCommands()
        }
    }
}

struct WindowWrapper: View {

    @StateObject private var windowModelHolder = WindowModelHolder()

    var body: some View {
        MainWindowContent()
            .environment(windowModelHolder.sceneModel)
    }
}

struct MainWindowContent: View {

    @Environment(SceneModel.self) private var sceneModel

    var body: some View {
        MainView()
            .background {
                if sceneModel.windowIsAlwaysOnTop {
                    AlwaysOnTop()
                }
            }
    }
}

class WindowModelHolder: ObservableObject {

    let sceneModel: SceneModel

    init() {
        sceneModel = SceneModel()
    }
}
