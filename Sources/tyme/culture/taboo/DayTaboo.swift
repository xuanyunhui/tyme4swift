import Foundation

/// 日宜忌 (Day Taboo)
/// Auspicious and inauspicious activities for a specific day
public final class DayTaboo: AbstractCulture {
    public let auspicious: [String]
    public let inauspicious: [String]

    /// Initialize with auspicious and inauspicious activities
    /// - Parameters:
    ///   - auspicious: List of auspicious activities
    ///   - inauspicious: List of inauspicious activities
    public init(auspicious: [String], inauspicious: [String]) {
        self.auspicious = auspicious
        self.inauspicious = inauspicious
        super.init()
    }

    /// Get name
    /// - Returns: Summary of taboos
    public override func getName() -> String {
        return "宜:\(auspicious.joined(separator: " ")) 忌:\(inauspicious.joined(separator: " "))"
    }

    public var taboos: [Taboo] {
        var result: [Taboo] = []
        for name in auspicious { result.append(Taboo.auspicious(name)) }
        for name in inauspicious { result.append(Taboo.inauspicious(name)) }
        return result
    }

    @available(*, deprecated, renamed: "auspicious")
    public func getAuspicious() -> [String] { auspicious }

    @available(*, deprecated, renamed: "inauspicious")
    public func getInauspicious() -> [String] { inauspicious }

    @available(*, deprecated, renamed: "taboos")
    public func getTaboos() -> [Taboo] { taboos }

    /// Check if an activity is auspicious
    /// - Parameter activity: Activity name
    /// - Returns: true if auspicious
    public func isAuspicious(_ activity: String) -> Bool {
        return auspicious.contains(activity)
    }

    /// Check if an activity is inauspicious
    /// - Parameter activity: Activity name
    /// - Returns: true if inauspicious
    public func isInauspicious(_ activity: String) -> Bool {
        return inauspicious.contains(activity)
    }
}
