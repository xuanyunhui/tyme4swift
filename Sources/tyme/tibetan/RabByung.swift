import Foundation

/// 绕迥 (RabByung - Tibetan 60-year cycle)
/// The Tibetan calendar uses a 60-year cycle similar to the Chinese calendar
/// Each cycle is called a RabByung (绕迥)
public final class RabByung: LoopTyme {
    /// RabByung names (绕迥名称)
    /// The 60-year cycle names in Tibetan tradition
    public static let NAMES = [
        "火兔", "土龙", "土蛇", "金马", "金羊",
        "水猴", "水鸡", "木狗", "木猪", "火鼠",
        "火牛", "土虎", "土兔", "金龙", "金蛇",
        "水马", "水羊", "木猴", "木鸡", "火狗",
        "火猪", "土鼠", "土牛", "金虎", "金兔",
        "水龙", "水蛇", "木马", "木羊", "火猴",
        "火鸡", "土狗", "土猪", "金鼠", "金牛",
        "水虎", "水兔", "木龙", "木蛇", "火马",
        "火羊", "土猴", "土鸡", "金狗", "金猪",
        "水鼠", "水牛", "木虎", "木兔", "火龙",
        "火蛇", "土马", "土羊", "金猴", "金鸡",
        "水狗", "水猪", "木鼠", "木牛", "火虎"
    ]

    /// Element names (五行名称)
    public static let ELEMENTS = ["木", "火", "土", "金", "水"]

    /// Animal names (生肖名称)
    public static let ANIMALS = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"]

    /// Initialize with index
    /// - Parameter index: RabByung index (0-59)
    public convenience init(index: Int) {
        self.init(names: RabByung.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: RabByung name (e.g., "火兔", "土龙", etc.)
    public convenience init(name: String) {
        self.init(names: RabByung.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get RabByung from index
    /// - Parameter index: RabByung index (0-59)
    /// - Returns: RabByung instance
    public static func fromIndex(_ index: Int) -> RabByung {
        return RabByung(index: index)
    }

    /// Get RabByung from name
    /// - Parameter name: RabByung name (e.g., "火兔", "土龙", etc.)
    /// - Returns: RabByung instance
    public static func fromName(_ name: String) -> RabByung {
        return RabByung(name: name)
    }

    /// Get next RabByung
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next RabByung instance
    public override func next(_ n: Int) -> RabByung {
        return RabByung.fromIndex(nextIndex(n))
    }

    /// Get element (五行)
    /// - Returns: Element name
    public func getElement() -> String {
        return RabByung.ELEMENTS[(index / 2) % 5]
    }

    /// Get animal (生肖)
    /// - Returns: Animal name
    public func getAnimal() -> String {
        return RabByung.ANIMALS[index % 12]
    }
}
