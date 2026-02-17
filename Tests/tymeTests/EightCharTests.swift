import Testing
@testable import tyme

// .serialized is required because provider-switching tests modify the global
// ChildLimit.provider and must not run in parallel with each other.
@Suite(.serialized) struct EightCharTests {
    @Test func testEightCharInit() throws {
        // 四柱干支构造
        let ec = EightChar(
            year: SixtyCycle.fromIndex(0),   // 甲子
            month: SixtyCycle.fromIndex(2),  // 丙寅
            day: SixtyCycle.fromIndex(10),   // 甲戌
            hour: SixtyCycle.fromIndex(5)    // 己巳
        )
        #expect(ec.year.getName() == "甲子")
        #expect(ec.month.getName() == "丙寅")
        #expect(ec.day.getName() == "甲戌")
        #expect(ec.hour.getName() == "己巳")
        #expect(ec.getName() == "甲子 丙寅 甲戌 己巳")
    }

    @Test func testEightCharFromStrings() throws {
        let ec = try EightChar(year: "甲子", month: "丙寅", day: "甲戌", hour: "己巳")
        #expect(ec.year.getName() == "甲子")
        #expect(ec.month.getName() == "丙寅")
        #expect(ec.day.getName() == "甲戌")
        #expect(ec.hour.getName() == "己巳")
    }

    @Test func testFetalOrigin() throws {
        // 胎元 = 月柱天干 next(1), 月柱地支 next(3)
        let ec = try EightChar(year: "甲子", month: "丙寅", day: "甲戌", hour: "己巳")
        let fo = ec.fetalOrigin
        // 丙→丁(next 1), 寅→巳(next 3)
        #expect(fo.heavenStem.getName() == "丁")
        #expect(fo.earthBranch.getName() == "巳")
    }

    @Test func testFetalBreath() throws {
        // 胎息 = 日柱天干 next(5), 地支 = fromIndex(13 - 日柱地支index)
        let ec = try EightChar(year: "甲子", month: "丙寅", day: "甲戌", hour: "己巳")
        let fb = ec.fetalBreath
        // 甲(index 0) next(5) = 己, 戌(index 10) → 13-10=3 → 卯
        #expect(fb.heavenStem.getName() == "己")
        #expect(fb.earthBranch.getName() == "卯")
    }

    @Test func testOwnSign() throws {
        // 命宫
        let ec = try EightChar(year: "甲子", month: "丙寅", day: "甲戌", hour: "己巳")
        let os = ec.ownSign
        // Not empty
        #expect(!os.getName().isEmpty)
    }

    @Test func testBodySign() throws {
        // 身宫
        let ec = try EightChar(year: "甲子", month: "丙寅", day: "甲戌", hour: "己巳")
        let bs = ec.bodySign
        #expect(!bs.getName().isEmpty)
    }

    @Test func testEightCharEquality() throws {
        let ec1 = try EightChar(year: "甲子", month: "丙寅", day: "甲戌", hour: "己巳")
        let ec2 = try EightChar(year: "甲子", month: "丙寅", day: "甲戌", hour: "己巳")
        let ec3 = try EightChar(year: "甲子", month: "丙寅", day: "甲戌", hour: "庚午")
        #expect(ec1 == ec2)
        #expect(ec1 != ec3)
    }

    @Test func testLunarHourEightChar() throws {
        // 通过 LunarHour 获取八字
        let st = try SolarTime.fromYmdHms(2024, 2, 10, 12, 0, 0)
        let ec = st.lunarHour.eightChar
        #expect(!ec.getName().isEmpty)
        #expect(ec.year.getName().count == 2)
        #expect(ec.month.getName().count == 2)
        #expect(ec.day.getName().count == 2)
        #expect(ec.hour.getName().count == 2)
    }

    @Test func testLifePalace() throws {
        let yearBranch = EarthBranch.fromIndex(0) // 子
        let monthBranch = EarthBranch.fromIndex(2) // 寅
        let lifePalace = LifePalace.fromYearMonth(yearBranch, monthBranch)
        _ = lifePalace.sixtyCycle
        _ = lifePalace.heavenStem
        _ = lifePalace.earthBranch
    }

    @Test func testBodyPalace() throws {
        let yearBranch = EarthBranch.fromIndex(0) // 子
        let hourBranch = EarthBranch.fromIndex(6) // 午
        let bodyPalace = BodyPalace.fromYearHour(yearBranch, hourBranch)
        _ = bodyPalace.sixtyCycle
        _ = bodyPalace.heavenStem
        _ = bodyPalace.earthBranch
    }

    @Test func testDefaultEightCharProvider() throws {
        let provider = DefaultEightCharProvider()
        let yearSixtyCycle = provider.getYearSixtyCycle(year: 2024, month: 2, day: 10)
        _ = yearSixtyCycle.heavenStem
        _ = yearSixtyCycle.earthBranch
        _ = provider.getMonthSixtyCycle(year: 2024, month: 2, day: 10)
        _ = provider.getDaySixtyCycle(year: 2024, month: 2, day: 10)
        _ = provider.getHourSixtyCycle(year: 2024, month: 2, day: 10, hour: 12)
    }

    @Test func testChildLimitDefault() throws {
        let cl1 = ChildLimit.fromSolarTime(try SolarTime.fromYmdHms(2022, 3, 9, 20, 51, 0), .male)
        #expect(cl1.yearCount >= 0)
        #expect(cl1.monthCount >= 0)
        #expect(cl1.dayCount >= 0)
        #expect(cl1.forward)
        #expect(cl1.endTime.isAfter(cl1.startTime))
        // 验证新增属性
        #expect(!cl1.eightChar.getName().isEmpty)
        #expect(cl1.startAge == 1)
        #expect(cl1.endAge >= 1)
        _ = cl1.startSixtyCycleYear
        _ = cl1.endSixtyCycleYear

        let cl2 = ChildLimit.fromSolarTime(try SolarTime.fromYmdHms(2022, 3, 9, 20, 51, 0), .female)
        #expect(!cl2.forward)
        #expect(cl2.endTime.isAfter(cl2.startTime))

        let cl3 = ChildLimit.fromSolarTime(try SolarTime.fromYmdHms(1986, 5, 29, 13, 37, 0), .male)
        #expect(cl3.yearCount >= 0)
        #expect(cl3.endTime.isAfter(cl3.startTime))
    }

    @Test func testChildLimitChina95() throws {
        ChildLimit.provider = China95ChildLimitProvider()
        let cl = ChildLimit.fromSolarTime(try SolarTime.fromYmdHms(1986, 5, 29, 13, 37, 0), .male)
        #expect(cl.yearCount >= 0)
        #expect(cl.monthCount >= 0)
        #expect(cl.hourCount == 0)
        #expect(cl.minuteCount == 0)
        #expect(cl.endTime.isAfter(cl.startTime))
        ChildLimit.provider = DefaultChildLimitProvider()
    }

    @Test func testChildLimitLunarSect1() throws {
        ChildLimit.provider = LunarSect1ChildLimitProvider()
        let cl = ChildLimit.fromSolarTime(try SolarTime.fromYmdHms(1994, 10, 17, 1, 0, 0), .male)
        #expect(cl.yearCount >= 0)
        #expect(cl.hourCount == 0)
        #expect(cl.minuteCount == 0)
        #expect(cl.endTime.isAfter(cl.startTime))
        ChildLimit.provider = DefaultChildLimitProvider()
    }

    @Test func testChildLimitLunarSect2() throws {
        ChildLimit.provider = LunarSect2ChildLimitProvider()
        let cl = ChildLimit.fromSolarTime(try SolarTime.fromYmdHms(1986, 5, 29, 13, 37, 0), .male)
        #expect(cl.yearCount >= 0)
        #expect(cl.monthCount >= 0)
        #expect(cl.minuteCount == 0)
        #expect(cl.endTime.isAfter(cl.startTime))
        ChildLimit.provider = DefaultChildLimitProvider()
    }

    @Test func testChildLimitProviderSwitch() throws {
        let birthTime = try SolarTime.fromYmdHms(1986, 5, 29, 13, 37, 0)

        ChildLimit.provider = DefaultChildLimitProvider()
        let defaultResult = ChildLimit.fromSolarTime(birthTime, .male)

        ChildLimit.provider = China95ChildLimitProvider()
        let china95Result = ChildLimit.fromSolarTime(birthTime, .male)

        ChildLimit.provider = LunarSect1ChildLimitProvider()
        let sect1Result = ChildLimit.fromSolarTime(birthTime, .male)

        ChildLimit.provider = LunarSect2ChildLimitProvider()
        let sect2Result = ChildLimit.fromSolarTime(birthTime, .male)

        #expect(
            defaultResult.endTime.getName() != china95Result.endTime.getName() ||
            defaultResult.endTime.getName() != sect1Result.endTime.getName() ||
            defaultResult.endTime.getName() != sect2Result.endTime.getName()
        )

        ChildLimit.provider = DefaultChildLimitProvider()
    }

    @Test func testDecadeFortune() throws {
        let cl = ChildLimit.fromSolarTime(try SolarTime.fromYmdHms(2022, 3, 9, 20, 51, 0), .male)
        let df = cl.startDecadeFortune
        #expect(df.startAge > 0)
        #expect(df.endAge == df.startAge + 9)
        #expect(!df.sixtyCycle.getName().isEmpty)
        #expect(!df.getName().isEmpty)
        _ = df.startSixtyCycleYear
        _ = df.endSixtyCycleYear

        // 测试 next
        let df1 = df.next(1)
        #expect(df1.startAge == df.startAge + 10)

        // 测试开始小运
        let fortune = df.startFortune
        #expect(!fortune.getName().isEmpty)
    }

    @Test func testFortune() throws {
        let cl = ChildLimit.fromSolarTime(try SolarTime.fromYmdHms(2022, 3, 9, 20, 51, 0), .male)
        let f = cl.startFortune
        #expect(f.age > 0)
        #expect(!f.sixtyCycle.getName().isEmpty)
        #expect(!f.getName().isEmpty)
        _ = f.sixtyCycleYear

        // 测试 next
        let f1 = f.next(1)
        #expect(f1.age == f.age + 1)
    }

    @Test func testThreePillars() throws {
        let year = try SixtyCycle.fromName("甲戌")
        let month = try SixtyCycle.fromName("甲戌")
        let day = try SixtyCycle.fromName("甲戌")
        let threePillars = ThreePillars(year: year, month: month, day: day)

        #expect(threePillars.getName() == "甲戌 甲戌 甲戌")
        #expect(threePillars.year.getName() == "甲戌")
        #expect(threePillars.month.getName() == "甲戌")
        #expect(threePillars.day.getName() == "甲戌")

        let threePillars2 = ThreePillars(yearName: "甲戌", monthName: "甲戌", dayName: "甲戌")
        #expect(threePillars2.getName() == "甲戌 甲戌 甲戌")

        #expect(String(describing: threePillars) == "甲戌 甲戌 甲戌")
    }

    @Test func testThreePillarsFromSolarDay() throws {
        let solarDay = try SolarDay.fromYmd(1034, 10, 2)
        let threePillars = solarDay.sixtyCycleDay.threePillars
        #expect(threePillars.getName() == "甲戌 甲戌 甲戌")
    }

    @Test func testThreePillarsFromMultipleDates() throws {
        let day1 = try SolarDay.fromYmd(2024, 2, 10).sixtyCycleDay
        let tp1 = day1.threePillars
        #expect(!tp1.getName().isEmpty)
        #expect(tp1.year.getName().count == 2)
        #expect(tp1.month.getName().count == 2)
        #expect(tp1.day.getName().count == 2)

        let parts = tp1.getName().split(separator: " ")
        #expect(parts.count == 3)

        let day2 = try SolarDay.fromYmd(2024, 2, 11).sixtyCycleDay
        let tp2 = day2.threePillars
        #expect(tp1.day.getName() != tp2.day.getName())
    }

    @Test func testThreePillarsGetSolarDays() throws {
        let threePillars = ThreePillars(yearName: "甲子", monthName: "甲子", dayName: "甲子")
        let solarDays = threePillars.getSolarDays(startYear: 1900, endYear: 2200)
        #expect(solarDays.isEmpty)
    }
}
