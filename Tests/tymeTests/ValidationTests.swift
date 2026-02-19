import Testing
import Foundation
@testable import tyme

// MARK: - Fixture types

fileprivate struct SolarLunarCase: Decodable {
    let solar: String
    let lunarYear: String
    let lunarMonth: String
    let lunarDay: String
    let isLeapMonth: Bool
}

fileprivate struct SixtyCycleCase: Decodable {
    let solar: String
    let sixtyCycleYear: String
    let sixtyCycleMonth: String
    let sixtyCycleDay: String
}

// MARK: - Fixture loading

fileprivate func loadFixture<T: Decodable>(_ name: String, type: T.Type) throws -> [T] {
    let url = Bundle.module.url(
        forResource: name, withExtension: "json", subdirectory: "Fixtures")!
    let data = try Data(contentsOf: url)
    return try JSONDecoder().decode([T].self, from: data)
}

fileprivate func parseSolar(_ s: String) throws -> (Int, Int, Int) {
    let parts = s.split(separator: "-").compactMap { Int($0) }
    guard parts.count == 3 else { throw TymeError.invalidYear(0) }
    return (parts[0], parts[1], parts[2])
}

// MARK: - 1:1 Validation Suite

@Suite("tyme4j 1:1 Validation — Solar↔Lunar")
struct SolarLunarValidationTests {
    fileprivate static let cases: [SolarLunarCase] = (try? loadFixture("solar_lunar", type: SolarLunarCase.self)) ?? []

    @Test("SolarDay→LunarDay", arguments: cases)
    fileprivate func testSolarToLunar(_ c: SolarLunarCase) throws {
        let (y, m, d) = try parseSolar(c.solar)
        let solar = try SolarDay.fromYmd(y, m, d)
        let lunar = solar.lunarDay

        #expect(lunar.lunarMonth.lunarYear.name == c.lunarYear,
                "lunarYear mismatch for \(c.solar)")
        #expect(lunar.lunarMonth.name == c.lunarMonth,
                "lunarMonth mismatch for \(c.solar)")
        #expect(lunar.name == c.lunarDay,
                "lunarDay mismatch for \(c.solar)")
        #expect(lunar.lunarMonth.leap == c.isLeapMonth,
                "isLeapMonth mismatch for \(c.solar)")
    }
}

@Suite("tyme4j 1:1 Validation — SixtyCycle")
struct SixtyCycleValidationTests {
    fileprivate static let cases: [SixtyCycleCase] = (try? loadFixture("sixty_cycle", type: SixtyCycleCase.self)) ?? []

    @Test("SolarDay SixtyCycle pillars", arguments: cases)
    fileprivate func testSixtyCycle(_ c: SixtyCycleCase) throws {
        let (y, m, d) = try parseSolar(c.solar)
        let solar = try SolarDay.fromYmd(y, m, d)
        let day = solar.sixtyCycleDay

        #expect(day.yearPillar.name == c.sixtyCycleYear,
                "year pillar mismatch for \(c.solar)")
        #expect(day.monthPillar.name == c.sixtyCycleMonth,
                "month pillar mismatch for \(c.solar)")
        #expect(day.sixtyCycle.name == c.sixtyCycleDay,
                "day pillar mismatch for \(c.solar)")
    }
}
