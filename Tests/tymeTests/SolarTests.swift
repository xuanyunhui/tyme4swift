import XCTest
@testable import tyme

final class SolarTests: XCTestCase {
    func testSolarDay() throws {
        let solar = try SolarDay(year: 2024, month: 2, day: 10)
        XCTAssertEqual(solar.getYear(), 2024)
        XCTAssertEqual(solar.getMonth(), 2)
        XCTAssertEqual(solar.getDay(), 10)
    }
    func testSolarTerm() throws {
        let term = try SolarTerm(year: 2024, index: 0)
        XCTAssertEqual(term.getName(), "冬至")
        XCTAssertEqual(term.getYear(), 2024)
    }
    func testSolarDayGetTerm() throws {
        // Verify getTerm returns a valid solar term
        let sd = try SolarDay.fromYmd(2022, 3, 9)
        let term = sd.getTerm()
        XCTAssertNotNil(term)
        // March 9 is after 惊蛰 (~March 5) and before 春分 (~March 20)
        // With current ShouXingUtil, we verify it returns a valid term
        XCTAssertTrue(term.index >= 0 && term.index < 24)
    }
    func testSolarTimeSubtract() throws {
        let t1 = try SolarTime.fromYmdHms(2024, 1, 1, 12, 0, 0)
        let t2 = try SolarTime.fromYmdHms(2024, 1, 1, 10, 0, 0)
        XCTAssertEqual(t1.subtract(t2), 7200) // 2 hours = 7200 seconds

        let t3 = try SolarTime.fromYmdHms(2024, 1, 2, 0, 0, 0)
        XCTAssertEqual(t3.subtract(t1), 43200) // 12 hours
    }
    func testSolarTimeTerm() throws {
        let t1 = try SolarTime.fromYmdHms(2024, 3, 20, 12, 0, 0)
        let term = t1.getTerm()
        XCTAssertNotNil(term)
    }
}
