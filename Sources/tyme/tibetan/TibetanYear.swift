import Foundation

/// 藏历年 (Tibetan Year)
/// Represents a year in the Tibetan calendar
public final class TibetanYear: AbstractCulture {
    /// The first RabByung cycle started in 1027 CE
    public static let FIRST_RABBYUNG_YEAR = 1027

    private let year: Int
    private let rabByungCycle: Int
    private let rabByungIndex: Int

    /// Initialize with year
    /// - Parameter year: The year in Gregorian calendar
    public init(year: Int) {
        self.year = year

        // Calculate RabByung cycle and index
        // First RabByung started in 1027 CE
        let yearsFromFirst = year - TibetanYear.FIRST_RABBYUNG_YEAR
        if yearsFromFirst >= 0 {
            self.rabByungCycle = yearsFromFirst / 60 + 1
            self.rabByungIndex = yearsFromFirst % 60
        } else {
            self.rabByungCycle = (yearsFromFirst + 1) / 60
            var idx = yearsFromFirst % 60
            if idx < 0 { idx += 60 }
            self.rabByungIndex = idx
        }

        super.init()
    }

    /// Get year
    /// - Returns: Year value
    public func getYear() -> Int {
        return year
    }

    /// Get RabByung cycle number
    /// - Returns: Cycle number (1-based)
    public func getRabByungCycle() -> Int {
        return rabByungCycle
    }

    /// Get RabByung index within cycle
    /// - Returns: Index (0-59)
    public func getRabByungIndex() -> Int {
        return rabByungIndex
    }

    /// Get RabByung
    /// - Returns: RabByung instance
    public func getRabByung() -> RabByung {
        return RabByung.fromIndex(rabByungIndex)
    }

    /// Get name
    /// - Returns: Tibetan year name (e.g., "第17绕迥火兔年")
    public override func getName() -> String {
        return "第\(rabByungCycle)绕迥\(getRabByung().getName())年"
    }

    /// Get element (五行)
    /// - Returns: Element name
    public func getElement() -> String {
        return getRabByung().getElement()
    }

    /// Get animal (生肖)
    /// - Returns: Animal name
    public func getAnimal() -> String {
        return getRabByung().getAnimal()
    }

    /// Get next Tibetan year
    /// - Parameter n: Number of years to advance
    /// - Returns: Next TibetanYear instance
    public func next(_ n: Int) -> TibetanYear {
        return TibetanYear(year: year + n)
    }

    /// Create from year
    /// - Parameter year: The year in Gregorian calendar
    /// - Returns: TibetanYear instance
    public static func fromYear(_ year: Int) -> TibetanYear {
        return TibetanYear(year: year)
    }
}
