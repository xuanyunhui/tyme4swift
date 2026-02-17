import XCTest
@testable import tyme

final class RegressionTests: XCTestCase {
    func testGetLunarDayNoOverflow() throws {
        let tp = ThreePillars(yearName: "甲戌", monthName: "甲戌", dayName: "甲戌")
        let days = tp.getSolarDays(startYear: 1, endYear: 2200)
        XCTAssertFalse(days.isEmpty, "Should find matching solar days without crashing")
    }
    func testGetLunarDayNoOverflowCount() throws {
        let tp = ThreePillars(yearName: "甲戌", monthName: "甲戌", dayName: "甲戌")
        let days = tp.getSolarDays(startYear: 1, endYear: 2200)
        XCTAssertEqual(days.count, 19, "Should find exactly 19 matching solar days")
    }
    func testGetLunarDayBoundaryDates() throws {
        let d1 = try SolarDay.fromYmd(1, 2, 12)
        XCTAssertTrue(d1.getLunarDay().getDay() >= 1 && d1.getLunarDay().getDay() <= 30)

        let d2 = try SolarDay.fromYmd(100, 1, 1)
        XCTAssertTrue(d2.getLunarDay().getDay() >= 1 && d2.getLunarDay().getDay() <= 30)

        // 2024-02-10 is lunar new year
        XCTAssertEqual("初一", try SolarDay.fromYmd(2024, 2, 10).getLunarDay().getName())
    }
    func testGetLunarDayLeapMonth() throws {
        let d = try SolarDay.fromYmd(2023, 4, 20)
        XCTAssertTrue(d.getLunarDay().getDay() >= 1 && d.getLunarDay().getDay() <= 30)
    }
    func testElementNamesOrder() throws {
        XCTAssertEqual("木", Element.fromIndex(0).getName())
        XCTAssertEqual("火", Element.fromIndex(1).getName())
        XCTAssertEqual("土", Element.fromIndex(2).getName())
        XCTAssertEqual("金", Element.fromIndex(3).getName())
        XCTAssertEqual("水", Element.fromIndex(4).getName())
    }
    func testNineStarElementUnaffected() throws {
        XCTAssertEqual("水", NineStar.fromIndex(0).getElement().getName())
    }
    func testSoundElementUnaffected() throws {
        XCTAssertFalse(Sound.fromIndex(0).getElement().getName().isEmpty)
    }
    func testGodTabooDataIntegrity() throws {
        // Test specific date from Issue #42
        let day = try SixtyCycleDay(year: 2024, month: 12, day: 1)
        let gods = day.getGods()
        XCTAssertTrue(gods.count > 0, "Gods list should not be empty for 2024-12-01")
        let recommends = day.getRecommends()
        XCTAssertNotNil(recommends, "Recommends should not be nil for 2024-12-01")
        let avoids = day.getAvoids()
        XCTAssertNotNil(avoids, "Avoids should not be nil for 2024-12-01")
    }
    func testGodTabooFullYear2024() throws {
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
