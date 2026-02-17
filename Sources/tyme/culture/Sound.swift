import Foundation

/// 五音 (Five Sounds)
/// 宫、商、角、徵、羽 - The five tones in Chinese music theory
/// Associated with Five Elements: 土、金、木、火、水
public final class Sound: LoopTyme {
    /// Sound names (五音名称)
    public static let NAMES = ["宫", "商", "角", "徵", "羽"]

    /// WuXing (五行) mapping for sounds
    /// 宫-土, 商-金, 角-木, 徵-火, 羽-水
    private static let WU_XING = ["土", "金", "木", "火", "水"]

    /// Initialize with index
    /// - Parameter index: Sound index (0-4)
    public convenience init(index: Int) {
        self.init(names: Sound.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Sound name (e.g., "宫", "商", etc.)
    public convenience init(name: String) throws {
        try self.init(names: Sound.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Sound from index
    /// - Parameter index: Sound index (0-4)
    /// - Returns: Sound instance
    public static func fromIndex(_ index: Int) -> Sound {
        return Sound(index: index)
    }

    /// Get Sound from name
    /// - Parameter name: Sound name (e.g., "宫", "商", etc.)
    /// - Returns: Sound instance
    public static func fromName(_ name: String) throws -> Sound {
        return try Sound(name: name)
    }

    /// Get next sound
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Sound instance
    public override func next(_ n: Int) -> Sound {
        return Sound.fromIndex(nextIndex(n))
    }

    public var wuXing: String { Sound.WU_XING[index] }
    public var element: Element { try! Element.fromName(Sound.WU_XING[index]) }

    @available(*, deprecated, renamed: "wuXing")
    public func getWuXing() -> String { wuXing }

    @available(*, deprecated, renamed: "element")
    public func getElement() -> Element { element }
}
