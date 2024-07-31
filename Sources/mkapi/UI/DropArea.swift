import SwiftUI

@MainActor struct DropArea: View {

    @State private var isDropAreaTargeted: Bool = false

    @State private var isImportButtonHighlighted: Bool = false

    @State private var isPresentingFileImporter: Bool = false

    @Environment(SceneModel.self) private var sceneModel

    @Environment(\.colorScheme) private var colorScheme

    private var borderColor: Color {
        isDropAreaTargeted ? .accentColor.opacity(0.8) : .primary.opacity(0.2)
    }

    private var importButtonColor: Color {
        isImportButtonHighlighted ? .accentColor.opacity(0.8) : .secondary
    }

    var body: some View {
        Button {
            isPresentingFileImporter = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.ultraThinMaterial)
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(
                        borderColor,
                        style: StrokeStyle(lineWidth: 2, dash: [8, 4], dashPhase: 0)
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                HStack(spacing: 6) {
                    Image(systemName: "square.and.arrow.down")
                        .imageScale(.large)
                        .offset(y: -2)
                    Text("Import API")
                }
                .foregroundStyle(importButtonColor)
            }
            .frame(maxHeight: 80)
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
        .onHover { value in
            isImportButtonHighlighted = value
        }
        .dropDestination(for: URL.self) { urls, location in
            _ = location
            guard let url = urls.first else {
                return false
            }
            importSpecification(from: url)
            return true
        } isTargeted: { isTargeted in
            self.isDropAreaTargeted = isTargeted
        }
        .fileImporter(
            isPresented: $isPresentingFileImporter,
            allowedContentTypes: [.xmlPropertyList]
        ) { result in
            switch result {
            case .success(let url):
                importSpecification(from: url)
            case .failure(let error):
                dump(error)
                sceneModel.error = error
                sceneModel.isShowingError = true
            }
        }
    }

    private func importSpecification(from url: URL) {
        Task {
            do {
                let data = try Data(contentsOf: url)
                let apiModel = try JSONDecoder()
                    .decode(APIModel.self, from: data)
                withAnimation {
                    sceneModel.importAPIModel(apiModel)
                }
            } catch {
                dump(error)
                sceneModel.showError(error)
            }
        }
    }
}

#Preview {
    DropArea()
}
