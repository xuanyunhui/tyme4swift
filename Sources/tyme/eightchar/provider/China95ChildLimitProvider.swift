import Foundation

/// 元亨利贞童限计算
public final class China95ChildLimitProvider: ChildLimitProvider {
    public init() {}

    public func getInfo(birthTime: SolarTime, term: SolarTerm) -> ChildLimitInfo {
        // 出生时刻和节令时刻相差的分钟数
        var minutes = abs(term.julianDay.solarTime.subtract(birthTime)) / 60
        let year = minutes / 4320
        minutes %= 4320
        let month = minutes / 360
        minutes %= 360
        let day = minutes / 12

        return next(birthTime, year, month, day, 0, 0, 0)
    }
}
