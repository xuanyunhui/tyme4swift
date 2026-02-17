import Foundation

/// 饶迥五行 (Rab-byung Element)
/// Tibetan calendar element system using 铁 (iron) instead of 金 (metal)
public final class RabByungElement: AbstractCulture {
    /// Element names in Tibetan calendar (金→铁)
    public static let NAMES = ["木", "火", "土", "铁", "水"]

    /// Internal element (uses standard Element)
    private let element: Element

    /// Initialize with index
    /// - Parameter index: Element index (0-4)
    public init(index: Int) {
        self.element = Element.fromIndex(index)
        super.init()
    }

    /// Initialize with name
    /// - Parameter name: Element name (支持 "铁" 或 "金")
    public init(name: String) {
        // Convert 铁 to 金 for internal Element
        let elementName = name.replacingOccurrences(of: "铁", with: "金")
        self.element = Element.fromName(elementName)
        super.init()
    }

    /// Create from index
    /// - Parameter index: Element index
    /// - Returns: RabByungElement instance
    public static func fromIndex(_ index: Int) -> RabByungElement {
        return RabByungElement(index: index)
    }

    /// Create from name
    /// - Parameter name: Element name
    /// - Returns: RabByungElement instance
    public static func fromName(_ name: String) -> RabByungElement {
        return RabByungElement(name: name)
    }

    /// Get element name (金→铁)
    /// - Returns: Element name with 铁 instead of 金
    public override func getName() -> String {
        return element.getName().replacingOccurrences(of: "金", with: "铁")
    }

    /// Get element index
    /// - Returns: Element index (0-4)
    public func getIndex() -> Int {
        return element.getIndex()
    }

    /// Get next element in cycle
    /// - Parameter n: Steps to advance (can be negative)
    /// - Returns: Next RabByungElement
    public func next(_ n: Int) -> RabByungElement {
        let nextElement = element.next(n)
        return RabByungElement(index: nextElement.getIndex())
    }

    // MARK: - Five Elements Relationships (五行生克)

    /// Get element that this generates (我生者)
    /// - Returns: Element I reinforce
    public func getReinforce() -> RabByungElement {
        return next(1)
    }

    /// Get element that this restrains (我克者)
    /// - Returns: Element I restrain
    public func getRestrain() -> RabByungElement {
        return next(2)
    }

    /// Get element that generates this (生我者)
    /// - Returns: Element that reinforces me
    public func getReinforced() -> RabByungElement {
        return next(-1)
    }

    /// Get element that restrains this (克我者)
    /// - Returns: Element that restrains me
    public func getRestrained() -> RabByungElement {
        return next(-2)
    }
}
