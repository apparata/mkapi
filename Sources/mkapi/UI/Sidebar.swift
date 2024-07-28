import SwiftUI

struct Sidebar: View {

    @Environment(SceneModel.self) private var sceneModel

    var body: some View {
        @Bindable var sceneModel = sceneModel
        List(selection: $sceneModel.selectedSidebarItem) {
            Section("General") {
                SidebarItem(.package)
            }
            Section("Configurations") {
                ForEach(sceneModel.apiModel.configurations) { configuration in
                    SidebarItem(.configuration(configuration))
                        .contextMenu {
                            Button("Delete") {

                            }
                        }
                }
            }
            Section("Requests") {
                ForEach(sceneModel.apiModel.requests) { request in
                    SidebarItem(.request(request))
                        .contextMenu {
                            Button("Delete") {

                            }
                        }
                }
            }
        }
        .listStyle(.sidebar)
    }
}

#Preview {
    Sidebar()
}
