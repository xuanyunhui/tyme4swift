import Foundation

public protocol Tyme: Culture {
    func next(_ n: Int) -> Self
}
