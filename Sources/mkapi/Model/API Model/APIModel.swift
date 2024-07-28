import Foundation
import CollectionKit

private let apiNamePlaceholder = "UntitledAPI"

@Observable class APIModel {

    var repositoryName = ""
    @ObservationIgnored var repositoryNamePrompt: String {
        packageName.orIfEmpty(apiName).orIfEmpty(apiNamePlaceholder)
    }

    var packageName = ""
    @ObservationIgnored var packageNamePrompt: String {
        apiName.orIfEmpty(repositoryName).orIfEmpty(apiNamePlaceholder)
    }

    var copyrightYear = ""
    var copyrightHolder = ""

    var apiName: String = ""
    @ObservationIgnored var apiNamePrompt: String {
        packageName.orIfEmpty(packageName).orIfEmpty(repositoryName).orIfEmpty(apiNamePlaceholder)
    }

    var swiftVersion: String = ""

    var configurations: [ConfigurationModel] = []

    var requests: [RequestModel] = []

    var responses: [ResponseModel] = []

    init() {
        //
    }

    func addConfiguration(_ configuration: ConfigurationModel) {
        configurations.append(configuration)
        configurations = configurations.sorted(by: \.propertyName)
    }

    func addRequest(_ request: RequestModel) {
        requests.append(request)
        requests = requests.sorted(by: \.functionName)
    }
}

@Observable class RequestModel: Identifiable {

    var id: UUID

    var title: String
    var markComment: String { title }

    var functionName: String
    var functionComment: String
    
    var method: HTTPMethod
    var endpointPath: String
    var body: String
    var query: [String: String]
    var headers: [String: String]

    var responseName: String

    init(
        id: UUID = UUID(),
        title: String,
        functionName: String,
        functionComment: String = "",
        method: HTTPMethod = .get,
        endpointPath: String = "",
        body: String = "",
        query: [String : String] = [:],
        headers: [String : String] = [:],
        responseName: String = ""
    ) {
        self.id = id
        self.title = title
        self.functionName = functionName
        self.functionComment = functionComment
        self.method = method
        self.endpointPath = endpointPath
        self.body = body
        self.query = query
        self.headers = headers
        self.responseName = responseName
    }
}

struct ResponseModel {
    var responseName: String
}

@Observable class ConfigurationModel: Identifiable {

    var id: UUID

    var title: String

    var propertyName: String
    var propertyComment: String

    var baseURL: String

    init(
        id: UUID = UUID(),
        title: String,
        propertyName: String,
        propertyComment: String = "",
        baseURL: String = ""
    ) {
        self.id = id
        self.title = title
        self.propertyName = propertyName
        self.propertyComment = propertyComment
        self.baseURL = baseURL
    }
}
