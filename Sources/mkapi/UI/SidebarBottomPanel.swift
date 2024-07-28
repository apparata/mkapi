import SwiftUI

struct SidebarBottomPanel: View {

    @Environment(SceneModel.self) private var appModel

    @State private var isPresentingNewConfigurationSheet: Bool = false
    @State private var isPresentingNewRequestSheet: Bool = false

    var body: some View {
        @Bindable var appModel = appModel
        VStack(spacing: 0) {
            HStack {
                Menu {
                    Button {
                        isPresentingNewConfigurationSheet = true
                    } label: {
                        Text("New Configuration")
                    }
                    Button {
                        isPresentingNewRequestSheet = true
                    } label: {
                        Text("New Request")
                    }
                    .sheet(isPresented: $isPresentingNewRequestSheet) {
                        Text("New Request sheet")
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 15))
                }
                .buttonStyle(.plain)
                /*
                Toggle(isOn: $appModel.windowIsAlwaysOnTop) {
                    Text("Always on top")
                        .foregroundStyle(Color.secondary)
                }*/
                Spacer()
            }
            .padding(8)
        }
        .frame(maxWidth: .infinity)
        .sheet(isPresented: $isPresentingNewConfigurationSheet) {
            NewConfigurationSheet()
        }
        .sheet(isPresented: $isPresentingNewRequestSheet) {
            NewRequestSheet()
        }
    }
}

// MARK: - Preview

#if DEBUG
#Preview {
    SidebarBottomPanel()
}
#endif
