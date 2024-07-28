import Foundation
import AppKit
import SwiftUI

@Observable class SceneModel {

    var selectedSidebarItem: NavigationItem? = .General.package

    var windowIsAlwaysOnTop: Bool = false

    var isShowingError: Bool = false
    var error: Error?

    var apiModel = APIModel()

    init() {
    }

    func generateAPI() {
        Task {
            do {
                try APIGenerator().generateAPI(for: apiModel)
            } catch {
                dump(error)
            }
        }
    }
}
