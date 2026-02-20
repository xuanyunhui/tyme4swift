import Testing
import Foundation
@testable import tyme

@Suite("Fixture Loading Infrastructure")
struct FixtureLoaderTests {

    @Test("loadFixture throws CocoaError for missing fixture")
    func testLoadFixtureMissingFile() {
        #expect(throws: CocoaError.self) {
            _ = try loadFixture("nonexistent_fixture", type: SolarLunarCase.self)
        }
    }

    @Test("loadFixture successfully loads valid fixture")
    func testLoadFixtureValidFixture() throws {
        let cases = try loadFixture("solar_lunar", type: SolarLunarCase.self)
        #expect(!cases.isEmpty)
    }

    // Note: loadFixture()'s DecodingError path and I/O error paths cannot be tested
    // effectively in a unit test because:
    // - DecodingError requires a malformed JSON file in the bundle; test resources bundling
    //   is environment-specific and making a fixture that exists but is malformed is fragile.
    // - CocoaError (I/O) requires simulating file read failures, which is not practical
    //   in a normal test environment where fixtures are available.
    // Both error types are documented in the loadFixture() comments and are exercised
    // by real usage (if a fixture is corrupted or missing, the error will surface).

    // Note: requireFixture()'s empty fixture array path triggers preconditionFailure,
    // which cannot be caught by Swift Testing framework (preconditionFailure halts execution).
    // We only verify the happy path: requireFixture returns the same result as loadFixture.
    @Test("requireFixture returns same result as loadFixture for valid fixture")
    func testRequireFixtureHappyPath() throws {
        let fromLoadFixture = try loadFixture("solar_lunar", type: SolarLunarCase.self)
        let fromRequireFixture = requireFixture("solar_lunar", type: SolarLunarCase.self)
        #expect(fromLoadFixture.count == fromRequireFixture.count)
    }
}
