import SwiftUI
import AppKit

struct MkAPIApp: App {
    
    // swiftlint:disable:next weak_delegate
    @NSApplicationDelegateAdaptor(MkAPIAppDelegate.self) var appDelegate

    init() {
        DispatchQueue.main.async {
            NSApp.setActivationPolicy(.regular)
            NSApp.activate(ignoringOtherApps: true)
            NSApp.windows.first?.makeKeyAndOrderFront(nil)
            NSApp.applicationIconImage = appIcon
        }
    }

    var body: some Scene {
        MainWindow()
    }
}

