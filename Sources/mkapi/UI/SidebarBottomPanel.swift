import SwiftUI

struct SidebarBottomPanel: View {

    @Environment(SceneModel.self) private var appModel

    var body: some View {
        @Bindable var appModel = appModel
        VStack(spacing: 0) {
            HStack {
                Menu {
                    Button {
                        print("New config")
                    } label: {
                        Text("New Configuration")
                    }
                    Button {
                        print("New request")
                    } label: {
                        Text("New Request")
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
    }
}

// MARK: - Preview

#if DEBUG
#Preview {
    SidebarBottomPanel()
}
#endif
