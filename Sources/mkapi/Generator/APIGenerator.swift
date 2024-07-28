import Foundation
import AppKit
import TemplateKit
import SystemKit

class APIGenerator {
    func generateAPI(for apiModel: APIModel) throws {

        let copyrightHolder = apiModel.copyrightHolder.orIfEmpty("Unknown, Inc.")
        let copyrightYear = apiModel.copyrightYear.orIfEmpty(String(Date.currentYear))
        let apiName = apiModel.apiName.orIfEmpty("UntitledAPI")

        // Package
        let swiftVersion = "5.10"
        let packageName = apiName
        let libraryName = apiName
        let targetName = apiName

        let baseURL = "TODO"

        let loggerSubsystem = "TODO"
        let loggerCategory = apiName

        let outputPath = Path("/tmp/mkapi")
        let packagePath = outputPath.appendingComponent(apiName)

        let sourcesPath = packagePath.appendingComponent("Sources")
        let apiPath = sourcesPath.appendingComponent(apiName)
        let requestsPath = apiPath.appendingComponent("Requests")
        let responsesPath = apiPath.appendingComponent("Responses")
        let scaffoldingPath = apiPath.appendingComponent("Scaffolding")
        let helpersPath = apiPath.appendingComponent("Helpers")

        if packagePath.exists {
            try packagePath.remove()
        }
        try requestsPath.createDirectory(withIntermediateDirectories: true)
        try responsesPath.createDirectory(withIntermediateDirectories: true)
        try scaffoldingPath.createDirectory(withIntermediateDirectories: true)
        try helpersPath.createDirectory(withIntermediateDirectories: true)

        /// Package.swift
        try render(.Package.package, to: "Package.swift", in: packagePath, context: [
            "swiftVersion": swiftVersion,
            "packageName": packageName,
            "libraryName": libraryName,
            "targetName": targetName
        ])

        /// README.swift
        try render(.Package.readme, to: "README.md", in: packagePath, context: [
            "packageName": packageName
        ])

        /// LICENSE
        try render(.Package.License.bsdZeroClause, to: "LICENSE", in: packagePath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
        ])

        /// .gitignore
        try render(.Package.gitignore, to: ".gitignore", in: packagePath, context: [:])

        // Sources/<apiName>/<apiName>.swift
        try render(.API.api, to: "\(apiName).swift", in: apiPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        // Sources/<apiName>/<apiName>Configuration.swift
        try render(.API.configuration, to: "\(apiName)Configuration.swift", in: apiPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName,
            "baseURL": baseURL
        ])

        // Sources/<apiName>/<apiName>Error.swift
        try render(.API.error, to: "\(apiName)Error.swift", in: apiPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        // Sources/<apiName>/<apiName>Scaffolding.swift
        try render(.API.scaffolding, to: "\(apiName)Scaffolding.swift", in: apiPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        // Sources/<apiName>/Scaffolding/<apiName>Logger.swift
        try render(.API.logger, to: "\(apiName)Logger.swift", in: scaffoldingPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        // Sources/<apiName>/Scaffolding/<apiName>RequestBuilder.swift
        try render(.API.requestBuilder, to: "\(apiName)RequestBuilder.swift", in: scaffoldingPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        // Sources/<apiName>/Scaffolding/<apiName>RequestPerformer.swift
        try render(.API.requestPerformer, to: "\(apiName)RequestPerformer.swift", in: scaffoldingPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        // Sources/<apiName>/Scaffolding/<apiName>ResponseValidator.swift
        try render(.API.responseValidator, to: "\(apiName)ResponseValidator.swift", in: scaffoldingPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        // Sources/<apiName>/Scaffolding/Logger+API.swift
        try render(.API.loggerExtension, to: "Logger+API.swift", in: scaffoldingPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "loggerSubsystem": loggerSubsystem,
            "loggerCategory": loggerCategory
        ])

        // Sources/<apiName>/Helpers/HTTPMethod.swift
        try render(.API.httpMethod, to: "HTTPMethod.swift", in: helpersPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
        ])

        // Sources/<apiName>/Helpers/MIMEContentType.swift
        try render(.API.mimeContentType, to: "MIMEContentType.swift", in: helpersPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
        ])

        for request in apiModel.requests {
            // Sources/<apiName>/Requests/<apiName>+<requestName>.swift
            try render(.API.request, to: "\(apiName)+\(request.requestName).swift", in: requestsPath, context: [
                "copyrightYear": copyrightYear,
                "copyrightHolder": copyrightHolder,
                "apiName": apiName,
                "markComment": request.markComment,
                "functionComment": request.functionComment,
                "functionName": request.functionName,
                "httpMethod": request.method.rawValue,
                "endpointPath": request.endpointPath,
                "body": request.body,
                "query": request.query,
                "headers": request.headers,
                "responseName": request.responseName
            ])
        }

        for response in apiModel.responses {
            // Sources/<apiName>/Responses/<responseName>.swift
            try render(.API.response, to: "\(response.responseName).swift", in: responsesPath, context: [:])
        }

        NSWorkspace.shared.open(outputPath.url)
    }

    func render(_ template: Template, to filename: String, in path: Path, context: [String : Any?]) throws {
        let string = try template.render(context: context)
        let filePath = path.appendingComponent(filename)
        try string.write(to: filePath.url, atomically: true, encoding: .utf8)
    }
}
