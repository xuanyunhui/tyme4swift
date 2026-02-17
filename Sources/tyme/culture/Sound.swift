import Foundation

/// 纳音 (Sound / NaYin Sound)
///
/// Represents the 30 NaYin (纳音) sound names associated with the 60 sexagenary cycle elements.
/// Each pair of consecutive sexagenary cycle elements shares the same NaYin sound,
/// yielding 30 distinct sounds in total.
///
/// Note: This corresponds to Java's `Sound` class, which represents 纳音 (not to be confused
/// with the Five Sounds 五音 system of Chinese music theory).
public final class Sound: LoopTyme {
    /// Sound names (三十纳音名称)
    public static let NAMES = [
        "海中金", "炉中火", "大林木", "路旁土", "剑锋金",
        "山头火", "涧下水", "城头土", "白蜡金", "杨柳木",
        "泉中水", "屋上土", "霹雳火", "松柏木", "长流水",
        "沙中金", "山下火", "平地木", "壁上土", "金箔金",
        "覆灯火", "天河水", "大驿土", "钗钏金", "桑柘木",
        "大溪水", "沙中土", "天上火", "石榴木", "大海水"
    ]

    /// Five-element (五行) mapping for NaYin sounds
    private static let WU_XING = [
        "金", "火", "木", "土", "金",
        "火", "水", "土", "金", "木",
        "水", "土", "火", "木", "水",
        "金", "火", "木", "土", "金",
        "火", "水", "土", "金", "木",
        "水", "土", "火", "木", "水"
    ]

    /// Initialize with index
    /// - Parameter index: Sound index (0-29)
    public convenience init(index: Int) {
        self.init(names: Sound.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Sound name (e.g., "海中金", "炉中火", etc.)
    public convenience init(name: String) throws {
        try self.init(names: Sound.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Sound from index
    /// - Parameter index: Sound index (0-29)
    /// - Returns: Sound instance
    public static func fromIndex(_ index: Int) -> Sound {
        return Sound(index: index)
    }

    /// Get Sound from name
    /// - Parameter name: Sound name (e.g., "海中金", "炉中火", etc.)
    /// - Returns: Sound instance
    public static func fromName(_ name: String) throws -> Sound {
        return try Sound(name: name)
    }

    /// Get next Sound
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Sound instance
    public override func next(_ n: Int) -> Sound {
        return Sound.fromIndex(nextIndex(n))
    }

    /// The Five-element (五行) name associated with this NaYin sound
    public var wuXing: String { Sound.WU_XING[index] }

    /// The Element (五行) associated with this NaYin sound
    public var element: Element { try! Element.fromName(Sound.WU_XING[index]) }
}
