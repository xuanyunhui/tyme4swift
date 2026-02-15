import Foundation

/// 童限（从出生到起运的时间段）
public final class ChildLimit {
    /// 童限计算接口
    public nonisolated(unsafe) static var provider: ChildLimitProvider = DefaultChildLimitProvider()

    private let gender: Gender
    private let forward: Bool
    private let info: ChildLimitInfo

    public init(birthTime: SolarTime, gender: Gender) {
        self.gender = gender
        // 阳男阴女顺推，阴男阳女逆推
        let eightCharProvider = DefaultEightCharProvider()
        let yearSixtyCycle = eightCharProvider.getYearSixtyCycle(year: birthTime.getYear(), month: birthTime.getMonth(), day: birthTime.getDay())
        let yang = yearSixtyCycle.getHeavenStem().getIndex() % 2 == 0
        let man = gender.isMale
        self.forward = (yang && man) || (!yang && !man)

        var term = birthTime.getTerm()
        if !term.isJie() {
            term = term.next(-1)
        }
        if forward {
            term = term.next(2)
        }
        self.info = ChildLimit.provider.getInfo(birthTime: birthTime, term: term)
    }

    public static func fromSolarTime(_ birthTime: SolarTime, _ gender: Gender) -> ChildLimit {
        ChildLimit(birthTime: birthTime, gender: gender)
    }

    public func getGender() -> Gender { gender }
    public func isForward() -> Bool { forward }
    public func getYearCount() -> Int { info.yearCount }
    public func getMonthCount() -> Int { info.monthCount }
    public func getDayCount() -> Int { info.dayCount }
    public func getHourCount() -> Int { info.hourCount }
    public func getMinuteCount() -> Int { info.minuteCount }
    public func getStartTime() -> SolarTime { info.startTime }
    public func getEndTime() -> SolarTime { info.endTime }
    public func getInfo() -> ChildLimitInfo { info }
}
