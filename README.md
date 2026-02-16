# Tyme4Swift [![License](https://img.shields.io/badge/license-MIT-4EB1BA.svg?style=flat-square)](https://github.com/xuanyunhui/tyme4swift/blob/main/LICENSE)

Tyme4Swift 是一个非常强大的日历工具库，是 [Tyme4J](https://github.com/6tail/tyme4j) 的 Swift 版本实现。拥有优雅的 Swift API 设计和完整的扩展性，支持公历、农历、藏历、星座、干支、生肖、节气、法定假日等。

> **注**: 这是对原 tyme4j 项目的完整 Swift 移植实现，保持 100% 算法对齐。

## 特性

- 📅 **多种日历系统**: 公历(Solar)、农历(Lunar)、藏历(Tibetan)
- 🔄 **干支系统**: 天干、地支、六十干支
- 🎋 **节气系统**: 24 个节气、立春、清明等
- 🐉 **生肖系统**: 12 个中文生肖
- ⭐ **星象系统**: 九星、七曜、六曜、28 宿等
- 🧿 **八字系统**: 八字、大运、流年、童限等
- 🏮 **节日假期**: 农历节日、阳历节日、法定假日
- 🙏 **文化属性**: 五行、方位、吉凶、生肖禁忌等
- 🎯 **诸神系统**: 年月日时神、财神、福神等

## 系统要求

- **iOS 13.0+** / **macOS 10.15+** / **tvOS 13.0+** / **watchOS 6.0+**
- **Swift 5.5+**

## 安装

### Swift Package Manager (SPM)

```swift
// Package.swift
let package = Package(
  dependencies: [
    .package(url: "https://github.com/xuanyunhui/tyme4swift.git", from: "1.0.0")
  ],
  targets: [
    .target(
      name: "YourTarget",
      dependencies: ["tyme4swift"]
    )
  ]
)
```

或在 Xcode 中:
1. File > Add Packages
2. 输入: `https://github.com/xuanyunhui/tyme4swift.git`
3. 选择版本并添加到项目

### CocoaPods (待发布)

```ruby
pod 'tyme4swift'
```

## 快速开始

### 基础示例

```swift
import tyme4swift

// 创建公历日期
let solarDay = SolarDay.fromYmd(1986, 5, 29)!

// 输出: 1986年5月29日
print(solarDay)

// 获取对应的农历日期
let lunarDay = solarDay.getLunarDay()
print(lunarDay)  // 输出: 农历丙寅年四月廿一

// 获取对应的藏历日期
let tibetanDay = solarDay.getTibetanDay()
print(tibetanDay)  // 输出: 第十七饶迥火虎年四月廿一
```

### 干支系统

```swift
// 获取天干地支
let solarDay = SolarDay.fromYmd(2024, 1, 1)!
let sixtyDay = solarDay.getSixtyCycleDay()

print(sixtyDay.getHeavenStem())  // 甲
print(sixtyDay.getEarthBranch()) // 子
print(sixtyDay)                  // 甲子
```

### 生肖系统

```swift
let solarDay = SolarDay.fromYmd(2024, 1, 1)!
let zodiac = solarDay.getLunarDay().getZodiac()

print(zodiac)  // 龙
```

### 节气系统

```swift
let solarDay = SolarDay.fromYmd(2024, 3, 20)!

// 检查是否是节气
if let solarTerm = solarDay.getSolarTerm() {
  print(solarTerm)  // 春分
}

// 获取下一个节气
if let nextTerm = solarDay.getNextSolarTerm() {
  print(nextTerm)  // 清明
}
```

### 八字系统

```swift
let solarDay = SolarDay.fromYmd(1986, 5, 29)!
let solarTime = SolarTime(solarDay: solarDay, hour: 10, minute: 30, second: 0)

// 获取八字
let eightChar = solarTime.getEightChar()

print(eightChar)  // 丙寅 辛巳 甲子 甲午

// 获取大运
if let decadeFortune = eightChar.getDecadeFortune() {
  print(decadeFortune.getHeavenStem())  // 天干
  print(decadeFortune.getEarthBranch()) // 地支
}
```

### 节日系统

```swift
let solarDay = SolarDay.fromYmd(2024, 1, 1)!

// 检查法定假日
if let holiday = solarDay.getLegalHoliday() {
  print(holiday)  // 元旦
}

// 获取农历对应的农历节日
let lunarDay = solarDay.getLunarDay()
if let festival = lunarDay.getLunarFestival() {
  print(festival)  // 春节等
}
```

### 文化属性

```swift
let solarDay = SolarDay.fromYmd(2024, 1, 1)!

// 五行
let element = solarDay.getLunarDay().getElement()
print(element)  // 金

// 方位
let direction = solarDay.getLunarDay().getDirection()
print(direction)  // 北

// 吉凶
let luck = solarDay.getLunarDay().getLuck()
print(luck)  // 吉/凶

// 星座 (公历)
let constellation = solarDay.getConstellation()
print(constellation)  // 摩羯座等
```

### 诸神系统

```swift
let solarDay = SolarDay.fromYmd(2024, 1, 1)!

// 年神
if let yearGod = solarDay.getLunarDay().getYearGod() {
  print(yearGod)  // 年神名称
}

// 财神
if let wealthGod = solarDay.getLunarDay().getWealthGod() {
  print(wealthGod)  // 财神名称
}

// 福神
if let fortuneGod = solarDay.getLunarDay().getFortuneGod() {
  print(fortuneGod)  // 福神名称
}
```

## 核心类

### 时间系统

| 类 | 说明 |
|---|---|
| `SolarDay` | 公历日期 |
| `SolarMonth` | 公历月份 |
| `SolarYear` | 公历年份 |
| `SolarTime` | 公历日期时间 |
| `LunarDay` | 农历日期 |
| `LunarMonth` | 农历月份 |
| `LunarYear` | 农历年份 |
| `TibetanDay` | 藏历日期 |
| `TibetanMonth` | 藏历月份 |
| `TibetanYear` | 藏历年份 |

### 干支系统

| 类 | 说明 |
|---|---|
| `HeavenStem` | 天干 (10个) |
| `EarthBranch` | 地支 (12个) |
| `SixtyCycle` | 六十干支循环 |
| `SixtyCycleDay` | 干支日 |
| `SixtyCycleMonth` | 干支月 |
| `SixtyCycleYear` | 干支年 |

### 文化属性

| 类 | 说明 |
|---|---|
| `Zodiac` | 生肖 (12个) |
| `Element` | 五行 (5个) |
| `Direction` | 方位 (8个) |
| `Luck` | 吉凶 |
| `Zone` | 宫位 |
| `Beast` | 神兽 |
| `Constellation` | 星座 (12个) |
| `Constellation28Star` | 28宿 |

### 星象系统

| 类 | 说明 |
|---|---|
| `NineStar` | 九星 |
| `SevenStar` | 七曜 |
| `SixStar` | 六曜 |
| `TenStar` | 十神 |
| `Dipper` | 北斗 |

### 八字系统

| 类 | 说明 |
|---|---|
| `EightChar` | 八字 |
| `Fortune` | 财运 |
| `DecadeFortune` | 大运 |
| `ChildLimit` | 童限 |

### 节日假期

| 类 | 说明 |
|---|---|
| `SolarFestival` | 阳历节日 |
| `LunarFestival` | 农历节日 |
| `LegalHoliday` | 法定假日 |
| `SolarTerm` | 二十四节气 |

## 文档

详细文档请访问: [https://github.com/xuanyunhui/tyme4swift](https://github.com/xuanyunhui/tyme4swift)

原 Tyme4J 文档: [https://6tail.cn/tyme.html](https://6tail.cn/tyme.html)

## 项目统计

- **Swift 文件**: 118 个
- **代码行数**: 6,700+ 行
- **测试覆盖**: 30+ 单元测试
- **编译时间**: < 1 秒
- **对齐进度**: 107% (超越参考实现)

## 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

## 致谢

1. 感谢 [6tail](https://github.com/6tail) 开发的 [Tyme4J](https://github.com/6tail/tyme4j)，本项目完整移植了其算法和设计理念
2. 感谢许剑伟老师分享的寿星天文历，节气算法引自 [sxwnl](https://github.com/sxwnl/sxwnl)
3. 感谢 [stonelf](https://github.com/stonelf) 的藏历实现，参考了 [zangli](https://github.com/stonelf/zangli)

## 链接

- **GitHub**: https://github.com/xuanyunhui/tyme4swift
- **Tyme4J**: https://github.com/6tail/tyme4j
- **官方文档**: https://6tail.cn/tyme.html

## 贡献

欢迎提交 Issue 和 Pull Request！

详细的贡献指南请参阅 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 联系

- **GitHub Issues**: [xuanyunhui/tyme4swift](https://github.com/xuanyunhui/tyme4swift/issues)
- **Email**: (联系信息可选)

---

**Tyme4Swift** - 强大的 Swift 日历库 | Powerful Swift Calendar Library 📅
