import Foundation

public final class LegalHoliday {
    public static let NAMES = [
        "元旦",           // New Year's Day
        "春节",           // Spring Festival (Chinese New Year) 
        "清明",           // Qingming Festival
        "劳动节",         // Labor Day (May 1)
        "端午",           // Dragon Boat Festival
        "中秋",           // Mid-Autumn Festival
        "国庆"            // National Day (October 1-7)
    ]
    
    // Legal holidays with dates (month, day) - Solar calendar
    private static let DATES: [(Int, Int)] = [
        (1, 1),          // 元旦
        (2, 10),         // 春节 (approx, varies by year)
        (4, 5),          // 清明
        (5, 1),          // 劳动节
        (6, 10),         // 端午 (approx, varies by year)
        (9, 25),         // 中秋 (approx, varies by year)
        (10, 1)          // 国庆
    ]
    
    // Holiday durations (days)
    private static let DURATIONS = [1, 7, 3, 3, 3, 3, 7]
    
    public let name: String
    public let month: Int
    public let day: Int
    public let duration: Int  // Number of days
    
    public init(_ index: Int) {
        let boundedIndex = max(0, min(index, LegalHoliday.NAMES.count - 1))
        self.name = LegalHoliday.NAMES[boundedIndex]
        let date = LegalHoliday.DATES[boundedIndex]
        self.month = date.0
        self.day = date.1
        self.duration = LegalHoliday.DURATIONS[boundedIndex]
    }
    
    public static func fromIndex(_ index: Int) -> LegalHoliday {
        LegalHoliday(index)
    }
    
    public static func fromName(_ name: String) -> LegalHoliday? {
        if let index = NAMES.firstIndex(of: name) {
            return LegalHoliday(index)
        }
        return nil
    }
}
