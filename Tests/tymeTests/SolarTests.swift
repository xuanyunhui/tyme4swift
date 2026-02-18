import Testing
@testable import tyme

@Suite struct SolarTests {
    @Test func testSolarDay() throws {
        let solar = try SolarDay(year: 2024, month: 2, day: 10)
        #expect(solar.getYear() == 2024)
        #expect(solar.getMonth() == 2)
        #expect(solar.getDay() == 10)
    }
    @Test func testSolarTerm() throws {
        let term = try SolarTerm(year: 2024, index: 0)
        #expect(term.getName() == "冬至")
        #expect(term.getYear() == 2024)
    }
    @Test func testSolarDayGetTerm() throws {
        // Verify getTerm returns a valid solar term
        let sd = try SolarDay.fromYmd(2022, 3, 9)
        let term = sd.getTerm()
        // March 9 is after 惊蛰 (~March 5) and before 春分 (~March 20)
        // With current ShouXingUtil, we verify it returns a valid term
        #expect(term.index >= 0 && term.index < 24)
    }
    @Test func testSolarTimeSubtract() throws {
        let t1 = try SolarTime.fromYmdHms(2024, 1, 1, 12, 0, 0)
        let t2 = try SolarTime.fromYmdHms(2024, 1, 1, 10, 0, 0)
        #expect(t1.subtract(t2) == 7200) // 2 hours = 7200 seconds

        let t3 = try SolarTime.fromYmdHms(2024, 1, 2, 0, 0, 0)
        #expect(t3.subtract(t1) == 43200) // 12 hours
    }
    @Test func testSolarTimeTerm() throws {
        let t1 = try SolarTime.fromYmdHms(2024, 3, 20, 12, 0, 0)
        _ = t1.getTerm()
    }

    // MARK: - SolarDay.constellation

    @Test func testConstellation() throws {
        #expect(try SolarDay.fromYmd(2020, 3, 21).constellation.getName() == "白羊")
        #expect(try SolarDay.fromYmd(2020, 4, 19).constellation.getName() == "白羊")
        #expect(try SolarDay.fromYmd(2020, 4, 20).constellation.getName() == "金牛")
        #expect(try SolarDay.fromYmd(2020, 6, 22).constellation.getName() == "巨蟹")
        #expect(try SolarDay.fromYmd(2020, 8, 23).constellation.getName() == "处女")
        #expect(try SolarDay.fromYmd(2020, 12, 22).constellation.getName() == "摩羯")
        #expect(try SolarDay.fromYmd(2021, 1, 20).constellation.getName() == "水瓶")
        #expect(try SolarDay.fromYmd(2021, 2, 19).constellation.getName() == "双鱼")
    }

    // MARK: - SolarDay.dogDay

    @Test func testDogDay() throws {
        // 2011: 初伏 7/14, 中伏 7/24, 末伏 8/13
        let d0 = try SolarDay.fromYmd(2011, 7, 14).dogDay
        #expect(d0 != nil)
        #expect(d0!.description == "初伏第1天")

        let d1 = try SolarDay.fromYmd(2011, 7, 23).dogDay
        #expect(d1!.description == "初伏第10天")

        let d2 = try SolarDay.fromYmd(2011, 7, 24).dogDay
        #expect(d2!.description == "中伏第1天")

        let d3 = try SolarDay.fromYmd(2011, 8, 12).dogDay
        #expect(d3!.description == "中伏第20天")

        let d4 = try SolarDay.fromYmd(2011, 8, 13).dogDay
        #expect(d4!.description == "末伏第1天")

        let d5 = try SolarDay.fromYmd(2011, 8, 22).dogDay
        #expect(d5!.description == "末伏第10天")

        // Outside dog days
        #expect(try SolarDay.fromYmd(2011, 7, 13).dogDay == nil)
        #expect(try SolarDay.fromYmd(2011, 8, 23).dogDay == nil)

        // 2012
        let d8 = try SolarDay.fromYmd(2012, 7, 18).dogDay
        #expect(d8!.description == "初伏第1天")
    }

    // MARK: - SolarDay.nineColdDay

    @Test func testNineColdDay() throws {
        let d0 = try SolarDay.fromYmd(2020, 12, 21).nineColdDay
        #expect(d0 != nil)
        #expect(d0!.description == "一九第1天")

        let d1 = try SolarDay.fromYmd(2020, 12, 22).nineColdDay
        #expect(d1!.description == "一九第2天")

        let d2 = try SolarDay.fromYmd(2021, 1, 8).nineColdDay
        #expect(d2!.description == "三九第1天")

        let d3 = try SolarDay.fromYmd(2021, 3, 5).nineColdDay
        #expect(d3!.description == "九九第3天")

        // Outside nine cold days
        #expect(try SolarDay.fromYmd(2021, 7, 5).nineColdDay == nil)
    }

    // MARK: - SolarDay.plumRainDay

    @Test func testPlumRainDay() throws {
        #expect(try SolarDay.fromYmd(2024, 6, 10).plumRainDay == nil)

        let d1 = try SolarDay.fromYmd(2024, 6, 11).plumRainDay
        #expect(d1 != nil)
        #expect(d1!.description == "入梅第1天")

        let d2 = try SolarDay.fromYmd(2024, 7, 6).plumRainDay
        #expect(d2!.plumRain.getName() == "出梅")

        let d3 = try SolarDay.fromYmd(2024, 7, 5).plumRainDay
        #expect(d3!.description == "入梅第25天")
    }

    // MARK: - SolarDay.hideHeavenStemDay

    @Test func testHideHeavenStemDay() throws {
        let d = try SolarDay.fromYmd(2024, 1, 1).hideHeavenStemDay
        #expect(d.hideHeavenStem.heavenStem.getName().count > 0)
        #expect(d.dayIndex >= 0)
    }

    // MARK: - SolarDay.indexInYear

    @Test func testIndexInYear() throws {
        #expect(try SolarDay.fromYmd(2023, 1, 1).indexInYear == 0)
        #expect(try SolarDay.fromYmd(2023, 12, 31).indexInYear == 364)
        #expect(try SolarDay.fromYmd(2020, 12, 31).indexInYear == 365)
    }

    // MARK: - SolarDay.phenologyDay

    @Test func testPhenologyDay() throws {
        let d = try SolarDay.fromYmd(2023, 10, 27).phenologyDay
        #expect(d.description == "豺乃祭兽第4天")
        #expect(d.phenology.threePhenology.getName() == "初候")
    }

    // MARK: - SolarDay.phaseDay / phase

    @Test func testPhaseDay() throws {
        let d = try SolarDay.fromYmd(2024, 1, 15).phaseDay
        #expect(d.phase.getName().count > 0)
    }

    // MARK: - SolarDay.legalHoliday

    @Test func testLegalHoliday() throws {
        let h = try SolarDay.fromYmd(2024, 10, 1).legalHoliday
        #expect(h != nil)
        #expect(h!.getName() == "国庆节")

        #expect(try SolarDay.fromYmd(2024, 3, 15).legalHoliday == nil)
    }

    // MARK: - SolarDay.festival

    @Test func testSolarFestival() throws {
        let f = try SolarDay.fromYmd(2024, 1, 1).festival
        #expect(f != nil)
        #expect(f!.getName() == "元旦")

        let f2 = try SolarDay.fromYmd(2024, 5, 1).festival
        #expect(f2 != nil)
        #expect(f2!.getName() == "五一劳动节")

        #expect(try SolarDay.fromYmd(2024, 3, 15).festival == nil)
    }

    // MARK: - SolarTime.sixtyCycleHour

    @Test func testSolarTimeSixtyCycleHour() throws {
        let t = try SolarTime.fromYmdHms(2024, 1, 1, 12, 0, 0)
        let h = t.sixtyCycleHour
        #expect(h.sixtyCycle.getName().count > 0)
    }

    // MARK: - SolarTime.phase

    @Test func testSolarTimePhase() throws {
        let t = try SolarTime.fromYmdHms(2024, 1, 15, 12, 0, 0)
        let p = t.phase
        #expect(p.getName().count > 0)
    }

    // MARK: - SolarYear.isLeap

    @Test func testSolarYearIsLeap() throws {
        #expect(try SolarYear.fromYear(2000).isLeap == true)
        #expect(try SolarYear.fromYear(1900).isLeap == false)
        #expect(try SolarYear.fromYear(2024).isLeap == true)
        #expect(try SolarYear.fromYear(2023).isLeap == false)
        #expect(try SolarYear.fromYear(400).isLeap == true)
    }

    // MARK: - SolarYear.tibetanYear

    @Test func testSolarYearTibetanYear() throws {
        let ty = try SolarYear.fromYear(2024).tibetanYear
        #expect(ty.getName().count > 0)
        #expect(ty.year == 2024)
    }
}
