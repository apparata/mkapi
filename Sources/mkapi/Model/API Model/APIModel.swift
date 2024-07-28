import Foundation

@Observable class APIModel {

    var copyrightYear = ""
    var copyrightHolder = ""

    var apiName: String = ""

    var requests: [RequestModel] = []

    var responses: [ResponseModel] = []

    init() {
        //
    }
}

struct RequestModel {
    var markComment: String
    var functionName: String
    var functionComment: String
    
    var requestName: String

    var method: HTTPMethod
    var endpointPath: String
    var body: String
    var query: [String: String]
    var headers: [String: String]

    var responseName: String
}

struct ResponseModel {
    var responseName: String
}
