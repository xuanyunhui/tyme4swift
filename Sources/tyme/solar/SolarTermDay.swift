import Foundation

public final class SolarTermDay: AbstractCultureDay {
    public init(_ solarTerm: SolarTerm, _ dayIndex: Int) {
        super.init(culture: solarTerm, dayIndex: dayIndex)
    }

    public var solarTerm: SolarTerm {
        guard let result = culture as? SolarTerm else {
            preconditionFailure("SolarTermDay: unexpected culture type")
        }
        return result
    }

    @available(*, deprecated, renamed: "solarTerm")
    public func getSolarTerm() -> SolarTerm { solarTerm }
}
