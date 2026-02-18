import Testing
@testable import tyme

@Suite struct LunarTests {
    @Test func testLunarYear() throws {
        let lunar = try LunarYear.fromYear(2024)
        #expect(lunar.getYear() == 2024)
    }
    @Test func testLunarEightCharProvider() throws {
        let provider = LunarEightCharProvider()

        // Test year pillar
        _ = provider.getYearSixtyCycle(year: 2024, month: 2, day: 10)

        // Test month pillar
        _ = provider.getMonthSixtyCycle(year: 2024, month: 2, day: 10)

        // Test day pillar
        _ = provider.getDaySixtyCycle(year: 2024, month: 2, day: 10)

        // Test hour pillar
        _ = provider.getHourSixtyCycle(year: 2024, month: 2, day: 10, hour: 12)
    }

    // MARK: - LunarYear new properties

    @Test func testLunarYearTwenty() throws {
        // tyme4j: LunarYear.fromYear(1864).getTwenty().getName() == "一运"
        #expect(try LunarYear.fromYear(1864).twenty.getName() == "一运")
        #expect(try LunarYear.fromYear(1883).twenty.getName() == "一运")
        #expect(try LunarYear.fromYear(1884).twenty.getName() == "二运")
        #expect(try LunarYear.fromYear(1903).twenty.getName() == "二运")
        #expect(try LunarYear.fromYear(1904).twenty.getName() == "三运")
        #expect(try LunarYear.fromYear(1923).twenty.getName() == "三运")
        #expect(try LunarYear.fromYear(2004).twenty.getName() == "八运")
        // tyme4j: LunarYear.fromYear(1).getTwenty().getName() == "六运"
        let year1 = try LunarYear.fromYear(1)
        #expect(year1.twenty.getName() == "六运")
        #expect(year1.twenty.sixty.getName() == "中元")
        // tyme4j: LunarYear.fromYear(1863).getTwenty().getSixty().getName() == "下元"
        let year1863 = try LunarYear.fromYear(1863)
        #expect(year1863.twenty.getName() == "九运")
        #expect(year1863.twenty.sixty.getName() == "下元")
    }

    @Test func testLunarYearTwentySixty() throws {
        // tyme4j: LunarYear.fromYear(1864).getTwenty().getSixty().getName() == "上元"
        #expect(try LunarYear.fromYear(1864).twenty.sixty.getName() == "上元")
        #expect(try LunarYear.fromYear(1923).twenty.sixty.getName() == "上元")
        #expect(try LunarYear.fromYear(1924).twenty.sixty.getName() == "中元")
        #expect(try LunarYear.fromYear(1983).twenty.sixty.getName() == "中元")
        #expect(try LunarYear.fromYear(1984).twenty.sixty.getName() == "下元")
        #expect(try LunarYear.fromYear(2043).twenty.sixty.getName() == "下元")
    }

    @Test func testLunarYearNineStar() throws {
        // tyme4j: LunarYear.fromYear(1985).getNineStar() == "六白金"
        #expect(try LunarYear.fromYear(1985).nineStar.description == "六白金")
        // tyme4j: LunarYear.fromYear(2022).getNineStar() == "五黄土"
        #expect(try LunarYear.fromYear(2022).nineStar.description == "五黄土")
        // tyme4j: LunarYear.fromYear(2033).getNineStar() == "三碧木"
        #expect(try LunarYear.fromYear(2033).nineStar.description == "三碧木")
    }

    @Test func testLunarYearJupiterDirection() throws {
        let y2024 = try LunarYear.fromYear(2024)
        // 2024甲辰年，地支辰index=4，方向表[4]=3，Direction index 3 = "南"
        #expect(y2024.jupiterDirection.getName() == "南")
    }

    @Test func testLunarYearKitchenGodSteed() throws {
        let y2024 = try LunarYear.fromYear(2024)
        let steed = y2024.kitchenGodSteed
        #expect(steed.getName() == "灶马头")
    }

    // MARK: - LunarMonth new properties

    @Test func testLunarMonthNineStar() throws {
        // tyme4j: LunarMonth.fromYm(1985, 2).getNineStar() == "四绿木"
        #expect(try LunarMonth.fromYm(1985, 2).nineStar.description == "四绿木")
        // tyme4j: LunarMonth.fromYm(2022, 1).getNineStar() == "二黑土"
        #expect(try LunarMonth.fromYm(2022, 1).nineStar.description == "二黑土")
        // tyme4j: LunarMonth.fromYm(2033, 1).getNineStar() == "五黄土"
        #expect(try LunarMonth.fromYm(2033, 1).nineStar.description == "五黄土")
        // tyme4j: LunarMonth.fromYm(2024, 11).getNineStar() == "四绿木"
        #expect(try LunarMonth.fromYm(2024, 11).nineStar.description == "四绿木")
        // tyme4j: LunarMonth.fromYm(2024, 12).getNineStar() == "三碧木"
        #expect(try LunarMonth.fromYm(2024, 12).nineStar.description == "三碧木")
    }

    @Test func testLunarMonthJupiterDirection() throws {
        let m = try LunarMonth.fromYm(2024, 1)
        // Just verify it returns a valid direction
        #expect(!m.jupiterDirection.getName().isEmpty)
    }

    @Test func testLunarMonthMinorRen() throws {
        // tyme4j: LunarMonth.fromYm(1991, 3).getMinorRen().getName() == "速喜"
        #expect(try LunarMonth.fromYm(1991, 3).minorRen.getName() == "速喜")
        // month=1 -> (1-1)%6=0 -> "大安"
        #expect(try LunarMonth.fromYm(2024, 1).minorRen.getName() == "大安")
    }

    // MARK: - LunarDay new properties

    @Test func testLunarDayNineStar() throws {
        // tyme4j: SolarDay.fromYmd(1985, 2, 19).getLunarDay().getNineStar() == "五黄土"
        let d1 = try SolarDay.fromYmd(1985, 2, 19).lunarDay
        #expect(d1.nineStar.description == "五黄土")
        // tyme4j: LunarDay.fromYmd(2022, 1, 1).getNineStar() == "四绿木"
        let d2 = try LunarDay.fromYmd(2022, 1, 1)
        #expect(d2.nineStar.description == "四绿木")
        // tyme4j: LunarDay.fromYmd(2033, 1, 1).getNineStar() == "一白水"
        let d3 = try LunarDay.fromYmd(2033, 1, 1)
        #expect(d3.nineStar.description == "一白水")
    }

    @Test func testLunarDaySixStar() throws {
        // sixStar: (abs(month) + day - 2) % 6
        // month=1, day=1 -> (1+1-2)%6=0 -> "先胜"
        let d = try LunarDay.fromYmd(2024, 1, 1)
        #expect(d.sixStar.getName() == "先胜")
    }

    @Test func testLunarDayTwentyEightStar() throws {
        // tyme4j test24: LunarDay.fromYmd(2020, 4, 13).getTwentyEightStar()
        let d1 = try LunarDay.fromYmd(2020, 4, 13)
        let star1 = d1.twentyEightStar
        #expect(star1.getName() == "翼")
        #expect(star1.zone.getName() == "南")
        #expect(star1.zone.beast.getName() == "朱雀")

        // tyme4j test25: LunarDay.fromYmd(2023, 9, 28).getTwentyEightStar()
        let d2 = try LunarDay.fromYmd(2023, 9, 28)
        let star2 = d2.twentyEightStar
        #expect(star2.getName() == "柳")
    }

    @Test func testLunarDayMinorRen() throws {
        // tyme4j test28: LunarDay.fromYmd(2024, 3, 5).getMinorRen().getName() == "大安"
        let d = try LunarDay.fromYmd(2024, 3, 5)
        #expect(d.minorRen.getName() == "大安")
    }

    @Test func testLunarDayFestival() throws {
        // 正月初一 = 春节
        let d1 = try LunarDay.fromYmd(2024, 1, 1)
        #expect(d1.festival?.festivalName == "春节")
        // 正月十五 = 元宵节
        let d2 = try LunarDay.fromYmd(2024, 1, 15)
        #expect(d2.festival?.festivalName == "元宵节")
        // 普通日子 = nil
        let d3 = try LunarDay.fromYmd(2024, 1, 3)
        #expect(d3.festival == nil)
    }

    @Test func testLunarDayHours() throws {
        let d = try LunarDay.fromYmd(2024, 1, 1)
        let hours = d.hours
        // 13 hours: 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23
        #expect(hours.count == 13)
    }

    @Test func testLunarDaySixtyCycleDay() throws {
        let d = try LunarDay.fromYmd(2024, 1, 1)
        let scd = d.sixtyCycleDay
        #expect(!scd.getName().isEmpty)
    }

    @Test func testLunarDayDutyAndTwelveStar() throws {
        let d = try LunarDay.fromYmd(2024, 1, 1)
        #expect(!d.duty.getName().isEmpty)
        #expect(!d.twelveStar.getName().isEmpty)
    }

    @Test func testLunarDayGodsRecommendsAvoids() throws {
        let d = try LunarDay.fromYmd(2024, 1, 1)
        // Just verify these don't crash and return non-empty arrays
        #expect(!d.gods.isEmpty)
        #expect(!d.recommends.isEmpty)
        #expect(!d.avoids.isEmpty)
    }

    @Test func testLunarDayJupiterDirection() throws {
        let d = try LunarDay.fromYmd(2024, 1, 1)
        #expect(!d.jupiterDirection.getName().isEmpty)
    }

    @Test func testLunarDayPhaseDay() throws {
        let d = try LunarDay.fromYmd(2024, 1, 15)
        let pd = d.phaseDay
        #expect(!pd.phase.getName().isEmpty)
        #expect(!d.phase.getName().isEmpty)
    }

    @Test func testLunarDayThreePillars() throws {
        let d = try LunarDay.fromYmd(2024, 1, 1)
        #expect(!d.threePillars.getName().isEmpty)
    }
}
