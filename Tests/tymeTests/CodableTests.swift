import Foundation
import Testing
@testable import tyme

@Suite struct CodableTests {

    // MARK: - SolarDay

    @Test func testSolarDayCodableRoundTrip() throws {
        let original = try SolarDay.fromYmd(2024, 1, 15)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(SolarDay.self, from: data)
        #expect(decoded.year == original.year)
        #expect(decoded.month == original.month)
        #expect(decoded.day == original.day)
    }

    @Test func testSolarDayCodableLeapYear() throws {
        let original = try SolarDay.fromYmd(2024, 2, 29)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(SolarDay.self, from: data)
        #expect(decoded.year == 2024)
        #expect(decoded.month == 2)
        #expect(decoded.day == 29)
    }

    // MARK: - LunarDay

    @Test func testLunarDayCodableRoundTrip() throws {
        let original = try LunarDay(year: 2024, month: 1, day: 15)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(LunarDay.self, from: data)
        #expect(decoded.year == original.year)
        #expect(decoded.month == original.month)
        #expect(decoded.day == original.day)
    }

    @Test func testLunarDayCodableLeapMonth() throws {
        // 2023 has leap month 2
        let original = try LunarDay(year: 2023, month: -2, day: 15)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(LunarDay.self, from: data)
        #expect(decoded.year == original.year)
        #expect(decoded.monthWithLeap == original.monthWithLeap) // negative = leap
        #expect(decoded.day == original.day)
        #expect(decoded.monthWithLeap < 0)
    }

    // MARK: - SolarTime

    @Test func testSolarTimeCodableRoundTrip() throws {
        let original = try SolarTime(year: 2024, month: 6, day: 15, hour: 12, minute: 30, second: 45)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(SolarTime.self, from: data)
        #expect(decoded.year == original.year)
        #expect(decoded.month == original.month)
        #expect(decoded.day == original.day)
        #expect(decoded.hour == original.hour)
        #expect(decoded.minute == original.minute)
        #expect(decoded.second == original.second)
    }

    @Test func testSolarTimeCodableMidnight() throws {
        let original = try SolarTime(year: 2024, month: 1, day: 1, hour: 0, minute: 0, second: 0)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(SolarTime.self, from: data)
        #expect(decoded.year == 2024)
        #expect(decoded.month == 1)
        #expect(decoded.day == 1)
        #expect(decoded.hour == 0)
        #expect(decoded.minute == 0)
        #expect(decoded.second == 0)
    }

    // MARK: - EightChar

    @Test func testEightCharCodableRoundTrip() throws {
        let original = EightChar(
            year: SixtyCycle.fromIndex(0),
            month: SixtyCycle.fromIndex(2),
            day: SixtyCycle.fromIndex(10),
            hour: SixtyCycle.fromIndex(5)
        )
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(EightChar.self, from: data)
        #expect(decoded.year == original.year)
        #expect(decoded.month == original.month)
        #expect(decoded.day == original.day)
        #expect(decoded.hour == original.hour)
        #expect(decoded.getName() == original.getName())
    }

    @Test func testEightCharCodableJsonShape() throws {
        let ec = EightChar(
            year: SixtyCycle.fromIndex(0),
            month: SixtyCycle.fromIndex(2),
            day: SixtyCycle.fromIndex(10),
            hour: SixtyCycle.fromIndex(5)
        )
        let data = try JSONEncoder().encode(ec)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Int]
        #expect(json?["year"] == 0)
        #expect(json?["month"] == 2)
        #expect(json?["day"] == 10)
        #expect(json?["hour"] == 5)
    }

    // MARK: - SixtyCycle

    @Test func testSixtyCycleCodableRoundTrip() throws {
        let original = SixtyCycle.fromIndex(0) // 甲子
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(SixtyCycle.self, from: data)
        #expect(decoded.index == original.index)
        #expect(decoded.getName() == original.getName())
    }

    @Test func testSixtyCycleCodableAllIndices() throws {
        for i in 0..<60 {
            let original = SixtyCycle.fromIndex(i)
            let data = try JSONEncoder().encode(original)
            let decoded = try JSONDecoder().decode(SixtyCycle.self, from: data)
            #expect(decoded.index == i)
            #expect(decoded.getName() == original.getName())
        }
    }
}
