import XCTest
@testable import tyme

final class LunarTests: XCTestCase {
    func testLunarYear() throws {
        let lunar = try LunarYear.fromYear(2024)
        XCTAssertNotNil(lunar)
        XCTAssertEqual(lunar.getYear(), 2024)
    }
    func testLunarEightCharProvider() throws {
        let provider = LunarEightCharProvider()

        // Test year pillar
        let yearSixtyCycle = provider.getYearSixtyCycle(year: 2024, month: 2, day: 10)
        XCTAssertNotNil(yearSixtyCycle)

        // Test month pillar
        let monthSixtyCycle = provider.getMonthSixtyCycle(year: 2024, month: 2, day: 10)
        XCTAssertNotNil(monthSixtyCycle)

        // Test day pillar
        let daySixtyCycle = provider.getDaySixtyCycle(year: 2024, month: 2, day: 10)
        XCTAssertNotNil(daySixtyCycle)

        // Test hour pillar
        let hourSixtyCycle = provider.getHourSixtyCycle(year: 2024, month: 2, day: 10, hour: 12)
        XCTAssertNotNil(hourSixtyCycle)
    }
}
