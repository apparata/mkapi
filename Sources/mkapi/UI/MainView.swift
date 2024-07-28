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
            case .package:
                PackageDetails()
            case .configuration(let configuration):
                ConfigurationDetails(configuration: configuration)
            case .request(let request):
                RequestDetails(request: request)
            default:
                DummyDetails()
            }
        }
        .navigationTitle(sceneModel.selectedSidebarItem?.description ?? "Make API")
        .navigationSubtitle(sceneModel.apiModel.apiName.orIfEmpty(sceneModel.apiModel.packageName).orIfEmpty(sceneModel.apiModel.repositoryName).orIfEmpty("UntitledAPI"))
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
