import Foundation

/// 梅雨天 (Plum Rain Day)
/// Represents a specific day within the plum rain season
public final class PlumRainDay: AbstractCultureDay {
    /// Initialize with plum rain and day index
    /// - Parameters:
    ///   - plumRain: The plum rain period (入梅 or 出梅)
    ///   - dayIndex: Day index within the period (0-based)
    public init(plumRain: PlumRain, dayIndex: Int) {
        super.init(culture: plumRain, dayIndex: dayIndex)
    }

    /// Get plum rain period
    /// - Returns: PlumRain instance
    public func getPlumRain() -> PlumRain {
        return culture as! PlumRain
    }

    /// Get name
    /// - Returns: Plum rain day name (e.g., "入梅第1天")
    public override func getName() -> String {
        return "\(getPlumRain().getName())第\(getDayIndex() + 1)天"
    }

    /// Create from plum rain and day index
    /// - Parameters:
    ///   - plumRain: The plum rain period
    ///   - dayIndex: Day index within the period
    /// - Returns: PlumRainDay instance
    public static func fromPlumRain(_ plumRain: PlumRain, _ dayIndex: Int) -> PlumRainDay {
        return PlumRainDay(plumRain: plumRain, dayIndex: dayIndex)
    }
}
