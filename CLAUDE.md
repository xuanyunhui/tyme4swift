# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Code Style

- Use `struct` and `mutating func` for all code.
- Use `OptionSet` for all bitwise operations.
- Use `Int`/`Int64` for all numerical calculations. (avoid `Double` unless strictly necessary for Astronomy).
- Use `Optional` for all possible failures.
- Use `throw Error` for all possible failures.
- Use `public final` for all concrete classes.
- Use `open` for all base classes.
- **NO FORCE UNWRAP (`!`)**. Use `guard let` or `throw`.
- Naming: Use Swift "Term of Art" (e.g., `computed property` instead of `getFoo()`).

## Error Handling

- **Throwing methods**: Use `throw TymeError.*` for all validation failures. Never use `fatalError` or `preconditionFailure` in throwing contexts — these were systematically replaced in Phase 2 (Issue #32).
- **Non-throwing overrides** (e.g., `next(_ n: Int) -> Self` from `AbstractTyme`): Cannot `throw`. Use explicit `guard let ... else { return self }` for expected out-of-range inputs (boundary behavior). Use `preconditionFailure("diagnostic message")` only for **internal invariant violations** (i.e., conditions that indicate a bug, not user input error).
- **Consistency within a method**: Do not mix `return self` and `preconditionFailure` for the same class of failure in one method. Decide: is this a boundary (→ `return self`) or a bug (→ `preconditionFailure`)?

## Audit Commands (Orchestration)

- **`/audit <pr_id>`**: 全量审计（包含 Simplifier）。
    - 报告中需包含 `✨ Code Health` 章节。
- **`/audit-quick <pr_id>`**: 触发快速检查。
    - 仅调用 `code-reviewer` 和 `pr-test-analyzer`。
- **`/audit-fix <issue_id>`**: 针对特定问题调用 `code-simplifier` 生成修复代码。
- **`/simplify <file_path>`**: **[专项指令]**
    - 仅对指定文件运行 `code-simplifier`。
    - **Action**: 展示简化建议，并询问用户是否直接应用 (Apply Patch)。
- **`/refactor-pr <pr_id>`**:
    - 运行 `code-simplifier` 对 PR 中的所有文件进行扫描。
    - 如果发现高置信度的简化方案，**直接生成一个新的 Commit 建议**。

上述命令在评审流程中由 **Audit Manager** 等 agent 调用；完整 agent 角色与阶段对应见下方 **Agent Teams**。

## Agent Teams（团队结构与工作流）

| 角色 | 职责 | Agent / 工具 | 所在阶段 |
|------|------|--------------|----------|
| **开发** | 实现功能、按反馈修复、遵循 CLAUDE.md | `ios-dev`（`.claude/agents/ios-dev.md`） | ① 开发 |
| **QA** | 测试策略、用例、执行（如 `swift test`）、测试报告与 Sign-off | `qa`（`.claude/agents/qa.md`） | ② 构建与测试 |
| **架构师** | PR 架构评审（模块/模式/依赖/CLAUDE 约定），输出 APPROVE/REQUEST_CHANGES | `architect`（`.claude/agents/architect.md`） | ③ 提交与评审（一轨） |
| **Audit Manager** | 全量审计，调度 code-reviewer、silent-failure-hunter、pr-test-analyzer、code-simplifier 等，输出审计报告与 Sign-off/Reject | `audit-manager`（`.claude/agents/audit-manager.md`） | ③ 提交与评审（另一轨） |
| **Team Lead** | 合并 PR、更新 Issue checklist、通知下一 Phase | 人工 | ④ 发布 |

**工作流模式**：① 开发（ios-dev）→ ② 构建与测试（`swift build` + QA 测试，门禁：通过才提交 PR）→ ③ 提交与评审（架构师 + Audit Manager 并行，门禁：两轨均通过才合并；否则反馈回开发）→ ④ 发布（Team Lead 合并与收尾）。详细流程图与说明见 [docs/swift-developer-flow.md](docs/swift-developer-flow.md)，完整职责与触发方式见 [docs/agent-teams.md](docs/agent-teams.md)。

## Workflow Rules

- **Checklist 管理**：PR 和 Issue 中的 checklist 项，确认验证完成后必须**立即**在 GitHub 上标记为完成（勾选）。每次 PR 合并或 Issue 关闭时必须同步更新 checklist，不得遗漏。
- **队员间直接通信**：任何队员之间可直接发消息协作，team-lead 不做中转。team-lead 只处理：合并 PR、更新 Issue/checklist、向用户汇报。
- **完整 PR 评审流程**（队员通信链路）：
  1. ios-dev push → 通知 QA 测试
  2. QA 通过 → 通知 ios-dev 创建 PR
  3. ios-dev 创建 PR → 通知 QA「PR #N 已创建」
  4. QA → 通知 architect 开始 PR 审查
  5. architect → 开始自己审查 + 通知 audit-manager 审计
  6. audit-manager 完成 → 反馈结果给 architect
  7. architect 汇总两轨结果：通过 → 通知 team-lead 合并；有问题 → 通知 ios-dev 修复
- **两轨通过即合并**：architect ✅ + audit-manager ✅ 后，team-lead **直接执行** rebase 合并，不再向用户确认。

## Build & Test Commands

```bash
swift build          # Build the package
swift test           # Run all tests (365 tests across 12 files; ~25K parameterized validation cases)
swift test --filter SolarTests/testSolarDay   # Run a single test
swift test --filter ValidationTests           # Run tyme4j 1:1 validation suite only (~25K cases)
swift run -c release TymeBenchmarks           # Run performance benchmarks
```

SwiftLint configured (`.swiftlint.yml`). Run `swiftlint lint Sources` before committing. Dependencies: swift-docc-plugin (documentation), google/swift-benchmark (benchmarks).

## CI/CD

- **PR CI** (`.github/workflows/ci.yml`): Runs `swift build` + `swift test` with code coverage on push to main and pull requests (Swift 6.2, Ubuntu + macOS)
- **Publish** (`.github/workflows/publish.yml`): Release publishing workflow (Swift 6.2)
- **Validate Truth Tables** (`.github/workflows/validate-truth-tables.yml`): Weekly (Mon 02:00 UTC) + manual — checks tyme4j version alignment; creates GitHub Issue if fixtures drift

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

365 tests (Swift Testing) across 12 module-based files in `Tests/tymeTests/`:

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
| `ValidationTests.swift` | 6 | tyme4j 1:1 parameterized validation (~25,943 cases via `@Test(arguments:)`) |

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
