import Foundation
import TemplateKit

extension Template.API {

    /// Parameters:
    /// - copyrightYear
    /// - copyrightHolder
    static let httpMethod = Template(#"""
//
//  Copyright © <{ copyrightYear }> <{ copyrightHolder }>. All rights reserved.
//

public enum HTTPMethod: String {

    /// The `DELETE` method deletes the specified resource.
    case delete = "DELETE"

    /// The `CONNECT` method establishes a tunnel to the server
    /// identified by the target resource.
    case connect = "CONNECT"

    /// The `GET` method requests a representation of the specified resource.
    /// Requests using `GET` should only retrieve data.
    case get = "GET"

    /// The `HEAD` method asks for a response identical to a `GET` request,
    /// but without the response body.
    case head = "HEAD"

    /// The `OPTIONS` method describes the communication options
    /// for the target resource.
    case options = "OPTIONS"

    case patch = "PATCH"

    /// The `POST` method submits an entity to the specified resource,
    /// often causing a change in state or side effects on the server.
    case post = "POST"

    /// The `PUT` method replaces all current representations of the target
    /// resource with the request payload.
    case put = "PUT"

    /// The `TRACE` method performs a message loop-back test
    /// along the path to the target resource.
    case trace = "TRACE"
}

extension HTTPMethod: Identifiable {
    public var id: String {
        rawValue
    }
}

extension HTTPMethod: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
"""#)
}
