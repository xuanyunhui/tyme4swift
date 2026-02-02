import Foundation

public final class LunarFestival {
    public static let NAMES = [
        "春节",      // Lunar New Year
        "元宵",      // Lantern Festival (15th day of 1st lunar month)
        "清明",      // Qingming Festival  
        "端午",      // Dragon Boat Festival (5th day of 5th lunar month)
        "七夕",      // Qixi Festival (7th day of 7th lunar month)
        "中秋",      // Mid-Autumn Festival (15th day of 8th lunar month)
        "重阳",      // Double Ninth Festival (9th day of 9th lunar month)
        "冬至"       // Winter Solstice Festival
    ]
    
    // Lunar festival dates (lunar month, lunar day)
    private static let DATES: [(Int, Int)] = [
        (1, 1),      // 春节
        (1, 15),     // 元宵
        (3, 3),      // 清明 (approximately)
        (5, 5),      // 端午
        (7, 7),      // 七夕
        (8, 15),     // 中秋
        (9, 9),      // 重阳
        (12, 30)     // 冬至 (last day of year or 11/30)
    ]
    
    public let name: String
    public let lunarMonth: Int
    public let lunarDay: Int
    
    public init(_ index: Int) {
        let boundedIndex = max(0, min(index, LunarFestival.NAMES.count - 1))
        self.name = LunarFestival.NAMES[boundedIndex]
        let date = LunarFestival.DATES[boundedIndex]
        self.lunarMonth = date.0
        self.lunarDay = date.1
    }
    
    public static func fromIndex(_ index: Int) -> LunarFestival {
        LunarFestival(index)
    }
    
    public static func fromName(_ name: String) -> LunarFestival? {
        if let index = NAMES.firstIndex(of: name) {
            return LunarFestival(index)
        }
        return nil
    }
}
