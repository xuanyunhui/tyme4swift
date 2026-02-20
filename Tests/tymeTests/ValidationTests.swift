import Testing
import Foundation
@testable import tyme

// MARK: - Fixture types

struct SolarLunarCase: Decodable {
    let solar: String
    let lunarYear: String
    let lunarMonth: String
    let lunarDay: String
    let isLeapMonth: Bool
}

struct SixtyCycleCase: Decodable {
    let solar: String
    let sixtyCycleYear: String
    let sixtyCycleMonth: String
    let sixtyCycleDay: String
}

// MARK: - Fixture loading

func loadFixture<T: Decodable>(_ name: String, type: T.Type) throws -> [T] {
    guard let url = Bundle.module.url(
        forResource: name, withExtension: "json", subdirectory: "Fixtures") else {
        throw TymeError.invalidDay(0)
    }
    let data = try Data(contentsOf: url)
    return try JSONDecoder().decode([T].self, from: data)
}

func parseSolar(_ s: String) throws -> (Int, Int, Int) {
    let parts = s.split(separator: "-").compactMap { Int($0) }
    guard parts.count == 3 else { throw TymeError.invalidDay(0) }
    return (parts[0], parts[1], parts[2])
}

// MARK: - 1:1 Validation Suite

@Suite("tyme4j 1:1 Validation — Solar↔Lunar")
struct SolarLunarValidationTests {
    static let cases: [SolarLunarCase] = {
        do {
            return try loadFixture("solar_lunar", type: SolarLunarCase.self)
        } catch {
            fatalError("Failed to load solar_lunar.json fixture: \(error)")
        }
    }()

    @Test("SolarDay→LunarDay", arguments: cases)
    func testSolarToLunar(_ c: SolarLunarCase) throws {
        let (y, m, d) = try parseSolar(c.solar)
        let solar = try SolarDay.fromYmd(y, m, d)
        let lunar = solar.lunarDay

        #expect(lunar.lunarMonth.lunarYear.name == c.lunarYear,
                "Expected \(c.lunarYear) but got \(lunar.lunarMonth.lunarYear.name) for \(c.solar)")
        #expect(lunar.lunarMonth.name == c.lunarMonth,
                "Expected \(c.lunarMonth) but got \(lunar.lunarMonth.name) for \(c.solar)")
        #expect(lunar.name == c.lunarDay,
                "Expected \(c.lunarDay) but got \(lunar.name) for \(c.solar)")
        #expect(lunar.lunarMonth.leap == c.isLeapMonth,
                "Expected leap=\(c.isLeapMonth) but got \(lunar.lunarMonth.leap) for \(c.solar)")
    }
}

@Suite("tyme4j 1:1 Validation — SixtyCycle")
struct SixtyCycleValidationTests {
    static let cases: [SixtyCycleCase] = {
        do {
            return try loadFixture("sixty_cycle", type: SixtyCycleCase.self)
        } catch {
            fatalError("Failed to load sixty_cycle.json fixture: \(error)")
        }
    }()

    @Test("SolarDay SixtyCycle pillars", arguments: cases)
    func testSixtyCycle(_ c: SixtyCycleCase) throws {
        let (y, m, d) = try parseSolar(c.solar)
        let solar = try SolarDay.fromYmd(y, m, d)
        let day = solar.sixtyCycleDay

        #expect(day.yearPillar.name == c.sixtyCycleYear,
                "Expected year pillar \(c.sixtyCycleYear) but got \(day.yearPillar.name) for \(c.solar)")
        #expect(day.monthPillar.name == c.sixtyCycleMonth,
                "Expected month pillar \(c.sixtyCycleMonth) but got \(day.monthPillar.name) for \(c.solar)")
        #expect(day.sixtyCycle.name == c.sixtyCycleDay,
                "Expected day pillar \(c.sixtyCycleDay) but got \(day.sixtyCycle.name) for \(c.solar)")
    }
}
