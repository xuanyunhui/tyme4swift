import Foundation

public final class SolarTermDay: AbstractCultureDay {
    public init(_ solarTerm: SolarTerm, _ dayIndex: Int) {
        super.init(culture: solarTerm, dayIndex: dayIndex)
    }

    public func getSolarTerm() -> SolarTerm {
        culture as! SolarTerm
    }
}
