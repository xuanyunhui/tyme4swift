import Foundation

open class AbstractCulture: Culture, CustomStringConvertible {
    public init() {}

    open func getName() -> String {
        fatalError("Subclasses must override getName()")
    }

    public var description: String {
        getName()
    }
}
