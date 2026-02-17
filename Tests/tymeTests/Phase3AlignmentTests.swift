import Testing
@testable import tyme

@Suite("Phase 3 Alignment Tests")
struct Phase3AlignmentTests {
    // MARK: - Phase/PhaseDay (月相)

    @Test func testPhaseNames() {
        let phase = Phase.fromIndex(2024, 1, 0)
        #expect(phase.getName() == "新月")
        #expect(Phase.NAMES.count == 8)
    }

    @Test func testPhaseNext() {
        let phase = Phase.fromIndex(2024, 1, 0)
        let next = phase.next(1)
        #expect(next.getName() == "蛾眉月")
    }

    @Test func testPhaseDay() {
        let phase = Phase.fromIndex(2024, 1, 0)
        let phaseDay = PhaseDay(phase: phase, dayIndex: 0)
        #expect(phaseDay.phase.getName() == "新月")
    }

    // MARK: - SixtyCycleYear

    @Test func testSixtyCycleYearTwenty() {
        let year = SixtyCycleYear.fromYear(2024)
        let twenty = year.twenty
        #expect(twenty.getName() != "")
    }

    @Test func testSixtyCycleYearNineStar() {
        let year = SixtyCycleYear.fromYear(2024)
        let star = year.nineStar
        #expect(star.getName() != "")
    }

    @Test func testSixtyCycleYearJupiterDirection() {
        let year = SixtyCycleYear.fromYear(2024)
        let dir = year.jupiterDirection
        #expect(dir.getName() != "")
    }

    @Test func testSixtyCycleYearFirstMonthAndMonths() {
        let year = SixtyCycleYear.fromYear(2024)
        let first = year.firstMonth
        #expect(first.sixtyCycle.getName() != "")
        let months = year.months
        #expect(months.count == 12)
    }

    // MARK: - SixtyCycleMonth

    @Test func testSixtyCycleMonthFromYm() {
        let month = SixtyCycleMonth.fromYm(2024, 1)
        #expect(month.year == 2024)
        #expect(month.month == 1)
    }

    @Test func testSixtyCycleMonthIndexInYear() {
        let month = SixtyCycleMonth.fromIndex(2024, 0)
        #expect(month.indexInYear == 0)
    }

    @Test func testSixtyCycleMonthNineStar() {
        let month = SixtyCycleMonth.fromIndex(2024, 0)
        #expect(month.nineStar.getName() != "")
    }

    @Test func testSixtyCycleMonthJupiterDirection() {
        let month = SixtyCycleMonth.fromIndex(2024, 0)
        #expect(month.jupiterDirection.getName() != "")
    }

    @Test func testSixtyCycleMonthFirstDayAndDays() {
        let month = SixtyCycleMonth.fromIndex(2024, 0)
        let firstDay = month.firstDay
        #expect(firstDay.sixtyCycle.getName() != "")
        let days = month.days
        #expect(days.count > 0)
    }

    // MARK: - SixtyCycleDay

    @Test func testSixtyCycleDaySixtyCycleMonth() throws {
        let day = try SixtyCycleDay.fromYmd(2024, 2, 10)
        let scMonth = day.sixtyCycleMonth
        #expect(scMonth.sixtyCycle.getName() != "")
    }

    @Test func testSixtyCycleDayYearAndMonthPillars() throws {
        let day = try SixtyCycleDay.fromYmd(2024, 2, 10)
        #expect(day.yearPillar.getName() != "")
        #expect(day.monthPillar.getName() != "")
    }

    @Test func testSixtyCycleDayTwelveStar() throws {
        let day = try SixtyCycleDay.fromYmd(2024, 2, 10)
        let star = day.twelveStar
        #expect(star.getName() != "")
    }

    @Test func testSixtyCycleDayNineStar() throws {
        let day = try SixtyCycleDay.fromYmd(2024, 2, 10)
        let star = day.nineStar
        #expect(star.getName() != "")
    }

    @Test func testSixtyCycleDayJupiterDirection() throws {
        let day = try SixtyCycleDay.fromYmd(2024, 2, 10)
        let dir = day.jupiterDirection
        #expect(dir.getName() != "")
    }

    @Test func testSixtyCycleDayFetusDay() throws {
        let day = try SixtyCycleDay.fromYmd(2024, 2, 10)
        let fetus = day.fetusDay
        #expect(fetus.getName() != "")
    }

    @Test func testSixtyCycleDayHours() throws {
        let day = try SixtyCycleDay.fromYmd(2024, 2, 10)
        let hours = day.hours
        #expect(hours.count == 12)
    }

    @Test func testSixtyCycleDayDescription() throws {
        let day = try SixtyCycleDay.fromYmd(2024, 2, 10)
        let desc = day.description
        #expect(desc.contains("日"))
        #expect(desc.contains("月"))
    }

    // MARK: - SixtyCycleHour

    @Test func testSixtyCycleHourPillars() throws {
        let hour = try SixtyCycleHour.fromYmdHms(2024, 2, 10, 12, 0, 0)
        #expect(hour.yearPillar.getName() != "")
        #expect(hour.monthPillar.getName() != "")
        #expect(hour.dayPillar.getName() != "")
        #expect(hour.sixtyCycle.getName() != "")
    }

    @Test func testSixtyCycleHourSixtyCycleDay() throws {
        let hour = try SixtyCycleHour.fromYmdHms(2024, 2, 10, 12, 0, 0)
        let day = hour.sixtyCycleDay
        #expect(day.solarDay.year == 2024)
        #expect(day.solarDay.month == 2)
        #expect(day.solarDay.day == 10)
    }

    @Test func testSixtyCycleHourNineStar() throws {
        let hour = try SixtyCycleHour.fromYmdHms(2024, 2, 10, 12, 0, 0)
        #expect(hour.nineStar.getName() != "")
    }

    @Test func testSixtyCycleHourTwelveStar() throws {
        let hour = try SixtyCycleHour.fromYmdHms(2024, 2, 10, 12, 0, 0)
        #expect(hour.twelveStar.getName() != "")
    }

    @Test func testSixtyCycleHourRecommendsAndAvoids() throws {
        let hour = try SixtyCycleHour.fromYmdHms(2024, 2, 10, 12, 0, 0)
        _ = hour.recommends
        _ = hour.avoids
    }

    @Test func testSixtyCycleHourNextBySeconds() throws {
        let hour = try SixtyCycleHour.fromYmdHms(2024, 2, 10, 12, 0, 0)
        let nextHour = hour.next(7200) // 2 hours in seconds
        #expect(nextHour.solarTime.hour == 14)
    }

    @Test func testSixtyCycleHourDescription() throws {
        let hour = try SixtyCycleHour.fromYmdHms(2024, 2, 10, 12, 0, 0)
        let desc = hour.description
        #expect(desc.contains("时"))
    }

    @Test func testSixtyCycleHour23() throws {
        // 23:00 should switch to next day's 子时
        let hour = try SixtyCycleHour.fromYmdHms(2024, 2, 10, 23, 0, 0)
        #expect(hour.indexInDay == 0) // 子时
    }

    // MARK: - LunarMonth.sixtyCycle

    @Test func testLunarMonthSixtyCycle() throws {
        let month = try LunarMonth.fromYm(2024, 1)
        let sc = month.sixtyCycle
        #expect(sc.getName() != "")
    }
}
