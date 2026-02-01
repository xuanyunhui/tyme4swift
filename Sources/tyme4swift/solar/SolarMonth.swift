import Foundation

public final class SolarMonth: MonthUnit, Tyme {
    public override init(year: Int, month: Int) {
        super.init(year: year, month: month)
    }

    public static func fromYm(_ year: Int, _ month: Int) -> SolarMonth {
        SolarMonth(year: year, month: month)
    }

    public func getName() -> String {
        String(format: "%04d-%02d", getYear(), getMonth())
    }

    public func getDayCount() -> Int {
        SolarUtil.daysInMonth(year: getYear(), month: getMonth())
    }

    public func getSolarDay(_ day: Int) -> SolarDay {
        SolarDay(year: getYear(), month: getMonth(), day: day)
    }

    public func getSolarYear() -> SolarYear { SolarYear(year: getYear()) }

    public func next(_ n: Int) -> SolarMonth {
        let total = getYear() * 12 + (getMonth() - 1) + n
        let y = total / 12
        let m = total % 12 + 1
        return SolarMonth(year: y, month: m)
    }
}
