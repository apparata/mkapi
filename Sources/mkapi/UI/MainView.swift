import SwiftUI
import UniformTypeIdentifiers

struct MainView: View {

    @Environment(SceneModel.self) private var sceneModel

    @State private var isPresentingClearDataPrompt: Bool = false

    @State private var isPresentingFileExplorer = false

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
            Menu("Export", systemImage: "square.and.arrow.up") {
                Button("Export Specification") {
                    isPresentingFileExplorer = true
                }
                Button("Export package", systemImage: "square.and.arrow.up") {
                    sceneModel.generateAPI()
                }
            }
            .menuIndicator(.hidden)
            .help("Export as package")
        }
        .fileExporter(
            isPresented: $isPresentingFileExplorer,
            document: sceneModel.makeDocument(),
            contentType: .json,
            defaultFilename: "\(sceneModel.apiModel.apiName.orIfEmpty(sceneModel.apiModel.packageName).orIfEmpty(sceneModel.apiModel.repositoryName).orIfEmpty("UntitledAPI"))"
        ) { result in
            switch result {
            case .success(let file):
                print(file)
            case .failure(let error):
                print(error)
            }
        }
        .alert(
            sceneModel.error?.localizedDescription ?? "Error: Something went wrong.",
            isPresented: $sceneModel.isShowingError
        ) {
            Button("OK", role: .cancel) { }
        }
    }
}
