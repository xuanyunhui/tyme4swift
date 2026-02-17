# 贡献指南

感谢你对 tyme4swift 的关注！我们欢迎各种形式的贡献。

## 提交前准备

### SwiftLint 检查

项目使用 [SwiftLint](https://github.com/realm/SwiftLint) 保持代码风格一致。提交前请运行：

```bash
swiftlint lint Sources
```

### 运行测试

提交前请确保所有测试通过：

```bash
swift build          # 构建
swift test           # 运行全部测试
swift test --filter SolarTests/testSolarDay   # 运行单个测试
```

## 提交 Pull Request

1. Fork 本仓库
2. 创建你的特性分支（`git checkout -b feature/amazing-feature`）
3. 提交你的更改（`git commit -m 'Add some amazing feature'`）
4. 推送到分支（`git push origin feature/amazing-feature`）
5. 开启一个 Pull Request

## Pull Request 规范

- **标题**：简洁描述改动内容
- **描述**：详细说明改动原因和实现方式
- **测试**：包含必要的测试用例
- **对齐**：如果涉及算法改动，确保与 [tyme4j](https://github.com/6tail/tyme4j) 保持一致

## 分支策略

- **main**：主分支，保持稳定
- **feature/**：新功能分支
- **fix/**：Bug 修复分支

## PR 合并方式

本仓库只允许 **rebase** 合并方式，不允许 merge commit 和 squash。

## 编码规范

遵循 [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/)，并遵守以下项目约定。

### API 设计

- **computed property 优先**：无副作用的访问用 computed property，不用 `getXxx()` 方法

  ```swift
  // Good
  var element: Element { ... }

  // Bad
  func getElement() -> Element { ... }
  ```

- **Boolean 命名**：读起来像断言

  ```swift
  var isEmpty: Bool        // 名词 → is 前缀
  var auspicious: Bool     // 形容词 → 直接用
  var hasChildren: Bool    // 动词 → has/can/should
  ```

- **工厂方法**：使用 `static func` 或 throwing initializer，禁止 `fatalError` 处理用户输入

  ```swift
  static func fromName(_ name: String) throws -> Self
  ```

- **访问控制**：最小暴露原则
  - `public final` — 不允许外部继承的具体类
  - `open` — 设计为可继承的基类
  - `internal`（默认）— 模块内部实现
  - `private` / `fileprivate` — 文件/类型内部

- **渐进式废弃**：重命名 API 时保留旧入口并标注

  ```swift
  @available(*, deprecated, renamed: "element")
  public func getElement() -> Element { element }
  ```

### 测试（Swift Testing）

使用 [Swift Testing](https://developer.apple.com/documentation/testing/) 框架，不使用 XCTest。

- **`@Suite` + `struct`**：测试套件用值类型

  ```swift
  @Suite("Solar Calendar")
  struct SolarTests {
      @Test("Leap year detection")
      func leapYear() {
          #expect(SolarYear(2024).isLeap)
      }
  }
  ```

- **`#expect` 断言**：统一使用 Swift Testing 宏

  ```swift
  #expect(a == b)                                       // 相等
  #expect(a != nil)                                     // 非空
  #expect(throws: SomeError.self) { try riskyCall() }   // 异常
  ```

- **文件组织**：按模块/功能拆分，一个文件对应一个测试主题

### 文档（DocC）

- **公共 API 必须文档化**：所有 `public` / `open` 符号加 `///` 注释

- **结构**：Summary → Discussion → Parameters → Returns → Throws

  ```swift
  /// Converts this lunar day to its corresponding solar day.
  ///
  /// Uses astronomical algorithms to compute the exact Gregorian date
  /// for the given lunar calendar date.
  ///
  /// - Returns: The equivalent `SolarDay`.
  /// - Throws: `TymeError.invalidDay` if the date is out of range.
  func toSolarDay() throws -> SolarDay
  ```

- **多语言术语**：领域专有名词保留原文并附拼音和英文解释

  ```swift
  /// A Heavenly Stem (天干, Tiangan) in the sexagenary cycle.
  ```

- **优先级**：核心公共 API 先写，内部实现按需补充

### Codable

- **最小数据原则**：只编码重建所需的最少字段

  ```swift
  func encode(to encoder: Encoder) throws {
      var c = encoder.container(keyedBy: CodingKeys.self)
      try c.encode(year, forKey: .year)
      try c.encode(month, forKey: .month)
      try c.encode(day, forKey: .day)
  }
  ```

- **class 继承链手写**：`Codable` 自动合成仅适用于叶子 struct/class；涉及继承时手写 `init(from:)` / `encode(to:)`

- **枚举/循环类型用 index**：可枚举类型编码索引值，解码时通过工厂方法重建

- **按需覆盖**：不追求全量 Codable，只为需要序列化的核心类型实现

### 算法对齐

- 保持与 [tyme4j](https://github.com/6tail/tyme4j) 的算法一致性
- 涉及算法改动时，对照 Java 源码确认行为一致

## 联系方式

有任何问题或建议，欢迎：
- 提交 [GitHub Issue](https://github.com/xuanyunhui/tyme4swift/issues)
- 在 Pull Request 中讨论

再次感谢你的贡献！🎉
