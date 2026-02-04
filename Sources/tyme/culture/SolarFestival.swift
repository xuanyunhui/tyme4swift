import Foundation

public final class SolarFestival {
    public static let NAMES = [
        "元旦",      // January 1
        "春节",      // Chinese New Year (Lunar)
        "清明",      // Qingming Festival (April 4-5)
        "端午",      // Dragon Boat Festival (Lunar)
        "中秋",      // Mid-Autumn Festival (Lunar)
        "国庆",      // National Day (October 1)
        "圣诞"       // Christmas (December 25)
    ]
    
    // Solar festival dates (month, day)
    private static let DATES: [(Int, Int)] = [
        (1, 1),      // 元旦
        (2, 10),     // 春节前后 (approximate)
        (4, 5),      // 清明
        (6, 10),     // 端午前后 (approximate)
        (9, 25),     // 中秋前后 (approximate)
        (10, 1),     // 国庆
        (12, 25)     // 圣诞
    ]
    
    public let name: String
    public let month: Int
    public let day: Int
    
    public init(_ index: Int) {
        let boundedIndex = max(0, min(index, SolarFestival.NAMES.count - 1))
        self.name = SolarFestival.NAMES[boundedIndex]
        let date = SolarFestival.DATES[boundedIndex]
        self.month = date.0
        self.day = date.1
    }
    
    public static func fromIndex(_ index: Int) -> SolarFestival {
        SolarFestival(index)
    }
    
    public static func fromName(_ name: String) -> SolarFestival? {
        if let index = NAMES.firstIndex(of: name) {
            return SolarFestival(index)
        }
        return nil
    }
}
