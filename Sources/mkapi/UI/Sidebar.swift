import SwiftUI

struct Sidebar: View {

    @Environment(SceneModel.self) private var appModel

    var body: some View {
        @Bindable var appModel = appModel
        List(selection: $appModel.selectedSidebarItem) {
            Section("General") {
                SidebarItem(.General.package)
            }
            Section("Configurations") {
                SidebarItem(.Configuration.development)
                    .contextMenu {
                        Button("Delete") {

                        }
                    }
            }
            Section("Requests") {
                SidebarItem(.Request.getStuff)
                    .contextMenu {
                        Button("Delete") {

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
