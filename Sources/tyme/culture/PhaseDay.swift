import Foundation

/// 月相第几天
public final class PhaseDay: AbstractCultureDay {
    public init(phase: Phase, dayIndex: Int) {
        super.init(culture: phase, dayIndex: dayIndex)
    }

    /// 月相
    public var phase: Phase {
        guard let result = culture as? Phase else {
            preconditionFailure("PhaseDay: unexpected culture type")
        }
        return result
    }

    @available(*, deprecated, renamed: "phase")
    public func getPhase() -> Phase { phase }
}
