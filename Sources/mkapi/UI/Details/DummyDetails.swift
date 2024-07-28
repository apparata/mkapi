import SwiftUI

struct DummyDetails: View {

    @Environment(SceneModel.self) private var sceneModel

    var body: some View {
        @Bindable var sceneModel = sceneModel
        //
    }

}

// MARK: - Preview

#if DEBUG

#Preview {
    DummyDetails()
}

#endif
