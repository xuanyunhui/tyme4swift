import Foundation

/// 童限计算提供者协议 (ChildLimit Provider Protocol)
public protocol ChildLimitProvider {
    func getInfo(birthTime: SolarTime, term: SolarTerm) -> ChildLimitInfo
}

/// 童限计算抽象辅助方法
extension ChildLimitProvider {
    func next(_ birthTime: SolarTime, _ addYear: Int, _ addMonth: Int, _ addDay: Int, _ addHour: Int, _ addMinute: Int, _ addSecond: Int) -> ChildLimitInfo {
        var d = birthTime.day + addDay
        var h = birthTime.hour + addHour
        var mi = birthTime.minute + addMinute
        var s = birthTime.second + addSecond
        mi += s / 60
        s = s % 60
        h += mi / 60
        mi = mi % 60
        d += h / 24
        h = h % 24

        var sm = try! SolarMonth.fromYm(birthTime.year + addYear, birthTime.month).next(addMonth)

        var dc = sm.dayCount
        while d > dc {
            d -= dc
            sm = sm.next(1)
            dc = sm.dayCount
        }

        return ChildLimitInfo(
            startTime: birthTime,
            endTime: try! SolarTime.fromYmdHms(sm.year, sm.month, d, h, mi, s),
            yearCount: addYear,
            monthCount: addMonth,
            dayCount: addDay,
            hourCount: addHour,
            minuteCount: addMinute
        )
    }
}

/// 童限信息 (ChildLimit Info)
public struct ChildLimitInfo {
    public let startTime: SolarTime
    public let endTime: SolarTime
    public let yearCount: Int
    public let monthCount: Int
    public let dayCount: Int
    public let hourCount: Int
    public let minuteCount: Int

    public init(startTime: SolarTime, endTime: SolarTime, yearCount: Int, monthCount: Int, dayCount: Int, hourCount: Int, minuteCount: Int) {
        self.startTime = startTime
        self.endTime = endTime
        self.yearCount = yearCount
        self.monthCount = monthCount
        self.dayCount = dayCount
        self.hourCount = hourCount
        self.minuteCount = minuteCount
    }
}
