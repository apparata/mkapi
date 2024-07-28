import Foundation

struct NavigationItem: Identifiable, Hashable, CustomStringConvertible {

    let id: String
    let title: String
    let subtitle: String?
    let icon: String

    var description: String { title }

    init(id: String, title: String, subtitle: String? = nil, icon: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
    }
}
