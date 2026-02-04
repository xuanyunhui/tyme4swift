import Foundation

public protocol Culture {
    func getName() -> String
}

public extension Culture {
    var name: String { getName() }
}
