import SwiftUI

struct MainView: View {

    @Environment(SceneModel.self) private var sceneModel

    @State private var isPresentingClearDataPrompt: Bool = false

    var body: some View {
        @Bindable var sceneModel = sceneModel
        NavigationSplitView {
            Sidebar()
                .safeAreaInset(edge: .bottom) {
                    SidebarBottomPanel()
                }
                .navigationSplitViewColumnWidth(ideal: 230)
        } detail: {
            switch sceneModel.selectedSidebarItem {
            case .General.package:
                PackageDetails()
            default:
                DummyDetails()
            }
        }
        .navigationTitle(sceneModel.selectedSidebarItem?.description ?? "Make API")
        .navigationSubtitle(sceneModel.selectedSidebarItem?.subtitle ?? "Generate API code")
        .toolbar {
            Button("Export package", systemImage: "square.and.arrow.up") {
                sceneModel.generateAPI()
            }
            .help("Export as package")
        }
        .alert(
            sceneModel.error?.localizedDescription ?? "Error: Something went wrong.",
            isPresented: $sceneModel.isShowingError
        ) {
            Button("OK", role: .cancel) { }
        }
    }
}
