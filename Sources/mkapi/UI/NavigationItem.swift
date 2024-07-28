import Foundation

enum NavigationItem: Identifiable, Hashable, CustomStringConvertible {

    case package
    case configuration(ConfigurationModel)
    case request(RequestModel)

    var id: Self { self }

    var description: String { title }

    var title: String {
        switch self {
        case .package: "Package"
        case .configuration(let configuration): configuration.title
        case .request(let request): request.title
        }
    }

    var subtitle: String {
        switch self {
        case .package: "API package setup"
        case .configuration(let configuration): configuration.propertyComment.orIfEmpty(configuration.propertyName)
        case .request(let request): request.functionComment.orIfEmpty(request.functionName)
        }
    }

    var icon: String {
        switch self {
        case .package: "shippingbox"
        case .configuration: "server.rack"
        case .request: "arrow.left.arrow.right"
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case .package: hasher.combine("Package")
        case .configuration(let configuration): hasher.combine("configuration(\(configuration.id.uuidString))")
        case .request(let request): hasher.combine("request(\(request.id.uuidString))")
        }
    }

    static func == (lhs: NavigationItem, rhs: NavigationItem) -> Bool {
        switch (lhs, rhs) {
        case (.package, .package): true
        case (.configuration(let a), .configuration(let b)): a.id == b.id
        case (.request(let a), .request(let b)): a.id == b.id
        default: false
        }
    }

}
