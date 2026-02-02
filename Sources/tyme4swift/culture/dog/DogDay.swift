import Foundation

/// 伏日 (Dog Day)
/// Represents a specific day within the dog days period
public final class DogDay: AbstractCultureDay {
    /// Initialize with dog period and day index
    /// - Parameters:
    ///   - dog: The dog period (初伏, 中伏, 末伏)
    ///   - dayIndex: Day index within the period (0-based)
    public init(dog: Dog, dayIndex: Int) {
        super.init(culture: dog, dayIndex: dayIndex)
    }

    /// Get dog period
    /// - Returns: Dog instance
    public func getDog() -> Dog {
        return culture as! Dog
    }

    /// Get name
    /// - Returns: Dog day name (e.g., "初伏第1天")
    public override func getName() -> String {
        return "\(getDog().getName())第\(getDayIndex() + 1)天"
    }

    /// Create from dog period and day index
    /// - Parameters:
    ///   - dog: The dog period
    ///   - dayIndex: Day index within the period
    /// - Returns: DogDay instance
    public static func fromDog(_ dog: Dog, _ dayIndex: Int) -> DogDay {
        return DogDay(dog: dog, dayIndex: dayIndex)
    }
}
