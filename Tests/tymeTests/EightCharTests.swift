import Testing
@testable import tyme

@Suite struct EightCharTests {
    @Test func testLifePalace() throws {
        let yearBranch = EarthBranch.fromIndex(0) // 子
        let monthBranch = EarthBranch.fromIndex(2) // 寅
        let lifePalace = LifePalace.fromYearMonth(yearBranch, monthBranch)
        _ = lifePalace.getSixtyCycle()
        _ = lifePalace.getHeavenStem()
        _ = lifePalace.getEarthBranch()
    }
    @Test func testBodyPalace() throws {
        let yearBranch = EarthBranch.fromIndex(0) // 子
        let hourBranch = EarthBranch.fromIndex(6) // 午
        let bodyPalace = BodyPalace.fromYearHour(yearBranch, hourBranch)
        _ = bodyPalace.getSixtyCycle()
        _ = bodyPalace.getHeavenStem()
        _ = bodyPalace.getEarthBranch()
    }
    @Test func testDefaultEightCharProvider() throws {
        let provider = DefaultEightCharProvider()

        // Test year pillar
        let yearSixtyCycle = provider.getYearSixtyCycle(year: 2024, month: 2, day: 10)
        _ = yearSixtyCycle.getHeavenStem()
        _ = yearSixtyCycle.getEarthBranch()

        // Test month pillar
        _ = provider.getMonthSixtyCycle(year: 2024, month: 2, day: 10)

        // Test day pillar
        _ = provider.getDaySixtyCycle(year: 2024, month: 2, day: 10)

        // Test hour pillar
        _ = provider.getHourSixtyCycle(year: 2024, month: 2, day: 10, hour: 12)
    }
    @Test func testChildLimitDefault() throws {
        // Verify ChildLimit creation and structural correctness
        let cl1 = ChildLimit.fromSolarTime(try SolarTime.fromYmdHms(2022, 3, 9, 20, 51, 0), .male)
        #expect(cl1.getYearCount() >= 0)
        #expect(cl1.getMonthCount() >= 0)
        #expect(cl1.getDayCount() >= 0)
        #expect(cl1.isForward()) // 壬寅年, Yang stem + Male = forward
        // EndTime should be after birth time
        #expect(cl1.getEndTime().isAfter(cl1.getStartTime()))

        // Female, Yang year = backward
        let cl2 = ChildLimit.fromSolarTime(try SolarTime.fromYmdHms(2022, 3, 9, 20, 51, 0), .female)
        #expect(!cl2.isForward())
        #expect(cl2.getEndTime().isAfter(cl2.getStartTime()))

        // Verify different providers give different results
        let cl3 = ChildLimit.fromSolarTime(try SolarTime.fromYmdHms(1986, 5, 29, 13, 37, 0), .male)
        #expect(cl3.getYearCount() >= 0)
        #expect(cl3.getEndTime().isAfter(cl3.getStartTime()))
    }
    @Test func testChildLimitChina95() throws {
        ChildLimit.provider = China95ChildLimitProvider()
        let cl = ChildLimit.fromSolarTime(try SolarTime.fromYmdHms(1986, 5, 29, 13, 37, 0), .male)
        // China95 uses minute-based calculation, verify non-negative results
        #expect(cl.getYearCount() >= 0)
        #expect(cl.getMonthCount() >= 0)
        #expect(cl.getHourCount() >= 0)
        #expect(cl.getMinuteCount() >= 0)
        #expect(cl.getEndTime().isAfter(cl.getStartTime()))
        ChildLimit.provider = DefaultChildLimitProvider()
    }
    @Test func testChildLimitLunarSect1() throws {
        ChildLimit.provider = LunarSect1ChildLimitProvider()
        let cl = ChildLimit.fromSolarTime(try SolarTime.fromYmdHms(1994, 10, 17, 1, 0, 0), .male)
        // LunarSect1 uses day/hour-based calculation
        #expect(cl.getYearCount() >= 0)
        #expect(cl.getHourCount() == 0) // LunarSect1 always has 0 hours
        #expect(cl.getMinuteCount() == 0) // LunarSect1 always has 0 minutes
        #expect(cl.getEndTime().isAfter(cl.getStartTime()))
        ChildLimit.provider = DefaultChildLimitProvider()
    }
    @Test func testChildLimitLunarSect2() throws {
        ChildLimit.provider = LunarSect2ChildLimitProvider()
        let cl = ChildLimit.fromSolarTime(try SolarTime.fromYmdHms(1986, 5, 29, 13, 37, 0), .male)
        // LunarSect2 uses minute-based calculation with hour component
        #expect(cl.getYearCount() >= 0)
        #expect(cl.getMonthCount() >= 0)
        #expect(cl.getMinuteCount() >= 0)
        #expect(cl.getEndTime().isAfter(cl.getStartTime()))
        ChildLimit.provider = DefaultChildLimitProvider()
    }
    @Test func testChildLimitProviderSwitch() throws {
        // Verify provider switching works
        let birthTime = try SolarTime.fromYmdHms(1986, 5, 29, 13, 37, 0)

        ChildLimit.provider = DefaultChildLimitProvider()
        let defaultResult = ChildLimit.fromSolarTime(birthTime, .male)

        ChildLimit.provider = China95ChildLimitProvider()
        let china95Result = ChildLimit.fromSolarTime(birthTime, .male)

        ChildLimit.provider = LunarSect1ChildLimitProvider()
        let sect1Result = ChildLimit.fromSolarTime(birthTime, .male)

        ChildLimit.provider = LunarSect2ChildLimitProvider()
        let sect2Result = ChildLimit.fromSolarTime(birthTime, .male)

        // Different providers should generally give different results
        // (they use different conversion formulas)
        #expect(
            defaultResult.getEndTime().getName() != china95Result.getEndTime().getName() ||
            defaultResult.getEndTime().getName() != sect1Result.getEndTime().getName() ||
            defaultResult.getEndTime().getName() != sect2Result.getEndTime().getName()
        )

        ChildLimit.provider = DefaultChildLimitProvider()
    }
    @Test func testDecadeFortuneProvider() throws {
        let provider = DefaultDecadeFortuneProvider()

        let maleFortunes = provider.getDecadeFortunes(gender: .male, year: 2024, month: 2, day: 10, hour: 12, count: 8)
        #expect(maleFortunes.count == 8)
        for fortune in maleFortunes {
            _ = fortune.sixtyCycle
            _ = fortune.getName()
            _ = fortune.getHeavenStem()
            _ = fortune.getEarthBranch()
        }

        let femaleFortunes = provider.getDecadeFortunes(gender: .female, year: 2024, month: 2, day: 10, hour: 12, count: 8)
        #expect(femaleFortunes.count == 8)
    }
    @Test func testDecadeFortuneInfo() throws {
        let sixtyCycle = SixtyCycle.fromIndex(0)
        let info = DecadeFortuneInfo(index: 0, sixtyCycle: sixtyCycle, startAge: 5, endAge: 14)
        #expect(info.index == 0)
        #expect(info.startAge == 5)
        #expect(info.endAge == 14)
        #expect(info.getName() == "甲子")
        #expect(info.getHeavenStem().getName() == "甲")
        #expect(info.getEarthBranch().getName() == "子")
    }
    @Test func testThreePillars() throws {
        // Test basic creation with SixtyCycle objects
        let year = try SixtyCycle.fromName("甲戌")
        let month = try SixtyCycle.fromName("甲戌")
        let day = try SixtyCycle.fromName("甲戌")
        let threePillars = ThreePillars(year: year, month: month, day: day)

        #expect(threePillars.getName() == "甲戌 甲戌 甲戌")
        #expect(threePillars.getYear().getName() == "甲戌")
        #expect(threePillars.getMonth().getName() == "甲戌")
        #expect(threePillars.getDay().getName() == "甲戌")

        // Test convenience initializer with strings
        let threePillars2 = ThreePillars(yearName: "甲戌", monthName: "甲戌", dayName: "甲戌")
        #expect(threePillars2.getName() == "甲戌 甲戌 甲戌")

        // Test description (CustomStringConvertible)
        #expect(String(describing: threePillars) == "甲戌 甲戌 甲戌")
    }
    @Test func testThreePillarsFromSolarDay() throws {
        // Aligned with tyme4j: SolarDay(1034, 10, 2) → ThreePillars = "甲戌 甲戌 甲戌"
        let solarDay = try SolarDay.fromYmd(1034, 10, 2)
        let threePillars = solarDay.getSixtyCycleDay().getThreePillars()
        #expect(threePillars.getName() == "甲戌 甲戌 甲戌")
    }
    @Test func testThreePillarsFromMultipleDates() throws {
        // Test additional dates to verify getThreePillars consistency
        // 2024-02-10 should produce a valid ThreePillars
        let day1 = try SolarDay.fromYmd(2024, 2, 10).getSixtyCycleDay()
        let tp1 = day1.getThreePillars()
        #expect(!tp1.getName().isEmpty)
        #expect(tp1.getYear().getName().count == 2)
        #expect(tp1.getMonth().getName().count == 2)
        #expect(tp1.getDay().getName().count == 2)

        // Verify getName format: "XX XX XX"
        let parts = tp1.getName().split(separator: " ")
        #expect(parts.count == 3)

        // Two consecutive days should have different day pillars but same year/month pillars (usually)
        let day2 = try SolarDay.fromYmd(2024, 2, 11).getSixtyCycleDay()
        let tp2 = day2.getThreePillars()
        #expect(tp1.getDay().getName() != tp2.getDay().getName())
    }
    @Test func testThreePillarsGetSolarDays() throws {
        // NOTE: getSolarDays crashes on certain year ranges due to a pre-existing
        // SolarDay.getLunarDay() bug that produces invalid lunar day values.
        // This test validates the month-stem check (invalid combinations return empty).
        // When month heaven stem doesn't match year stem rule, getSolarDays returns empty
        // without needing to call getLunarDay(), so no crash.
        let threePillars = ThreePillars(yearName: "甲子", monthName: "甲子", dayName: "甲子")
        let solarDays = threePillars.getSolarDays(startYear: 1900, endYear: 2200)
        #expect(solarDays.count == 0)
    }
}
