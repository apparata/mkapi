import SwiftUI

struct RequestDetails: View {

    @Bindable var request: RequestModel

    @Environment(SceneModel.self) private var sceneModel

    var body: some View {
        @Bindable var model = sceneModel.apiModel

        ScrollView(.vertical) {
            Form {
                Section("Naming") {
                    TextField("Title", text: $request.title, prompt: Text("Example Request"))
                    TextField("Function Name", text: $request.functionName, prompt: Text("exampleRequest"))
                }
                Section("Description") {
                    TextField("Function Comment", text: $request.functionComment, prompt: Text("Example description"))
                }
                Section("Endpoint") {
                    TextField("Path", text: $request.endpointPath, prompt: Text("/example"))
                    Picker("HTTP Method", selection: $request.method) {
                        ForEach(HTTPMethod.allCases) { method in
                            Text(method.description)
                                .tag(method)
                        }
                    }
                    /*
                    VStack(alignment: .leading) {
                        Text("Headers")
                        VStack {
                            Text("TODO")
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Parameters")
                        VStack {
                            Text("TODO")
                        }
                    }*/
                }

                Section("Response") {
                    TextField("Type Name", text: $request.responseName, prompt: Text("ExampleResponse"))
                }
            }
            .formStyle(.grouped)
            .padding()
        }
    }

}
