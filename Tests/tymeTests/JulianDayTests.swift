import Testing
@testable import tyme

@Suite struct JulianDayTests {
    @Test func testJulianDay() throws {
        let jd = try JulianDay.fromYmdHms(year: 2000, month: 1, day: 1)
        let solar = jd.getSolarDay()
        #expect(solar.getYear() == 2000)
        #expect(solar.getMonth() == 1)
        #expect(solar.getDay() == 1)
    }
}
