import Foundation

/// 默认大运计算提供者 (Default DecadeFortune Provider)
public final class DefaultDecadeFortuneProvider: DecadeFortuneProvider {
    public init() {}

    public func getDecadeFortunes(gender: Gender, year: Int, month: Int, day: Int, hour: Int, count: Int) -> [DecadeFortuneInfo] {
        let provider = DefaultEightCharProvider()
        let yearSixtyCycle = provider.getYearSixtyCycle(year: year, month: month, day: day)
        let monthSixtyCycle = provider.getMonthSixtyCycle(year: year, month: month, day: day)

        let yearStemIndex = yearSixtyCycle.heavenStem.index
        let isYangYear = yearStemIndex % 2 == 0
        let isMale = gender.isMale
        let isForward = (isYangYear && isMale) || (!isYangYear && !isMale)

        // Use ChildLimit to get start age
        let birthTime = try! SolarTime.fromYmdHms(year, month, day, hour, 0, 0)
        let childLimit = ChildLimit(birthTime: birthTime, gender: gender)
        let startAge = childLimit.yearCount

        var fortunes: [DecadeFortuneInfo] = []
        var currentSixtyCycle = monthSixtyCycle

        for i in 0..<count {
            let fortuneStartAge = startAge + i * 10
            let fortuneEndAge = fortuneStartAge + 9

            if i > 0 {
                currentSixtyCycle = currentSixtyCycle.next(isForward ? 1 : -1)
            }

            let fortune = DecadeFortuneInfo(
                index: i,
                sixtyCycle: currentSixtyCycle,
                startAge: fortuneStartAge,
                endAge: fortuneEndAge
            )
            fortunes.append(fortune)
        }

        return fortunes
    }
}
