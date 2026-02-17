import Foundation

/// 藏干日 (Hidden Heaven Stem Day)
/// Represents a specific day within a hidden heaven stem period
public final class HideHeavenStemDay: AbstractCultureDay {
    /// Initialize with hidden heaven stem and day index
    /// - Parameters:
    ///   - hideHeavenStem: The hidden heaven stem
    ///   - dayIndex: Day index within the period (0-based)
    public init(hideHeavenStem: HideHeavenStem, dayIndex: Int) {
        super.init(culture: hideHeavenStem, dayIndex: dayIndex)
    }

    /// Get hidden heaven stem
    public var hideHeavenStem: HideHeavenStem { culture as! HideHeavenStem }

    /// Get name
    /// - Returns: Heaven stem name + element name (e.g., "癸水")
    public override func getName() -> String {
        let hs = hideHeavenStem.heavenStem
        return hs.getName() + hs.wuXing
    }

    /// String description
    /// - Returns: Formatted string (e.g., "癸水第1天")
    public override var description: String {
        return "\(getName())第\(dayIndex + 1)天"
    }

    @available(*, deprecated, renamed: "hideHeavenStem")
    public func getHideHeavenStem() -> HideHeavenStem { hideHeavenStem }
}
