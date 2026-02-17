import Foundation

/// 纳音 (NaYin - Sixty Sounds)
/// The 60 NaYin sounds associated with the 60 SixtyCycle combinations
public final class NaYin: LoopTyme {
    /// NaYin names (六十纳音名称)
    public static let NAMES = [
        "海中金", "炉中火", "大林木", "路旁土", "剑锋金",
        "山头火", "涧下水", "城头土", "白蜡金", "杨柳木",
        "泉中水", "屋上土", "霹雳火", "松柏木", "长流水",
        "沙中金", "山下火", "平地木", "壁上土", "金箔金",
        "覆灯火", "天河水", "大驿土", "钗钏金", "桑柘木",
        "大溪水", "沙中土", "天上火", "石榴木", "大海水"
    ]

    /// WuXing (五行) mapping for NaYin
    private static let WU_XING = [
        "金", "火", "木", "土", "金",
        "火", "水", "土", "金", "木",
        "水", "土", "火", "木", "水",
        "金", "火", "木", "土", "金",
        "火", "水", "土", "金", "木",
        "水", "土", "火", "木", "水"
    ]

    /// Initialize with index
    /// - Parameter index: NaYin index (0-29)
    public convenience init(index: Int) {
        self.init(names: NaYin.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: NaYin name (e.g., "海中金", "炉中火", etc.)
    public convenience init(name: String) throws {
        try self.init(names: NaYin.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        try super.init(names: names, index: index)
    }

    /// Get NaYin from index
    /// - Parameter index: NaYin index (0-29)
    /// - Returns: NaYin instance
    public static func fromIndex(_ index: Int) -> NaYin {
        return NaYin(index: index)
    }

    /// Get NaYin from name
    /// - Parameter name: NaYin name (e.g., "海中金", "炉中火", etc.)
    /// - Returns: NaYin instance
    public static func fromName(_ name: String) throws -> NaYin {
        return try NaYin(name: name)
    }

    /// Get NaYin from SixtyCycle index
    /// - Parameter sixtyCycleIndex: SixtyCycle index (0-59)
    /// - Returns: NaYin instance
    public static func fromSixtyCycle(_ sixtyCycleIndex: Int) -> NaYin {
        return NaYin(index: sixtyCycleIndex / 2)
    }

    /// Get next NaYin
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next NaYin instance
    public override func next(_ n: Int) -> NaYin {
        return NaYin.fromIndex(nextIndex(n))
    }

    /// Get WuXing (五行)
    /// - Returns: Element name (金, 木, 水, 火, 土)
    public func getWuXing() -> String {
        return NaYin.WU_XING[index]
    }

    /// Get Element instance
    /// - Returns: Element instance
    public func getElement() -> Element {
        return try! Element.fromName(NaYin.NAMES[index])
    }
}
