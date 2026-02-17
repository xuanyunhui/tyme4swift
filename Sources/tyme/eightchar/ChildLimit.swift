import Foundation

/// 童限（从出生到起运的时间段）
public final class ChildLimit {
    /// 童限计算接口
    public nonisolated(unsafe) static var provider: ChildLimitProvider = DefaultChildLimitProvider()

    public let eightChar: EightChar
    public let gender: Gender
    public let forward: Bool
    public let info: ChildLimitInfo

    public init(birthTime: SolarTime, gender: Gender) {
        self.gender = gender
        // 通过 LunarHour 获取八字
        self.eightChar = birthTime.lunarHour.eightChar
        // 阳男阴女顺推，阴男阳女逆推
        let yang = eightChar.year.heavenStem.index % 2 == 0
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

    /// 起运大运（第0个）
    public var startDecadeFortune: DecadeFortune {
        DecadeFortune.fromChildLimit(self, 0)
    }

    /// 上一个大运（index = -1）
    public var decadeFortune: DecadeFortune {
        DecadeFortune.fromChildLimit(self, -1)
    }

    /// 起运小运（第0个）
    public var startFortune: Fortune {
        Fortune.fromChildLimit(self, 0)
    }

    /// 开始干支年
    public var startSixtyCycleYear: SixtyCycleYear {
        SixtyCycleYear.fromYear(startTime.year)
    }

    /// 结束干支年
    public var endSixtyCycleYear: SixtyCycleYear {
        SixtyCycleYear.fromYear(endTime.year)
    }

    /// 开始年龄
    public var startAge: Int { 1 }

    /// 结束年龄
    public var endAge: Int {
        let n = endSixtyCycleYear.year - startSixtyCycleYear.year
        return max(n, 1)
    }

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
    @available(*, deprecated, renamed: "eightChar")
    public func getEightChar() -> EightChar { eightChar }
    @available(*, deprecated, renamed: "decadeFortune")
    public func getDecadeFortune() -> DecadeFortune { decadeFortune }
    @available(*, deprecated, renamed: "startDecadeFortune")
    public func getStartDecadeFortune() -> DecadeFortune { startDecadeFortune }
    @available(*, deprecated, renamed: "startFortune")
    public func getStartFortune() -> Fortune { startFortune }
    @available(*, deprecated, renamed: "startSixtyCycleYear")
    public func getStartSixtyCycleYear() -> SixtyCycleYear { startSixtyCycleYear }
    @available(*, deprecated, renamed: "endSixtyCycleYear")
    public func getEndSixtyCycleYear() -> SixtyCycleYear { endSixtyCycleYear }
    @available(*, deprecated, renamed: "startAge")
    public func getStartAge() -> Int { startAge }
    @available(*, deprecated, renamed: "endAge")
    public func getEndAge() -> Int { endAge }
}
