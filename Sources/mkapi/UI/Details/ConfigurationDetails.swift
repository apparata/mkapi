import SwiftUI

struct ConfigurationDetails: View {

    @Bindable var configuration: ConfigurationModel

    @Environment(SceneModel.self) private var sceneModel

    var body: some View {
        @Bindable var model = sceneModel.apiModel

        ScrollView(.vertical) {
            Form {
                Section("Naming") {
                    TextField("Title", text: $configuration.title, prompt: Text("Example Configuration"))
                    TextField("Property Name", text: $configuration.propertyName, prompt: Text("exampleConfiguration"))
                }
                Section("Description") {
                    TextField("Property Comment", text: $configuration.propertyComment, prompt: Text("Example description"))
                }
                Section("Endpoints") {
                    TextField("Base URL", text: $configuration.baseURL, prompt: Text("https://localhost"))
                }
            }
            .formStyle(.grouped)
            .padding()
        }
    }
}
