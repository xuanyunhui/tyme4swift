import Foundation

/// 默认童限计算（按秒数计算）
public final class DefaultChildLimitProvider: ChildLimitProvider {
    public init() {}

    public func getInfo(birthTime: SolarTime, term: SolarTerm) -> ChildLimitInfo {
        // 出生时刻和节令时刻相差的秒数
        var seconds = abs(term.julianDay.solarTime.subtract(birthTime))
        // 3天=259200秒=1年
        let year = seconds / 259200
        seconds %= 259200
        // 1天=86400秒=4月，21600秒=1月
        let month = seconds / 21600
        seconds %= 21600
        // 1时=3600秒=5天，720秒=1天
        let day = seconds / 720
        seconds %= 720
        // 1分=60秒=2时，30秒=1时
        let hour = seconds / 30
        seconds %= 30
        // 1秒=2分
        let minute = seconds * 2

        return next(birthTime, year, month, day, hour, minute, 0)
    }
}
