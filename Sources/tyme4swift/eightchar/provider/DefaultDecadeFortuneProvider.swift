import Foundation

/// 默认大运计算提供者 (Default DecadeFortune Provider)
/// Standard calculation method for DecadeFortune
public final class DefaultDecadeFortuneProvider: DecadeFortuneProvider {
    public init() {}

    /// Get decade fortunes
    public func getDecadeFortunes(gender: Gender, year: Int, month: Int, day: Int, hour: Int, count: Int) -> [DecadeFortuneInfo] {
        // Get the month pillar as starting point
        let provider = DefaultEightCharProvider()
        let yearSixtyCycle = provider.getYearSixtyCycle(year: year, month: month, day: day)
        let monthSixtyCycle = provider.getMonthSixtyCycle(year: year, month: month, day: day)

        // Determine direction
        let yearStemIndex = yearSixtyCycle.getHeavenStem().getIndex()
        let isYangYear = yearStemIndex % 2 == 0
        let isMale = gender.isMale
        let isForward = (isYangYear && isMale) || (!isYangYear && !isMale)

        // Get child limit to determine start age
        let childLimitProvider = DefaultChildLimitProvider()
        let childLimit = childLimitProvider.getChildLimit(gender: gender, year: year, month: month, day: day, hour: hour)
        let startAge = childLimit.years

        var fortunes: [DecadeFortuneInfo] = []
        var currentSixtyCycle = monthSixtyCycle

        for i in 0..<count {
            let fortuneStartAge = startAge + i * 10
            let fortuneEndAge = fortuneStartAge + 9

            // Move to next/previous SixtyCycle
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
