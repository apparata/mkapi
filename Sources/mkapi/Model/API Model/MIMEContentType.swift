import Foundation

public enum MIMEContentType {

    case text
    case html
    case json
    case xml
    case form
    case multipart(boundary: String)
    case binary
    case other(String)

    public var isText: Bool {
        if case .text = self {
            return true
        } else {
            return false
        }
    }

    public var isHTML: Bool {
        if case .html = self {
            return true
        } else {
            return false
        }
    }

    public var isJSON: Bool {
        if case .json = self {
            return true
        } else {
            return false
        }
    }

    var isXml: Bool {
        if case .xml = self {
            return true
        } else {
            return false
        }
    }

    public var isForm: Bool {
        if case .form = self {
            return true
        } else {
            return false
        }
    }

    public var isMultipart: Bool {
        if case .multipart = self {
            return true
        } else {
            return false
        }
    }

    public var isBinary: Bool {
        if case .binary = self {
            return true
        } else {
            return false
        }
    }

    public var isOther: Bool {
        if case .other = self {
            return true
        } else {
            return false
        }
    }

    public init(mimeType: String?) {
        guard let mimeType = mimeType else {
            self = .other("text/plain")
            return
        }

        let components = mimeType.split(separator: ";").map {
            $0.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        switch components[0] {
        case "text/plain": self = .text
        case "text/html": self = .html
        case "application/json": self = .json
        case "application/xml": self = .xml
        case "application/x-www-form-urlencoded": self = .form
        case "application/octet-stream": self = .binary
        default:
            if components[0].hasPrefix("multipart/") {
                guard let boundaryString = components.first(where: { $0.hasPrefix("boundary=") }) else {
                    self = .multipart(boundary: "")
                    return
                }
                self = .multipart(boundary: String(boundaryString).chomping(left: "boundary="))
            } else {
                self = .other(mimeType)
            }
        }
    }

    public var asString: String {
        switch self {
        case .text: return "text/plain; charset=utf-8"
        case .html: return "text/html; charset=utf-8"
        case .json: return "application/json; charset=utf-8"
        case .xml: return "application/xml; charset=utf-8"
        case .form: return "application/x-www-form-urlencoded; charset=utf-8"
        case .binary: return "application/octet-stream"
        case .multipart(let boundary): return "multipart/form-data; boundary=\(boundary)"
        case .other(let mimeType): return mimeType
        }
    }
}

fileprivate extension String {
    func chomping(left prefix: String) -> String {
        if let prefixRange = range(of: prefix) {
            if prefixRange.upperBound >= endIndex {
                return String(self[startIndex..<prefixRange.lowerBound])
            } else {
                return String(self[prefixRange.upperBound..<endIndex])
            }
        }
        return self
    }
}
