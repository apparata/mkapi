import Foundation
import CollectionKit

private let apiNamePlaceholder = "UntitledAPI"

@Observable class APIModel: Codable {

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
    
    enum CodingKeys: CodingKey {
        case repositoryName
        case packageName
        case copyrightYear
        case copyrightHolder
        case apiName
        case swiftVersion
        case configurations
        case requests
        case responses
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        repositoryName = try container.decode(String.self, forKey: .repositoryName)
        packageName = try container.decode(String.self, forKey: .packageName)
        copyrightYear = try container.decode(String.self, forKey: .copyrightYear)
        copyrightHolder = try container.decode(String.self, forKey: .copyrightHolder)
        apiName = try container.decode(String.self, forKey: .apiName)
        swiftVersion = try container.decode(String.self, forKey: .swiftVersion)
        configurations = try container.decode([ConfigurationModel].self, forKey: .configurations)
        requests = try container.decode([RequestModel].self, forKey: .requests)
        responses = try container.decode([ResponseModel].self, forKey: .responses)
        
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: APIModel.CodingKeys.self)
        
        try container.encode(repositoryName, forKey: .repositoryName)
        try container.encode(packageName, forKey: .packageName)
        try container.encode(copyrightYear, forKey: .copyrightYear)
        try container.encode(copyrightHolder, forKey: .copyrightHolder)
        try container.encode(apiName, forKey: .apiName)
        try container.encode(swiftVersion, forKey: .swiftVersion)
        try container.encode(configurations, forKey: .configurations)
        try container.encode(requests, forKey: .requests)
        try container.encode(responses, forKey: .responses)
    }
}

@Observable class RequestModel: Identifiable, Codable {

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

    enum CodingKeys: CodingKey {
        case id
        case title
        case functionName
        case functionComment
        case method
        case endpointPath
        case body
        case query
        case headers
        case responseName
    }

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        functionName = try container.decode(String.self, forKey: .functionName)
        functionComment = try container.decode(String.self, forKey: .functionComment)
        method = try container.decode(HTTPMethod.self, forKey: .method)
        endpointPath = try container.decode(String.self, forKey: .endpointPath)
        body = try container.decode(String.self, forKey: .body)
        query = try container.decode([String : String].self, forKey: .query)
        headers = try container.decode([String : String].self, forKey: .headers)
        responseName = try container.decode(String.self, forKey: .responseName)

    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(functionName, forKey: .functionName)
        try container.encode(functionComment, forKey: .functionComment)
        try container.encode(method, forKey: .method)
        try container.encode(endpointPath, forKey: .endpointPath)
        try container.encode(body, forKey: .body)
        try container.encode(query, forKey: .query)
        try container.encode(headers, forKey: .headers)
        try container.encode(responseName, forKey: .responseName)
    }
}

struct ResponseModel: Codable {
    var responseName: String
}

@Observable class ConfigurationModel: Identifiable, Codable {

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
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case propertyName
        case propertyComment
        case baseURL
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        propertyName = try container.decode(String.self, forKey: .propertyName)
        propertyComment = try container.decode(String.self, forKey: .propertyComment)
        baseURL = try container.decode(String.self, forKey: .baseURL)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(propertyName, forKey: .propertyName)
        try container.encode(propertyComment, forKey: .propertyComment)
        try container.encode(baseURL, forKey: .baseURL)
    }
}
