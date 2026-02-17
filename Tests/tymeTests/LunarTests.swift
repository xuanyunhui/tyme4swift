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
}
