import SwiftUI
import TextToolbox

struct NewConfigurationSheet: View {

    @Environment(SceneModel.self) var sceneModel

    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var propertyName: String = ""

    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section("New Configuration") {
                    TextField("Title", text: $title, prompt: Text("New Configuration"))
                        .onSubmit {
                            if !propertyName.trimmed().isEmpty, !title.trimmed().isEmpty {
                                addConfiguration()
                                dismiss()
                            }
                        }
                    TextField("Property Name", text: $propertyName, prompt: Text("newConfiguration"))
                        .onSubmit {
                            if !propertyName.trimmed().isEmpty, !title.trimmed().isEmpty {
                                addConfiguration()
                                dismiss()
                            }
                        }
                }
            }
            .formStyle(.grouped)
            HStack {
                Spacer()
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
                Button("Add") {
                    addConfiguration()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.bottom)
            .padding(.horizontal)
            .padding(.trailing, 4)
        }
        .frame(width: 400)
    }

    private func addConfiguration() {
        let configuration = ConfigurationModel(
            title: title.orIfEmpty("New Configuration"),
            propertyName: propertyName.orIfEmpty("newConfiguration")
        )
        sceneModel.apiModel.addConfiguration(configuration)
        sceneModel.selectedSidebarItem = .configuration(configuration)
    }
}

#Preview {
    NewRequestSheet()
}
