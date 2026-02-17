import Foundation

/// 童限（从出生到起运的时间段）
public final class ChildLimit {
    /// 童限计算接口
    public nonisolated(unsafe) static var provider: ChildLimitProvider = DefaultChildLimitProvider()

    public let gender: Gender
    public let forward: Bool
    public let info: ChildLimitInfo

    public init(birthTime: SolarTime, gender: Gender) {
        self.gender = gender
        // 阳男阴女顺推，阴男阳女逆推
        let eightCharProvider = DefaultEightCharProvider()
        let yearSixtyCycle = eightCharProvider.getYearSixtyCycle(year: birthTime.year, month: birthTime.month, day: birthTime.day)
        let yang = yearSixtyCycle.heavenStem.index % 2 == 0
        let man = gender.isMale
        self.forward = (yang && man) || (!yang && !man)

        var term = birthTime.term
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

    public var yearCount: Int { info.yearCount }
    public var monthCount: Int { info.monthCount }
    public var dayCount: Int { info.dayCount }
    public var hourCount: Int { info.hourCount }
    public var minuteCount: Int { info.minuteCount }
    public var startTime: SolarTime { info.startTime }
    public var endTime: SolarTime { info.endTime }

    @available(*, deprecated, renamed: "gender")
    public func getGender() -> Gender { gender }
    @available(*, deprecated, renamed: "forward")
    public func isForward() -> Bool { forward }
    @available(*, deprecated, renamed: "yearCount")
    public func getYearCount() -> Int { yearCount }
    @available(*, deprecated, renamed: "monthCount")
    public func getMonthCount() -> Int { monthCount }
    @available(*, deprecated, renamed: "dayCount")
    public func getDayCount() -> Int { dayCount }
    @available(*, deprecated, renamed: "hourCount")
    public func getHourCount() -> Int { hourCount }
    @available(*, deprecated, renamed: "minuteCount")
    public func getMinuteCount() -> Int { minuteCount }
    @available(*, deprecated, renamed: "startTime")
    public func getStartTime() -> SolarTime { startTime }
    @available(*, deprecated, renamed: "endTime")
    public func getEndTime() -> SolarTime { endTime }
    @available(*, deprecated, renamed: "info")
    public func getInfo() -> ChildLimitInfo { info }
}
