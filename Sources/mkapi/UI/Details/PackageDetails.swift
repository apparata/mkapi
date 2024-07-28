import SwiftUI

struct PackageDetails: View {

    @Environment(SceneModel.self) private var sceneModel

    var body: some View {
        @Bindable var model = sceneModel.apiModel

        ScrollView(.vertical) {
            Form {
                Section("Naming") {
                    TextField("API Name", text: $model.apiName, prompt: Text("UntitledAPI"))
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
    DummyDetails()
}

#endif
