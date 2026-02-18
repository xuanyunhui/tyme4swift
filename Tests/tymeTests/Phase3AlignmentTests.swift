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

    // Phase.solarTime — tyme4j: Phase.fromName(2025, 7, "下弦月").solarTime == "2025年9月14日 18:32:57"
    @Test func testPhaseSolarTimeFromName() throws {
        let phase = try Phase.fromName(2025, 7, "下弦月")
        let st = phase.solarTime
        #expect(st.year == 2025)
        #expect(st.month == 9)
        #expect(st.day == 14)
        #expect(st.hour == 18)
        #expect(st.minute == 32)
        #expect(st.second == 57)
    }

    // Phase.solarTime — tyme4j: Phase.fromIndex(2025, 7, 6).solarTime == "2025年9月14日 18:32:57"
    @Test func testPhaseSolarTimeFromIndex() {
        let phase = Phase.fromIndex(2025, 7, 6)
        let st = phase.solarTime
        #expect(st.year == 2025)
        #expect(st.month == 9)
        #expect(st.day == 14)
        #expect(st.hour == 18)
        #expect(st.minute == 32)
        #expect(st.second == 57)
    }

    // Phase.solarTime — tyme4j: Phase.fromIndex(2025, 7, 8).solarTime == "2025年9月22日 03:54:07"
    @Test func testPhaseSolarTimeWrapToNextMonth() {
        let phase = Phase.fromIndex(2025, 7, 8)
        let st = phase.solarTime
        #expect(st.year == 2025)
        #expect(st.month == 9)
        #expect(st.day == 22)
        #expect(st.hour == 3)
        #expect(st.minute == 54)
        #expect(st.second == 7)
    }

    // Phase.solarDay
    @Test func testPhaseSolarDay() throws {
        // 下弦月的 solarDay (odd index → next day from start)
        let phase = try Phase.fromName(2025, 7, "下弦月")
        let sd = phase.solarDay
        #expect(sd.year == 2025)
        #expect(sd.month == 9)
        // solarDay for odd index adds 1 day to start
        #expect(sd.day == 15)
    }

    // MARK: - SixtyCycleYear (精确值断言)

    // tyme4j: SixtyCycleYear.fromYear(2025).firstMonth.getName() == "戊寅月"
    @Test func testSixtyCycleYearFirstMonth2025() {
        let year = SixtyCycleYear.fromYear(2025)
        #expect(year.firstMonth.getName() == "戊寅月")
    }

    // tyme4j: SixtyCycleYear.fromYear(1864).twenty.getName() == "一运"
    @Test func testSixtyCycleYearTwentyPrecise() {
        #expect(SixtyCycleYear.fromYear(1864).twenty.getName() == "一运")
        #expect(SixtyCycleYear.fromYear(2004).twenty.getName() == "八运")
    }

    // tyme4j: SixtyCycleYear.fromYear(1864).twenty.sixty.getName() == "上元"
    @Test func testSixtyCycleYearSixtyPrecise() {
        #expect(SixtyCycleYear.fromYear(1864).twenty.sixty.getName() == "上元")
        #expect(SixtyCycleYear.fromYear(1924).twenty.sixty.getName() == "中元")
        #expect(SixtyCycleYear.fromYear(1984).twenty.sixty.getName() == "下元")
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

    @Test func testSixtyCycleYearMonthsCount() {
        let year = SixtyCycleYear.fromYear(2024)
        #expect(year.months.count == 12)
    }

    // MARK: - SixtyCycleMonth (精确值断言)

    // tyme4j: SixtyCycleMonth.fromIndex(2025, 0).toString() == "乙巳年戊寅月"
    @Test func testSixtyCycleMonthDescription2025() {
        let month = SixtyCycleMonth.fromIndex(2025, 0)
        #expect(month.description == "乙巳年戊寅月")
    }

    // tyme4j: SixtyCycleMonth.fromIndex(1150, 0).firstDay.toString() == "庚午年戊寅月戊寅日"
    @Test func testSixtyCycleMonthFirstDay1150() {
        let month = SixtyCycleMonth.fromIndex(1150, 0)
        #expect(month.description == "庚午年戊寅月")
        #expect(month.firstDay.description == "庚午年戊寅月戊寅日")
    }

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

    // SixtyCycleMonth.Equatable test — critical: used in SixtyCycleDay.hours while loop
    @Test func testSixtyCycleMonthEquatable() {
        let m1 = SixtyCycleMonth.fromIndex(2024, 0)
        let m2 = SixtyCycleMonth.fromIndex(2024, 0)
        let m3 = SixtyCycleMonth.fromIndex(2024, 1)
        let m4 = SixtyCycleMonth.fromIndex(2025, 0)
        #expect(m1 == m2)
        #expect(m1 != m3)
        #expect(m1 != m4)
    }

    // MARK: - SixtyCycleDay (精确值断言)

    // tyme4j: SixtyCycleDay(2025,2,3).toString() == "乙巳年戊寅月癸卯日"
    @Test func testSixtyCycleDayDescription2025_02_03() throws {
        let day = try SixtyCycleDay.fromYmd(2025, 2, 3)
        #expect(day.description == "乙巳年戊寅月癸卯日")
    }

    // tyme4j: SixtyCycleDay(2025,2,2).toString() == "甲辰年丁丑月壬寅日"
    @Test func testSixtyCycleDayDescription2025_02_02() throws {
        let day = try SixtyCycleDay.fromYmd(2025, 2, 2)
        #expect(day.description == "甲辰年丁丑月壬寅日")
    }

    // tyme4j EclipticTest: SolarDay(2023,10,30).sixtyCycleDay.twelveStar == "天德"
    @Test func testSixtyCycleDayTwelveStarPrecise() throws {
        #expect(try SixtyCycleDay.fromYmd(2023, 10, 30).twelveStar.getName() == "天德")
        #expect(try SixtyCycleDay.fromYmd(2023, 10, 19).twelveStar.getName() == "白虎")
        #expect(try SixtyCycleDay.fromYmd(2023, 10, 7).twelveStar.getName() == "天牢")
        #expect(try SixtyCycleDay.fromYmd(2023, 10, 8).twelveStar.getName() == "玉堂")
    }

    // tyme4j DutyTest: SolarDay(2023,10,30).sixtyCycleDay.duty == "闭"
    @Test func testSixtyCycleDayDutyPrecise() throws {
        #expect(try SixtyCycleDay.fromYmd(2023, 10, 30).duty.getName() == "闭")
        #expect(try SixtyCycleDay.fromYmd(2023, 10, 19).duty.getName() == "建")
        #expect(try SixtyCycleDay.fromYmd(2023, 10, 7).duty.getName() == "除")
        #expect(try SixtyCycleDay.fromYmd(2023, 10, 8).duty.getName() == "除")
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

    // MARK: - SixtyCycleHour (精确值断言)

    // tyme4j: SolarTime(2025,2,3,23,0,0).sixtyCycleHour == "乙巳年戊寅月甲辰日甲子时"
    @Test func testSixtyCycleHourDescription23() throws {
        let hour = try SixtyCycleHour.fromYmdHms(2025, 2, 3, 23, 0, 0)
        #expect(hour.description == "乙巳年戊寅月甲辰日甲子时")
        let day = hour.sixtyCycleDay
        #expect(day.description == "乙巳年戊寅月甲辰日")
        #expect(day.solarDay.getName() == "2025-02-03")
    }

    // tyme4j: SolarTime(2025,2,3,4,0,0).sixtyCycleHour == "甲辰年丁丑月癸卯日甲寅时"
    @Test func testSixtyCycleHourDescriptionEarlyMorning() throws {
        let hour = try SixtyCycleHour.fromYmdHms(2025, 2, 3, 4, 0, 0)
        #expect(hour.description == "甲辰年丁丑月癸卯日甲寅时")
    }

    // tyme4j: SolarTime(2025,2,3,22,30,0).sixtyCycleHour == "乙巳年戊寅月癸卯日癸亥时"
    @Test func testSixtyCycleHourDescriptionLateEvening() throws {
        let hour = try SixtyCycleHour.fromYmdHms(2025, 2, 3, 22, 30, 0)
        #expect(hour.description == "乙巳年戊寅月癸卯日癸亥时")
    }

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

    @Test func testSixtyCycleHour23IndexInDay() throws {
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
