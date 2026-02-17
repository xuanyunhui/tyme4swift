import Testing
@testable import tyme

@Suite struct RegressionTests {
    @Test func testGetLunarDayNoOverflow() throws {
        let tp = ThreePillars(yearName: "甲戌", monthName: "甲戌", dayName: "甲戌")
        let days = tp.getSolarDays(startYear: 1, endYear: 2200)
        #expect(!days.isEmpty)
    }
    @Test func testGetLunarDayNoOverflowCount() throws {
        let tp = ThreePillars(yearName: "甲戌", monthName: "甲戌", dayName: "甲戌")
        let days = tp.getSolarDays(startYear: 1, endYear: 2200)
        #expect(days.count == 19)
    }
    @Test func testGetLunarDayBoundaryDates() throws {
        let d1 = try SolarDay.fromYmd(1, 2, 12)
        #expect(d1.getLunarDay().getDay() >= 1 && d1.getLunarDay().getDay() <= 30)

        let d2 = try SolarDay.fromYmd(100, 1, 1)
        #expect(d2.getLunarDay().getDay() >= 1 && d2.getLunarDay().getDay() <= 30)

        // 2024-02-10 is lunar new year
        #expect("初一" == (try SolarDay.fromYmd(2024, 2, 10).getLunarDay().getName()))
    }
    @Test func testGetLunarDayLeapMonth() throws {
        let d = try SolarDay.fromYmd(2023, 4, 20)
        #expect(d.getLunarDay().getDay() >= 1 && d.getLunarDay().getDay() <= 30)
    }
    @Test func testElementNamesOrder() throws {
        #expect(Element.fromIndex(0).getName() == "木")
        #expect(Element.fromIndex(1).getName() == "火")
        #expect(Element.fromIndex(2).getName() == "土")
        #expect(Element.fromIndex(3).getName() == "金")
        #expect(Element.fromIndex(4).getName() == "水")
    }
    @Test func testNineStarElementUnaffected() throws {
        #expect(NineStar.fromIndex(0).getElement().getName() == "水")
    }
    @Test func testSoundElementUnaffected() throws {
        #expect(!Sound.fromIndex(0).getElement().getName().isEmpty)
    }
    @Test func testGodTabooDataIntegrity() throws {
        // Test specific date from Issue #42
        let day = try SixtyCycleDay(year: 2024, month: 12, day: 1)
        let gods = day.getGods()
        #expect(gods.count > 0)
        _ = day.getRecommends()
        _ = day.getAvoids()
    }
    @Test func testGodTabooFullYear2024() throws {
        let daysInMonth = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        for m in 1...12 {
            for d in 1...daysInMonth[m - 1] {
                let day = try SixtyCycleDay(year: 2024, month: m, day: d)
                let _ = day.getGods()
                let _ = day.getRecommends()
                let _ = day.getAvoids()
            }
        }
    }
}
