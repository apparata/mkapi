import SwiftUI

struct PackageDetails: View {

    @Environment(SceneModel.self) private var sceneModel

    var body: some View {
        @Bindable var model = sceneModel.apiModel

        ScrollView(.vertical) {
            Form {
                Section("Naming") {
                    TextField("Repository Name", text: $model.repositoryName, prompt: Text(model.repositoryNamePrompt))
                    TextField("Package Name", text: $model.packageName, prompt: Text(model.packageNamePrompt))
                    TextField("API Name", text: $model.apiName, prompt: Text(model.apiNamePrompt))
                }
                Section("Code") {
                    TextField("Swift Version", text: $model.swiftVersion, prompt: Text("5.10"))
                }
                Section("Copyright") {
                    TextField("Copyright Year", text: $model.copyrightYear, prompt: Text(String(Date.currentYear)))
                    TextField("Copyright Holder", text: $model.copyrightHolder, prompt: Text("Unknown, Inc"))
                }
            }
            .formStyle(.grouped)
            .padding()
        }
    }

}

// MARK: - Preview

#if DEBUG

#Preview {
    PackageDetails()
}

#endif
