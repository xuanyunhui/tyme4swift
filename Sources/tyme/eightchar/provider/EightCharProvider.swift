import Foundation

/// 八字计算提供者协议 (EightChar Provider Protocol)
/// Protocol for different EightChar calculation methods
public protocol EightCharProvider {
    /// Get year pillar SixtyCycle
    func getYearSixtyCycle(year: Int, month: Int, day: Int) -> SixtyCycle

    /// Get month pillar SixtyCycle
    func getMonthSixtyCycle(year: Int, month: Int, day: Int) -> SixtyCycle

    /// Get day pillar SixtyCycle
    func getDaySixtyCycle(year: Int, month: Int, day: Int) -> SixtyCycle

    /// Get hour pillar SixtyCycle
    func getHourSixtyCycle(year: Int, month: Int, day: Int, hour: Int) -> SixtyCycle
}
