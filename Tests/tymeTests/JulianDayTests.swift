import XCTest
@testable import tyme

final class JulianDayTests: XCTestCase {
    func testJulianDay() throws {
        let jd = try JulianDay.fromYmdHms(year: 2000, month: 1, day: 1)
        let solar = jd.getSolarDay()
        XCTAssertEqual(solar.getYear(), 2000)
        XCTAssertEqual(solar.getMonth(), 1)
        XCTAssertEqual(solar.getDay(), 1)
    }
}
