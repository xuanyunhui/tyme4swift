# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Test Commands

```bash
swift build          # Build the package
swift test           # Run all tests (74 XCTest + 1 Swift Testing)
swift test --filter Tyme4SwiftTests/testSolarDay   # Run a single test
```

No linter or formatter is configured. No external dependencies.

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
| `star/` | Star systems: NineStar, SevenStar, SixStar, TenStar, TwentyEightStar, Ecliptic |
| `pengzu/` | Pengzu taboos (彭祖百忌): PengZu, PengZuHeavenStem, PengZuEarthBranch |
| `enums/` | Swift enums: YinYang, Gender, Side, FestivalType, HideHeavenStemType |
| `jd/` | JulianDay astronomical calculations |
| `unit/` | Time units: DayUnit, MonthUnit, YearUnit, WeekUnit, SecondUnit |
| `util/` | ShouXingUtil — core astronomical algorithms (planetary longitudes, solar terms) |

### Key Design Decisions

- **Factory methods over failable initializers**: Classes use `fromYmd()`, `fromIndex()`, `fromName()` static factories. Some return optionals, some `fatalError` on invalid input.
- **Provider protocol pattern**: EightChar calculations are pluggable via `EightCharProvider`, `ChildLimitProvider`, `DecadeFortuneProvider` protocols with default implementations.
- **`public final` for concrete classes, `open` for base classes**: Base classes (AbstractCulture, AbstractTyme, LoopTyme, AbstractCultureDay) and unit classes are `open` for subclassing; concrete implementations (HeavenStem, SolarDay, Element, etc.) are `public final`.
- **Reference implementation alignment**: Algorithm logic should match [tyme4j](https://github.com/6tail/tyme4j). When in doubt, consult the Java source.

### Tests

Single test file at `Tests/tymeTests/Tyme4SwiftTests.swift` containing all XCTest cases. Tests are organized by `testXxx()` methods covering each subsystem.

## Alignment Status

Tracking issue: [#10](https://github.com/xuanyunhui/tyme4swift/issues/10). Missing vs tyme4j: ThreePillars, KitchenGodSteed, Ren, FetusDay/FetusHour, and ChildLimit provider variants (LunarSect1/Sect2/China95).
