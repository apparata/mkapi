import Foundation

extension String {

    public func orIfEmpty(_ string: String, trimmed: Bool = true) -> String {
        if trimmed {
            if trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return string
            } else {
                return self
            }
        } else {
            if isEmpty {
                return string
            } else {
                return self
            }
        }
    }
}
