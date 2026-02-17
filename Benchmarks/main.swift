import Benchmark
import tyme

// MARK: - 天文算法（通过公共 API 间接测试）
// ShouXingUtil methods are internal; tested indirectly via SolarTerm/SolarDay public APIs.

// SolarTerm.julianDay triggers ShouXingUtil.qiAccurate2 internally
benchmark("SolarTerm.julianDay (via qiAccurate2)") {
    let term = try! SolarTerm(year: 2024, index: 6)  // 春分
    let _ = term.julianDay
}

// SolarTerm.solarDay triggers ShouXingUtil.calcQi internally
benchmark("SolarTerm.solarDay (via calcQi)") {
    let term = try! SolarTerm(year: 2024, index: 0)  // 冬至
    let _ = term.solarDay
}

// SolarTerm init triggers ShouXingUtil.calcShuo / calcQi internally
benchmark("SolarTerm.init") {
    let _ = try! SolarTerm(year: 2024, index: 12)  // 夏至
}

// MARK: - 公历农历转换

benchmark("SolarDay.lunarDay") {
    let day = try! SolarDay.fromYmd(2024, 6, 15)
    let _ = day.lunarDay
}

benchmark("LunarDay.fromYmd") {
    let _ = try! LunarDay.fromYmd(2024, 5, 10)
}

benchmark("LunarDay.solarDay") {
    let day = try! LunarDay.fromYmd(2024, 1, 1)
    let _ = day.solarDay
}

// MARK: - 八字计算

benchmark("EightChar.init") {
    let provider = DefaultEightCharProvider()
    let y = provider.getYearSixtyCycle(year: 1990, month: 6, day: 15)
    let m = provider.getMonthSixtyCycle(year: 1990, month: 6, day: 15)
    let d = provider.getDaySixtyCycle(year: 1990, month: 6, day: 15)
    let h = provider.getHourSixtyCycle(year: 1990, month: 6, day: 15, hour: 12)
    let _ = EightChar(year: y, month: m, day: d, hour: h)
}

// MARK: - 干支循环

benchmark("SixtyCycle.fromIndex") {
    let _ = SixtyCycle.fromIndex(30)
}

benchmark("HeavenStem.fromIndex") {
    let _ = HeavenStem.fromIndex(5)
}

benchmark("EarthBranch.fromIndex") {
    let _ = EarthBranch.fromIndex(6)
}

Benchmark.main()
