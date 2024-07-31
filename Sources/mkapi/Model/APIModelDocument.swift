import SwiftUI
import UniformTypeIdentifiers

struct APIModelDocument: FileDocument {

    static var readableContentTypes: [UTType] {
        [.json]
    }

    static var writableContentTypes: [UTType] {
        [.json]
    }

    private var apiModel: APIModel

    init(_ apiModel: APIModel) {
        self.apiModel = apiModel
    }

    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            apiModel = try JSONDecoder().decode(
                APIModel.self,
                from: data
            )
        } else {
            apiModel = APIModel()
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(apiModel)
        return FileWrapper(regularFileWithContents: data)
    }
}
