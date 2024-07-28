import Foundation
import AppKit
import OSLog
import TemplateKit
import SystemKit
import TextToolbox

class APIGenerator {
    func generateAPI(for apiModel: APIModel) throws {

        let copyrightHolder = apiModel.copyrightHolder.orIfEmpty("Unknown, Inc.")
        let copyrightYear = apiModel.copyrightYear.orIfEmpty(String(Date.currentYear))
        let apiName = apiModel.apiName.orIfEmpty("UntitledAPI")

        // Package
        let swiftVersion = apiModel.swiftVersion.orIfEmpty("5.10")
        let repositoryName = apiModel.repositoryName.orIfEmpty(apiName)
        let packageName = apiModel.packageName.orIfEmpty(apiName)
        let libraryName = apiName
        let targetName = apiName

        let loggerSubsystem = "TODO"
        let loggerCategory = apiName

        let outputPath = Path("/tmp/mkapi")
        let packagePath = outputPath.appendingComponent(repositoryName)

        let sourcesPath = packagePath.appendingComponent("Sources")
        let apiPath = sourcesPath.appendingComponent(apiName)
        let configurationsPath = apiPath.appendingComponent("Configurations")
        let requestsPath = apiPath.appendingComponent("Requests")
        let responsesPath = apiPath.appendingComponent("Responses")
        let scaffoldingPath = apiPath.appendingComponent("Scaffolding")
        let helpersPath = apiPath.appendingComponent("Helpers")

        if packagePath.exists {
            try packagePath.remove()
        }
        try configurationsPath.createDirectory(withIntermediateDirectories: true)
        try requestsPath.createDirectory(withIntermediateDirectories: true)
        try responsesPath.createDirectory(withIntermediateDirectories: true)
        try scaffoldingPath.createDirectory(withIntermediateDirectories: true)
        try helpersPath.createDirectory(withIntermediateDirectories: true)

        Logger.apiGenerator.trace("Generating Package")
        /// Package.swift
        try render(.Package.package, to: "Package.swift", in: packagePath, context: [
            "swiftVersion": swiftVersion,
            "packageName": packageName,
            "libraryName": libraryName,
            "targetName": targetName
        ])

        Logger.apiGenerator.trace("Generating README")
        /// README.swift
        try render(.Package.readme, to: "README.md", in: packagePath, context: [
            "packageName": packageName
        ])

        Logger.apiGenerator.trace("Generating LICENSE")
        /// LICENSE
        try render(.Package.License.bsdZeroClause, to: "LICENSE", in: packagePath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
        ])

        Logger.apiGenerator.trace("Generating .gitignore")
        /// .gitignore
        try render(.Package.gitignore, to: ".gitignore", in: packagePath, context: [:])

        Logger.apiGenerator.trace("Generating \(apiName)")
        // Sources/<apiName>/<apiName>.swift
        try render(.API.api, to: "\(apiName).swift", in: apiPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        Logger.apiGenerator.trace("Generating \(apiName)Error")
        // Sources/<apiName>/<apiName>Error.swift
        try render(.API.error, to: "\(apiName)Error.swift", in: apiPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        Logger.apiGenerator.trace("Generating \(apiName)Scaffolding")
        // Sources/<apiName>/<apiName>Scaffolding.swift
        try render(.API.scaffolding, to: "\(apiName)Scaffolding.swift", in: apiPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        Logger.apiGenerator.trace("Generating \(apiName)Configuration")
        // Sources/<apiName>/Scaffolding/<apiName>Configuration.swift
        try render(.API.configuration, to: "\(apiName)Configuration.swift", in: scaffoldingPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        Logger.apiGenerator.trace("Generating \(apiName)Logger")
        // Sources/<apiName>/Scaffolding/<apiName>Logger.swift
        try render(.API.logger, to: "\(apiName)Logger.swift", in: scaffoldingPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        Logger.apiGenerator.trace("Generating \(apiName)RequestBuilder")
        // Sources/<apiName>/Scaffolding/<apiName>RequestBuilder.swift
        try render(.API.requestBuilder, to: "\(apiName)RequestBuilder.swift", in: scaffoldingPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        Logger.apiGenerator.trace("Generating \(apiName)RequestPerformer")
        // Sources/<apiName>/Scaffolding/<apiName>RequestPerformer.swift
        try render(.API.requestPerformer, to: "\(apiName)RequestPerformer.swift", in: scaffoldingPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        Logger.apiGenerator.trace("Generating \(apiName)ResponseValidator")
        // Sources/<apiName>/Scaffolding/<apiName>ResponseValidator.swift
        try render(.API.responseValidator, to: "\(apiName)ResponseValidator.swift", in: scaffoldingPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "apiName": apiName
        ])

        Logger.apiGenerator.trace("Generating Logger+API")
        // Sources/<apiName>/Scaffolding/Logger+API.swift
        try render(.API.loggerExtension, to: "Logger+API.swift", in: scaffoldingPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
            "loggerSubsystem": loggerSubsystem,
            "loggerCategory": loggerCategory
        ])

        Logger.apiGenerator.trace("Generating HTTPMethod")
        // Sources/<apiName>/Helpers/HTTPMethod.swift
        try render(.API.httpMethod, to: "HTTPMethod.swift", in: helpersPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
        ])

        Logger.apiGenerator.trace("Generating MIMEContentType")
        // Sources/<apiName>/Helpers/MIMEContentType.swift
        try render(.API.mimeContentType, to: "MIMEContentType.swift", in: helpersPath, context: [
            "copyrightYear": copyrightYear,
            "copyrightHolder": copyrightHolder,
        ])

        Logger.apiGenerator.trace("Generating configurations")
        for configuration in apiModel.configurations {
            // Sources/<apiName>/Configurations/<apiName>Configuration+<propertyName>.swift
            try render(.API.configurationExtension, to: "\(apiName)Configuration+\(configuration.propertyName.capitalizingFirstLetter()).swift", in: configurationsPath, context: [
                "copyrightYear": copyrightYear,
                "copyrightHolder": copyrightHolder,
                "apiName": apiName,
                "title": configuration.title,
                "propertyComment": configuration.propertyComment.orIfEmpty(configuration.title),
                "propertyName": configuration.propertyName,
                "baseURL": configuration.baseURL.orIfEmpty("https://localhost")
            ])
        }

        Logger.apiGenerator.trace("Generating requests")
        for request in apiModel.requests {
            // Sources/<apiName>/Requests/<apiName>+<functionName>.swift
            try render(.API.request, to: "\(apiName)+\(request.functionName.capitalizingFirstLetter()).swift", in: requestsPath, context: [
                "copyrightYear": copyrightYear,
                "copyrightHolder": copyrightHolder,
                "apiName": apiName,
                "markComment": request.markComment,
                "functionComment": request.functionComment.orIfEmpty(request.title),
                "functionName": request.functionName,
                "httpMethod": request.method.caseName,
                "path": request.endpointPath.orIfEmpty("/\(request.functionName)"),
                "body": nil, //request.body,
                "query": "[:]", //request.query,
                "headers": "[:]", //request.headers,
                "responseName": request.responseName
            ])
        }

        Logger.apiGenerator.trace("Generating responses")
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

extension Logger {
    static let apiGenerator = Logger(subsystem: "io.apparata.mkapi", category: "APIGenerator")
}
