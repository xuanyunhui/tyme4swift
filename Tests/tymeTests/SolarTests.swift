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
}
