# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Test Commands

```bash
swift build          # Build the package
swift test           # Run all tests (125 tests across 11 files)
swift test --filter SolarTests/testSolarDay   # Run a single test
swift run -c release TymeBenchmarks           # Run performance benchmarks
```

No linter or formatter is configured. Dependencies: swift-docc-plugin (documentation), google/swift-benchmark (benchmarks).

## CI/CD

- **PR CI** (`.github/workflows/ci.yml`): Runs `swift build` + `swift test` with code coverage on push to main and pull requests (Swift 6.2, Ubuntu + macOS)
- **Publish** (`.github/workflows/publish.yml`): Release publishing workflow (Swift 6.2)

## Architecture

This is a Swift Package (`tyme`) that ports the Java library [tyme4j](https://github.com/6tail/tyme4j) — a Chinese calendar and metaphysics toolkit covering solar, lunar, Tibetan calendars, sexagenary cycles, Eight Characters (Bazi), and cultural astrology systems.

### Core Class Hierarchy

```
Culture (protocol) → getName()
  └─ AbstractCulture (base class)
       ├─ AbstractTyme → adds next(_:) for time-based navigation
       │    └─ LoopTyme → cyclic types with NAMES array + index
       └─ AbstractCultureDay → culture + dayIndex pair (e.g., DogDay, NineColdDay)
```

**LoopTyme pattern** — the dominant pattern used by ~30 classes (Element, HeavenStem, EarthBranch, Zodiac, etc.):
- Static `NAMES` array defines the cycle
- `fromIndex(_:)` / `fromName(_:)` factory methods
- `next(_:)` wraps around the cycle
- Subclass must add `required init(names:index:)` forwarding to super

**AbstractCultureDay pattern** — used for "Nth day of a cultural period" (DogDay, NineColdDay, PlumRainDay):
- `init(culture:dayIndex:)` — the culture object + 0-based day offset

### Module Layout (Sources/tyme/)

| Directory | Purpose |
|-----------|---------|
| `core/` | Tyme protocol, AbstractTyme, LoopTyme, AbstractCulture, AbstractCultureDay |
| `solar/` | Gregorian calendar: SolarDay, SolarMonth, SolarYear, SolarTime, SolarTerm |
| `lunar/` | Chinese lunar calendar: LunarDay, LunarMonth, LunarYear, LunarHour |
| `sixtycycle/` | Sexagenary cycle: HeavenStem, EarthBranch, SixtyCycle, day/month/year/hour pillars |
| `eightchar/` | Bazi system: EightChar, Fortune, DecadeFortune, ChildLimit, provider protocols |
| `tibetan/` | Tibetan calendar: RabByung, TibetanYear/Month/Day |
| `culture/` | Cultural types: Element, Direction, Zodiac, Sound, NaYin, Terrain, Phenology, festivals, gods, taboos, etc. |
| `culture/ren/` | MinorRen (小六壬) divination system |
| `culture/fetus/` | Fetus system: Fetus, FetusOrigin, FetusDay, FetusMonth, FetusHeavenStem, FetusEarthBranch |
| `star/` | Star systems: NineStar, SevenStar, SixStar, TenStar, TwentyEightStar, Ecliptic |
| `pengzu/` | Pengzu taboos (彭祖百忌): PengZu, PengZuHeavenStem, PengZuEarthBranch |
| `enums/` | Swift enums: YinYang, Gender, Side, FestivalType, HideHeavenStemType |
| `jd/` | JulianDay astronomical calculations |
| `unit/` | Time units: DayUnit, MonthUnit, YearUnit, WeekUnit, SecondUnit |
| `util/` | ShouXingUtil — core astronomical algorithms (planetary longitudes, solar terms) |

### Key Design Decisions

- **Throwing initializers with TymeError**: Classes use `fromYmd()`, `fromIndex()`, `fromName()` static factories. Invalid input throws `TymeError` (defined in `core/TymeError.swift`) with cases like `.invalidName`, `.invalidYear`, `.invalidDay`, etc.
- **Equatable/Hashable**: `LoopTyme` conforms to `Equatable` and `Hashable` based on `type(of:)` + `index` — different subclass types with same index are NOT equal.
- **Provider protocol pattern**: EightChar calculations are pluggable via `EightCharProvider`, `ChildLimitProvider`, `DecadeFortuneProvider` protocols with default implementations.
- **`public final` for concrete classes, `open` for base classes**: Base classes (AbstractCulture, AbstractTyme, LoopTyme, AbstractCultureDay) and unit classes are `open` for subclassing; concrete implementations (HeavenStem, SolarDay, Element, etc.) are `public final`.
- **Reference implementation alignment**: Algorithm logic should match [tyme4j](https://github.com/6tail/tyme4j). When in doubt, consult the Java source.
- **Codable support**: SolarDay, LunarDay, SolarTime, EightChar, SixtyCycle conform to `Codable` via extensions. Each type encodes only minimal reconstruction data (e.g., EightChar encodes solarYear/Month/Day/Hour; LunarDay uses negative month for leap months).
- **Swift API conventions**: All `getXxx()` methods have modern computed property equivalents (`var xxx`). Old methods are preserved with `@available(*, deprecated, renamed:)` annotations. Boolean predicates use `var auspicious: Bool` (adjective) or `var isBowl: Bool` (noun) pattern.

### Tests

125 tests (Swift Testing) across 11 module-based files in `Tests/tymeTests/`:

| File | Tests | Coverage |
|------|-------|----------|
| `SolarTests.swift` | 5 | Solar calendar |
| `LunarTests.swift` | 2 | Lunar calendar |
| `SixtyCycleTests.swift` | 10 | Sexagenary cycles |
| `EightCharTests.swift` | 14 | Bazi system |
| `CultureTests.swift` | 49 | Cultural types |
| `GodTests.swift` | 15 | God/taboo system |
| `FetusTests.swift` | 7 | Fetus system |
| `JulianDayTests.swift` | 1 | Julian day |
| `RegressionTests.swift` | 9 | Regression protection |
| `EquatableHashableTests.swift` | 2 | Protocol conformance |
| `CodableTests.swift` | 10 | Codable round-trip |

## Alignment Status

All tyme4j features have been ported. Tracking issue [#10](https://github.com/xuanyunhui/tyme4swift/issues/10) is closed.

**Fixed issues:**
- [#14](https://github.com/xuanyunhui/tyme4swift/issues/14) SolarDay.getLunarDay() overflow - fixed via full ShouXingUtil port (commit 88021fa)
- [#19](https://github.com/xuanyunhui/tyme4swift/issues/19) Element.NAMES order alignment with tyme4j (commit 6384c2b)
- 10 acceptance tests added for regression protection (PR #23, commit 28d9cbf)

## Improvement Roadmap

Tracked via GitHub Issues. Phase 1 (complete), Phase 2 (#30-#33), Phase 3 (#34).

**Phase 1 (complete):** CI infrastructure — PR #35 (ci.yml + coverage), PR #36 (publish.yml fix + CONTRIBUTING.md fix)

**Phase 2 (complete):**
- [#30](https://github.com/xuanyunhui/tyme4swift/issues/30) God/Taboo lookup for SixtyCycleDay — PR #37
- [#31](https://github.com/xuanyunhui/tyme4swift/issues/31) Missing classes: HideHeavenStemDay, RabByungElement, PhenologyDay — PR #45
- [#32](https://github.com/xuanyunhui/tyme4swift/issues/32) Replace fatalError with TymeError throws — PR #46
- [#33](https://github.com/xuanyunhui/tyme4swift/issues/33) Split test file + Equatable/Hashable — PR #47, #48

**Phase 3 (complete):** [#34](https://github.com/xuanyunhui/tyme4swift/issues/34) Swift ecosystem integration
- Phase 3a: Multi-platform CI (Ubuntu + macOS) + Swift Testing migration (114 tests migrated) — PR #50-#53
- Phase 3b: API modernization — 328 `getXxx()` → computed properties across all modules — PR #54-#59
- Phase 3c: Codable support (5 core types, 10 tests) + DocC documentation (6 core types) — PR #70, #71
- Phase 3d: Performance benchmarks using google/swift-benchmark (10 benchmarks) — PR #72
- Bug fixes & improvements: god direction crash fix, star module isXxx conversion, CI Swift version fix — PR #60-#69
