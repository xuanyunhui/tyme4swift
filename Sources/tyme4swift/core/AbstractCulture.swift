import Foundation

open class AbstractCulture: Culture, CustomStringConvertible {
    public init() {}

    open func getName() -> String {
        fatalError("Subclasses must override getName()")
    }

    public var description: String {
        getName()
    }

    internal func indexOf(_ index: Int, _ size: Int) -> Int {
        var i = index % size
        if i < 0 { i += size }
        return i
    }
}
