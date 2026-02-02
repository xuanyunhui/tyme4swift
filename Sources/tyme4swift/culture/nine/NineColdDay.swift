import Foundation

/// 数九天 (Nine Cold Day)
/// Represents a specific day within the nine cold periods
public final class NineColdDay: AbstractCultureDay {
    /// Initialize with nine period and day index
    /// - Parameters:
    ///   - nine: The nine period (一九 to 九九)
    ///   - dayIndex: Day index within the period (0-8)
    public init(nine: Nine, dayIndex: Int) {
        super.init(culture: nine, dayIndex: dayIndex)
    }

    /// Get nine period
    /// - Returns: Nine instance
    public func getNine() -> Nine {
        return culture as! Nine
    }

    /// Get name
    /// - Returns: Nine day name (e.g., "一九第1天")
    public override func getName() -> String {
        return "\(getNine().getName())第\(getDayIndex() + 1)天"
    }

    /// Create from nine period and day index
    /// - Parameters:
    ///   - nine: The nine period
    ///   - dayIndex: Day index within the period
    /// - Returns: NineColdDay instance
    public static func fromNine(_ nine: Nine, _ dayIndex: Int) -> NineColdDay {
        return NineColdDay(nine: nine, dayIndex: dayIndex)
    }
}
