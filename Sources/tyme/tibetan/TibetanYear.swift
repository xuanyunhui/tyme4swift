import Foundation

/// 藏历年 (Tibetan Year)
/// Represents a year in the Tibetan calendar
public final class TibetanYear: AbstractCulture {
    /// The first RabByung cycle started in 1027 CE
    public static let FIRST_RABBYUNG_YEAR = 1027

    public let year: Int
    public let rabByungCycle: Int
    public let rabByungIndex: Int

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

    public var rabByung: RabByung { RabByung.fromIndex(rabByungIndex) }

    public var element: String { rabByung.element }

    public var animal: String { rabByung.animal }

    /// Get name
    /// - Returns: Tibetan year name (e.g., "第17绕迥火兔年")
    public override func getName() -> String {
        return "第\(rabByungCycle)绕迥\(rabByung.getName())年"
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

    @available(*, deprecated, renamed: "year")
    public func getYear() -> Int { year }

    @available(*, deprecated, renamed: "rabByungCycle")
    public func getRabByungCycle() -> Int { rabByungCycle }

    @available(*, deprecated, renamed: "rabByungIndex")
    public func getRabByungIndex() -> Int { rabByungIndex }

    @available(*, deprecated, renamed: "rabByung")
    public func getRabByung() -> RabByung { rabByung }

    @available(*, deprecated, renamed: "element")
    public func getElement() -> String { element }

    @available(*, deprecated, renamed: "animal")
    public func getAnimal() -> String { animal }
}
