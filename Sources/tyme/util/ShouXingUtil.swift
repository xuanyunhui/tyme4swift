import Foundation

enum ShouXingUtil {
    static let PI_2 = 2 * Double.pi
    static let ONE_THIRD = 1.0 / 3.0
    static let SECOND_PER_DAY = 86400
    static let SECOND_PER_RAD = 648000 / Double.pi

    // Mean solar term length and synodic month length (days).
    private static let meanSolarTerm = 365.2422 / 24.0
    private static let meanSynodicMonth = 29.5306

    // Reference epochs from tyme4j (absolute Julian day numbers).
    private static let qiEpoch = 2451259.0 // 1999-03-21, solar longitude 0 (spring equinox)
    private static let shuoEpoch = 2451551.0 // 2000-01-07, new moon

    static func calcQi(_ jd: Double) -> Double {
        let jdAbs = jd + JulianDay.J2000
        let n = floor((jdAbs - qiEpoch) / meanSolarTerm)
        return (qiEpoch + n * meanSolarTerm) - JulianDay.J2000
    }

    static func calcShuo(_ jd: Double) -> Double {
        let jdAbs = jd + JulianDay.J2000
        let n = floor((jdAbs - shuoEpoch) / meanSynodicMonth)
        return (shuoEpoch + n * meanSynodicMonth) - JulianDay.J2000
    }

    static func qiAccurate2(_ jd: Double) -> Double {
        calcQi(jd)
    }
}
