import Foundation
import AppKit
import SwiftUI

@Observable class SceneModel {

    var selectedSidebarItem: NavigationItem? = .package

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

    func makeDocument() -> APIModelDocument {
        return APIModelDocument(apiModel)
    }

    func importAPIModel(_ apiModel: APIModel) {
        self.apiModel = apiModel
        selectedSidebarItem = .package
    }


    func showError(_ error: Swift.Error) {
        self.error = error
        self.isShowingError = true
    }
}
