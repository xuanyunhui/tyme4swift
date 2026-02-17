import Foundation

/// 月相第几天
public final class PhaseDay: AbstractCultureDay {
    public init(phase: Phase, dayIndex: Int) {
        super.init(culture: phase, dayIndex: dayIndex)
    }

    /// 月相
    public var phase: Phase {
        culture as! Phase
    }

    @available(*, deprecated, renamed: "phase")
    public func getPhase() -> Phase { phase }
}
