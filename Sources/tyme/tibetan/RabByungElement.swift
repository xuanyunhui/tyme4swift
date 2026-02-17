import Foundation

/// 饶迥五行 (Rab-byung Element)
/// Tibetan calendar element system using 铁 (iron) instead of 金 (metal)
public final class RabByungElement: AbstractCulture {
    /// Element names in Tibetan calendar (金→铁)
    public static let NAMES = ["木", "火", "土", "铁", "水"]

    /// Internal element (uses standard Element)
    public let element: Element

    /// Initialize with index
    /// - Parameter index: Element index (0-4)
    public init(index: Int) throws {
        self.element = Element.fromIndex(index)
        super.init()
    }

    /// Initialize with name
    /// - Parameter name: Element name (支持 "铁" 或 "金")
    public init(name: String) throws {
        // Convert 铁 to 金 for internal Element
        let elementName = name.replacingOccurrences(of: "铁", with: "金")
        self.element = try Element.fromName(elementName)
        super.init()
    }

    /// Create from index
    public static func fromIndex(_ index: Int) throws -> RabByungElement { try RabByungElement(index: index) }

    /// Create from name
    public static func fromName(_ name: String) throws -> RabByungElement { try RabByungElement(name: name) }

    /// Get element name (金→铁)
    public override func getName() -> String {
        return element.getName().replacingOccurrences(of: "金", with: "铁")
    }

    /// The element index
    public var index: Int { element.index }

    /// Get next element in cycle
    public func next(_ n: Int) -> RabByungElement {
        let nextElement = element.next(n)
        return try! RabByungElement(index: nextElement.index)
    }

    // MARK: - Five Elements Relationships (五行生克)

    /// The element that this generates (我生者)
    public var reinforce: RabByungElement { next(1) }

    /// The element that this restrains (我克者)
    public var restrain: RabByungElement { next(2) }

    /// The element that generates this (生我者)
    public var reinforced: RabByungElement { next(-1) }

    /// The element that restrains this (克我者)
    public var restrained: RabByungElement { next(-2) }

    @available(*, deprecated, renamed: "index")
    public func getIndex() -> Int { index }

    @available(*, deprecated, renamed: "reinforce")
    public func getReinforce() -> RabByungElement { reinforce }

    @available(*, deprecated, renamed: "restrain")
    public func getRestrain() -> RabByungElement { restrain }

    @available(*, deprecated, renamed: "reinforced")
    public func getReinforced() -> RabByungElement { reinforced }

    @available(*, deprecated, renamed: "restrained")
    public func getRestrained() -> RabByungElement { restrained }
}
