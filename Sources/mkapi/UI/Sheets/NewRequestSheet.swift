import SwiftUI
import TextToolbox

struct NewRequestSheet: View {
    
    @Environment(SceneModel.self) var sceneModel

    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var functionName: String = ""

    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section("New Request") {
                    TextField("Title", text: $title, prompt: Text("New Request"))
                        .onSubmit {
                            if !functionName.trimmed().isEmpty, !title.trimmed().isEmpty {
                                addRequest()
                                dismiss()
                            }
                        }
                    TextField("Function Name", text: $functionName, prompt: Text("newRequest"))
                        .onSubmit {
                            if !functionName.trimmed().isEmpty, !title.trimmed().isEmpty {
                                addRequest()
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
                    addRequest()
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

    private func addRequest() {
        let request = RequestModel(
            title: title.orIfEmpty("New Request"),
            functionName: functionName.orIfEmpty("newRequest")
        )
        sceneModel.apiModel.addRequest(request)
        sceneModel.selectedSidebarItem = .request(request)
    }
}

#Preview {
    NewRequestSheet()
}
