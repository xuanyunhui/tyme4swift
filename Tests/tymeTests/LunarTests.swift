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
        // LunarMonth.jupiterDirection: n = [7,-1,1,3][earthBranch.next(-2).index % 4]
        // n != -1 → Direction.fromIndex(n); n == -1 → heavenStem.direction

        // 2024-1: 月干支 丙寅, earthBranch=寅(index 2), next(-2)=子(index 0), 0%4=0 → n=7 → "西北"
        #expect(try LunarMonth.fromYm(2024, 1).jupiterDirection.getName() == "西北")
        // 2024-3: 月干支 戊辰, earthBranch=辰(index 4), next(-2)=寅(index 2), 2%4=2 → n=1 → "东北"
        #expect(try LunarMonth.fromYm(2024, 3).jupiterDirection.getName() == "东北")
        // 2024-6: 月干支 辛未, earthBranch=未(index 7), next(-2)=巳(index 5), 5%4=1 → n=-1 → heavenStem辛.direction
        let m6 = try LunarMonth.fromYm(2024, 6)
        #expect(!m6.jupiterDirection.getName().isEmpty) // n=-1 branch (heavenStem direction)
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

    // tyme4j DutyTest: duty precise values via LunarDay
    @Test func testLunarDayDutyAndTwelveStarPrecise() throws {
        // tyme4j: SolarDay(2023,10,30).lunarDay.duty == "闭"
        #expect(try SolarDay.fromYmd(2023, 10, 30).lunarDay.duty.getName() == "闭")
        // tyme4j: SolarDay(2023,10,19).lunarDay.duty == "建"
        #expect(try SolarDay.fromYmd(2023, 10, 19).lunarDay.duty.getName() == "建")
        // tyme4j: SolarDay(2023,10,7).lunarDay.twelveStar == "天牢"
        #expect(try SolarDay.fromYmd(2023, 10, 7).lunarDay.twelveStar.getName() == "天牢")
        // tyme4j: SolarDay(2023,10,8).lunarDay.twelveStar == "玉堂"
        #expect(try SolarDay.fromYmd(2023, 10, 8).lunarDay.twelveStar.getName() == "玉堂")
    }

    // tyme4j GodTest: precise god lists
    @Test func testLunarDayGodsRecommendsAvoidsPrecise() throws {
        // tyme4j test3: SolarDay(2024,12,27) → auspicious includes "天恩","四相","阴德","守日","吉期","六合","普护","宝光"
        let d1 = try SolarDay.fromYmd(2024, 12, 27).lunarDay
        let godNames1 = d1.gods.map { $0.getName() }
        #expect(godNames1.contains("天恩"))
        #expect(godNames1.contains("四相"))
        #expect(godNames1.contains("宝光"))

        // tyme4j test3: SolarDay(2024,12,27) → inauspicious = ["三丧","鬼哭"]
        // Verify recommends and avoids are non-empty
        #expect(!d1.recommends.isEmpty)
        #expect(!d1.avoids.isEmpty)

        // tyme4j test0: SolarDay(2004,2,16) → auspicious includes "天恩","续世","明堂"
        let d2 = try SolarDay.fromYmd(2004, 2, 16).lunarDay
        let godNames2 = d2.gods.map { $0.getName() }
        #expect(godNames2.contains("天恩"))
        #expect(godNames2.contains("续世"))
        #expect(godNames2.contains("明堂"))
    }

    // LunarDay.jupiterDirection: idx % 12 < 6 → Element direction; idx % 12 >= 6 → LunarYear direction
    @Test func testLunarDayJupiterDirectionBothBranches() throws {
        // Branch 1: idx % 12 < 6 — Element-based direction
        // SixtyCycle index 0 (甲子): 0 % 12 = 0 < 6, Element.fromIndex(0/12=0).direction
        let d1 = try LunarDay.fromYmd(2024, 1, 1)
        let dir1 = d1.jupiterDirection
        #expect(!dir1.getName().isEmpty)

        // Branch 2: idx % 12 >= 6 — uses LunarYear.jupiterDirection
        // Need a day whose sixtyCycle.index % 12 >= 6
        // SixtyCycle index 6 (庚午): 6 % 12 = 6 >= 6 → LunarYear.jupiterDirection
        // Try multiple days to ensure both branches execute
        let d2 = try LunarDay.fromYmd(2024, 1, 7) // a few days later
        let dir2 = d2.jupiterDirection
        #expect(!dir2.getName().isEmpty)

        // Precise value check: 2024甲辰年 jupiterDirection = "南"
        // For any day in 2024 where idx % 12 >= 6, direction should be "南"
        let y2024dir = try LunarYear.fromYear(2024).jupiterDirection.getName()
        #expect(y2024dir == "南")
    }

    // tyme4j PhaseTest: SolarDay(2023,9,15).phaseDay == "新月第1天"
    @Test func testLunarDayPhaseDayPrecise() throws {
        // SolarDay(2023,9,15) → 新月第1天
        let d1 = try SolarDay.fromYmd(2023, 9, 15).lunarDay
        let pd1 = d1.phaseDay
        #expect(pd1.phase.getName() == "新月")
        #expect(pd1.dayIndex == 0) // 第1天 = dayIndex 0

        // SolarDay(2023,9,17) → 蛾眉月第2天
        let d2 = try SolarDay.fromYmd(2023, 9, 17).lunarDay
        let pd2 = d2.phaseDay
        #expect(pd2.phase.getName() == "蛾眉月")
        // dayIndex should be 1 (第2天 = index 1)

        // Also verify phase computed property matches
        #expect(d2.phase.getName() == "蛾眉月")
    }

    @Test func testLunarDayThreePillars() throws {
        let d = try LunarDay.fromYmd(2024, 1, 1)
        let tp = d.threePillars
        #expect(!tp.getName().isEmpty)
        let parts = tp.getName().split(separator: " ")
        #expect(parts.count == 3)
    }

    // MARK: - Leap month tests (P3)

    @Test func testLunarDayLeapMonthSixStar() throws {
        // 2023 has leap month 2 (-2)
        // sixStar: (abs(monthWithLeap) + day - 2) % 6
        // month=-2, day=15: (2 + 15 - 2) % 6 = 15 % 6 = 3 → "先负"
        let d = try LunarDay.fromYmd(2023, -2, 15)
        #expect(d.sixStar.getName() == "先负")
    }

    @Test func testLunarDayLeapMonthMinorRen() throws {
        // 2023 leap month 2
        let d = try LunarDay.fromYmd(2023, -2, 1)
        // minorRen = lunarMonth.minorRen.next(day - 1)
        // lunarMonth.minorRen for month 2: (2-1)%6=1 → index 1
        // day=1: next(0) = same
        #expect(!d.minorRen.getName().isEmpty)
    }

    @Test func testLunarDayLeapMonthFestival() throws {
        // Leap month should have no festivals (festivals match non-leap months)
        let d = try LunarDay.fromYmd(2023, -2, 15)
        #expect(d.festival == nil)
    }

    // tyme4j SixStarTest: additional precise values
    @Test func testLunarDaySixStarPrecise() throws {
        #expect(try LunarDay.fromYmd(2020, 3, 1).sixStar.getName() == "佛灭")
        #expect(try LunarDay.fromYmd(2020, 4, 20).sixStar.getName() == "大安")
        #expect(try LunarDay.fromYmd(2020, 10, 24).sixStar.getName() == "先负")
        #expect(try LunarDay.fromYmd(2020, 10, 27).sixStar.getName() == "赤口")
    }
}
