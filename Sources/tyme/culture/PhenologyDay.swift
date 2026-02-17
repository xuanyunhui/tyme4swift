import Foundation

/// 物候日 (Phenology Day)
/// Represents a specific day within a phenology period
public final class PhenologyDay: AbstractCultureDay {
    /// Initialize with phenology and day index
    /// - Parameters:
    ///   - phenology: The phenology period
    ///   - dayIndex: Day index within the period (0-based)
    public init(phenology: Phenology, dayIndex: Int) {
        super.init(culture: phenology, dayIndex: dayIndex)
    }

    /// Get phenology
    /// - Returns: Phenology instance
    public func getPhenology() -> Phenology {
        return culture as! Phenology
    }
}
