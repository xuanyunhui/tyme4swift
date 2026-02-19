import Testing
@testable import tyme

/// 藏历年测试，对齐 tyme4j RabByungYearTest
@Suite struct RabByungTests {

    // MARK: - fromElementZodiac（对齐 tyme4j test0）

    @Test func testFromElementZodiac() throws {
        let y = try RabByungYear.fromElementZodiac(0, RabByungElement(index: 1), Zodiac.fromName("兔"))
        #expect(y.getName() == "第一饶迥火兔年")
        #expect(y.solarYear?.getName() == "1027年")
        #expect(y.sixtyCycle.getName() == "丁卯")
        #expect(y.leapMonth == 10)
    }

    // MARK: - fromYear epoch 锚点（对齐 tyme4j test1）

    @Test func testEpoch1027() throws {
        let y = try RabByungYear.fromYear(1027)
        #expect(y.getName() == "第一饶迥火兔年")
        #expect(y.rabByungIndex == 0)
        #expect(y.year == 1027)
    }

    // MARK: - fromYear 现代年（对齐 tyme4j test2）

    @Test func testFromYear2010() throws {
        let y = try RabByungYear.fromYear(2010)
        #expect(y.getName() == "第十七饶迥铁虎年")
    }

    // MARK: - leapMonth（对齐 tyme4j test3）

    @Test func testLeapMonth() throws {
        #expect(try RabByungYear.fromYear(2043).leapMonth == 5)
        #expect(try RabByungYear.fromYear(2044).leapMonth == 0)
    }

    // MARK: - fromYear 1961（对齐 tyme4j test4）

    @Test func testFromYear1961() throws {
        let y = try RabByungYear.fromYear(1961)
        #expect(y.getName() == "第十六饶迥铁牛年")
    }

    // MARK: - fromSixtyCycle 工厂方法

    @Test func testFromSixtyCycle() throws {
        // 丁卯 = index 3，饶迥序号 0 → 1027年
        let sc = SixtyCycle.fromIndex(3)
        let y = try RabByungYear.fromSixtyCycle(0, sc)
        #expect(y.getName() == "第一饶迥火兔年")
        #expect(y.year == 1027)
        #expect(y.sixtyCycle.getName() == "丁卯")
    }

    // MARK: - monthCount

    @Test func testMonthCount() throws {
        // 1027 年闰月=10，monthCount=13
        let y1027 = try RabByungYear.fromYear(1027)
        #expect(y1027.monthCount == 13)
        // 2044 年无闰月，monthCount=12
        let y2044 = try RabByungYear.fromYear(2044)
        #expect(y2044.monthCount == 12)
    }

    // MARK: - next() 导航

    @Test func testNext() throws {
        let y = try RabByungYear.fromYear(1027)
        #expect(y.next(1).year == 1028)
        #expect(y.next(-1).year == 1026)
        #expect(y.next(60).getName() == "第二饶迥火兔年")
    }

    // MARK: - 边界验证：超出范围抛出错误

    @Test func testInvalidIndex() {
        #expect(throws: TymeError.self) {
            _ = try RabByungYear(rabByungIndex: -1, sixtyCycle: SixtyCycle.fromIndex(0))
        }
        #expect(throws: TymeError.self) {
            _ = try RabByungYear(rabByungIndex: 151, sixtyCycle: SixtyCycle.fromIndex(0))
        }
    }

    // MARK: - RabByungMonth：tyme4j test0 对齐

    @Test func testRabByungMonthFromYm() throws {
        let m = try RabByungMonth.fromYm(1950, 12)
        // tyme4j test0: RabByungMonth.fromYm(1950,12).toString() == "第十六饶迥铁虎年十二月"
        #expect(m.getName() == "十二月")
        #expect(m.alias == "满意月")
        #expect(m.year == 1950)
        #expect(m.month == 12)
        #expect(m.isLeap == false)
        #expect(m.rabByungYear.getName() == "第十六饶迥铁虎年")
        #expect(m.rabByungYear.getName() + m.getName() == "第十六饶迥铁虎年十二月")
    }

    // MARK: - RabByungMonth：闰月构建路径

    @Test func testRabByungMonthLeap() throws {
        // 2043年闰月=5（已由 testLeapMonth 断言）；-5 表示闰五月
        let m = try RabByungMonth.fromYm(2043, -5)
        #expect(m.isLeap == true)
        #expect(m.month == 5)
        #expect(m.year == 2043)
        #expect(m.getName() == "闰五月")
        #expect(m.alias == "闰作净月")
        #expect(m.monthWithLeap == -5)
        // 非闰月年尝试构造闰月应抛出错误（2044年leapMonth==0）
        #expect(throws: TymeError.self) { _ = try RabByungMonth.fromYm(2044, -1) }
    }

    // MARK: - RabByungMonth：DAYS 数据表验证

    @Test func testRabByungMonthDays() throws {
        // 1950/12 是 DAYS 表第一个条目（y=1950, m=11）：编码 "2c>" → data=[16, -21]
        // leapDays=[16]（第16日为闰日），missDays=[21]（第21日缺失），dayCount=30
        let m = try RabByungMonth.fromYm(1950, 12)
        #expect(m.specialDays == [16, -21])
        #expect(m.leapDays == [16])
        #expect(m.missDays == [21])
        #expect(m.dayCount == 30)
    }

    // MARK: - RabByungMonth：验证错误

    @Test func testRabByungMonthValidation() {
        // month 0 无效
        #expect(throws: TymeError.self) { _ = try RabByungMonth.fromYm(2000, 0) }
        // month > 12 无效
        #expect(throws: TymeError.self) { _ = try RabByungMonth.fromYm(2000, 13) }
        // 年份超出 1950-2050 范围
        #expect(throws: TymeError.self) { _ = try RabByungMonth.fromYm(1949, 1) }
        #expect(throws: TymeError.self) { _ = try RabByungMonth.fromYm(2051, 1) }
        // 1950 年只允许第12月
        #expect(throws: TymeError.self) { _ = try RabByungMonth.fromYm(1950, 1) }
    }

    // MARK: - RabByungMonth：next() 边界（不崩溃、不死循环）

    @Test func testRabByungMonthNextBoundary() throws {
        // 向后超出上界（2050/12 之后），应返回 self
        let last = try RabByungMonth.fromYm(2050, 12)
        let beyond = last.next(100)
        #expect(beyond.year == last.year)
        #expect(beyond.month == last.month)
        #expect(beyond.isLeap == last.isLeap)

        // 向前超出下界（1950/12 之前），应返回 self
        let first = try RabByungMonth.fromYm(1950, 12)
        let before = first.next(-100)
        #expect(before.year == first.year)
        #expect(before.month == first.month)
        #expect(before.isLeap == first.isLeap)
    }

    // MARK: - RabByungMonth：next() 补充边界测试（Issue #124）

    @Test func testRabByungMonthNext1950Boundary() throws {
        // 1950/12 是最早有效月，next(-1) 应返回 self，next(1) 应是 1951/正月
        let m1950_12 = try RabByungMonth.fromYm(1950, 12)

        // next(-1) 返回 self
        let before = m1950_12.next(-1)
        #expect(before.year == m1950_12.year)
        #expect(before.month == m1950_12.month)
        #expect(before.isLeap == m1950_12.isLeap)

        // next(1) 应是 1951/正月
        let after = m1950_12.next(1)
        #expect(after.year == 1951)
        #expect(after.month == 1)
        #expect(after.isLeap == false)
        #expect(after.getName() == "正月")
    }

    @Test func testRabByungMonthNextZeroIdentity() throws {
        // next(0) 对普通月和闰月都应返回等值月（year/month/isLeap 不变）
        let normalMonth = try RabByungMonth.fromYm(2024, 6)
        let normalZero = normalMonth.next(0)
        #expect(normalZero.year == normalMonth.year)
        #expect(normalZero.month == normalMonth.month)
        #expect(normalZero.isLeap == normalMonth.isLeap)
        #expect(normalZero.getName() == normalMonth.getName())

        let leapMonth = try RabByungMonth.fromYm(2024, -6)
        let leapZero = leapMonth.next(0)
        #expect(leapZero.year == leapMonth.year)
        #expect(leapZero.month == leapMonth.month)
        #expect(leapZero.isLeap == leapMonth.isLeap)
        #expect(leapZero.getName() == leapMonth.getName())
    }

    @Test func testRabByungMonthLeapConsistency() throws {
        // 导航到闰月后，isLeap==true，monthWithLeap 为负数
        let m = try RabByungMonth.fromYm(2024, 1)

        // 导航到闰六月（正月 + 6步）
        let leapMonth = m.next(6)
        #expect(leapMonth.isLeap == true)
        #expect(leapMonth.month == 6)
        #expect(leapMonth.monthWithLeap == -6)
        #expect(leapMonth.getName() == "闰六月")

        // 普通月的 monthWithLeap 为正数
        let normalMonth = try RabByungMonth.fromYm(2024, 6)
        #expect(normalMonth.isLeap == false)
        #expect(normalMonth.month == 6)
        #expect(normalMonth.monthWithLeap == 6)
        #expect(normalMonth.getName() == "六月")
    }

    // MARK: - RabByungMonth：next() 正常导航

    @Test func testRabByungMonthNext() throws {
        let m = try RabByungMonth.fromYm(2024, 1)
        #expect(m.next(1).getName() == "二月")
        #expect(m.next(1).year == 2024)
        #expect(m.next(12).year == 2024)        // 有闰月年：12步不跨年
        #expect(m.next(12).getName() == "十二月")
        #expect(m.next(13).year == 2025)        // 13步才跨年
        #expect(m.next(13).getName() == "正月")  // 跨年后的第13步是2025年正月
        #expect(m.next(0).getName() == "正月")
    }

    // MARK: - RabByungMonth：闰月年导航完整覆盖（Issue #118）

    @Test func testRabByungMonthLeapYearNavigation() throws {
        // 2024年有闰月：leapMonth=6（闰六月）
        let leapYearMonth6 = try RabByungMonth.fromYm(2024, 6)
        let leapMonth = try RabByungMonth.fromYm(2024, -6)  // 闰六月

        // 从正月导航到闰月：正月 + 6步 = 闰六月
        let m1 = try RabByungMonth.fromYm(2024, 1)
        let afterSixSteps = m1.next(6)
        #expect(afterSixSteps.month == 6)
        #expect(afterSixSteps.isLeap == true)
        #expect(afterSixSteps.getName() == "闰六月")

        // 从闰月出发：next(1) = 七月
        let leapM6 = try RabByungMonth.fromYm(2024, -6)
        let nextMonth = leapM6.next(1)
        #expect(nextMonth.month == 7)
        #expect(nextMonth.isLeap == false)
        #expect(nextMonth.getName() == "七月")

        // 从闰月出发：next(-1) = 六月（正月）
        let prevMonth = leapM6.next(-1)
        #expect(prevMonth.month == 6)
        #expect(prevMonth.isLeap == false)
        #expect(prevMonth.getName() == "六月")

        // 反向穿越：从2025年正月反向13步回到2024年正月
        let m2025_1 = try RabByungMonth.fromYm(2025, 1)
        let back13Steps = m2025_1.next(-13)
        #expect(back13Steps.year == 2024)
        #expect(back13Steps.month == 1)
        #expect(back13Steps.isLeap == false)
        #expect(back13Steps.getName() == "正月")
    }

    // MARK: - solarYear Optional（不在 SolarYear 范围内返回 nil）

    @Test func testSolarYearOptional() throws {
        // 正常年份：有 solarYear
        let y = try RabByungYear.fromYear(2024)
        #expect(y.solarYear?.getName() == "2024年")

        // rabByungIndex=150 时 year=10083，超出 SolarYear 范围（1-9999）
        let boundary = try RabByungYear.fromSixtyCycle(150, SixtyCycle.fromIndex(59))
        #expect(boundary.year > 9999)
        #expect(boundary.solarYear == nil)
    }

    // MARK: - RabByungDay：tyme4j test0（纪元首日）

    @Test func testRabByungDayTest0() throws {
        // 公历→藏历
        let d0 = try SolarDay.fromYmd(1951, 1, 8)
        let rbd0 = try #require(d0.rabByungDay)
        #expect(rbd0.rabByungMonth.rabByungYear.getName() + rbd0.rabByungMonth.getName() + rbd0.getName() == "第十六饶迥铁虎年十二月初一")

        // 藏历→公历
        let rbd1 = try RabByungDay.fromElementZodiac(15, RabByungElement(index: 3), Zodiac.fromName("虎"), 12, 1)
        #expect(rbd1.solarDay.getName() == "1951-01-08")
    }

    // MARK: - RabByungDay：tyme4j test1（纪元末日）

    @Test func testRabByungDayTest1() throws {
        // 公历→藏历
        let d = try SolarDay.fromYmd(2051, 2, 11)
        let rbd = try #require(d.rabByungDay)
        #expect(rbd.rabByungMonth.rabByungYear.getName() + rbd.rabByungMonth.getName() + rbd.getName() == "第十八饶迥铁马年十二月三十")

        // 藏历→公历
        let rbd2 = try RabByungDay.fromElementZodiac(17, RabByungElement(index: 3), Zodiac.fromName("马"), 12, 30)
        #expect(rbd2.solarDay.getName() == "2051-02-11")
    }

    // MARK: - RabByungDay：tyme4j test2（现代日期）

    @Test func testRabByungDayTest2() throws {
        let d = try SolarDay.fromYmd(2025, 4, 23)
        let rbd = try #require(d.rabByungDay)
        #expect(rbd.rabByungMonth.rabByungYear.getName() + rbd.rabByungMonth.getName() + rbd.getName() == "第十七饶迥木蛇年二月廿五")

        let rbd2 = try RabByungDay.fromElementZodiac(16, RabByungElement(name: "木"), Zodiac.fromName("蛇"), 2, 25)
        #expect(rbd2.solarDay.getName() == "2025-04-23")
    }

    // MARK: - RabByungDay：tyme4j test3（正常日期）

    @Test func testRabByungDayTest3() throws {
        let d = try SolarDay.fromYmd(1951, 2, 8)
        let rbd = try #require(d.rabByungDay)
        #expect(rbd.rabByungMonth.rabByungYear.getName() + rbd.rabByungMonth.getName() + rbd.getName() == "第十六饶迥铁兔年正月初二")

        let rbd2 = try RabByungDay.fromElementZodiac(15, RabByungElement(index: 3), Zodiac.fromName("兔"), 1, 2)
        #expect(rbd2.solarDay.getName() == "1951-02-08")
    }

    // MARK: - RabByungDay：tyme4j test4（闰日）

    @Test func testRabByungDayTest4() throws {
        // 1951-01-24 = 藏历1950年十二月闰十六
        let d = try SolarDay.fromYmd(1951, 1, 24)
        let rbd = try #require(d.rabByungDay)
        #expect(rbd.rabByungMonth.rabByungYear.getName() + rbd.rabByungMonth.getName() + rbd.getName() == "第十六饶迥铁虎年十二月闰十六")
        #expect(rbd.isLeap == true)
        #expect(rbd.day == 16)

        let rbd2 = try RabByungDay.fromElementZodiac(15, RabByungElement(index: 3), Zodiac.fromName("虎"), 12, -16)
        #expect(rbd2.solarDay.getName() == "1951-01-24")
    }

    // MARK: - RabByungDay：tyme4j test5（缺日跳过）

    @Test func testRabByungDayTest5() throws {
        let d = try SolarDay.fromYmd(1961, 6, 24)
        let rbd = try #require(d.rabByungDay)
        #expect(rbd.rabByungMonth.rabByungYear.getName() + rbd.rabByungMonth.getName() + rbd.getName() == "第十六饶迥铁牛年五月十一")

        let rbd2 = try RabByungDay.fromElementZodiac(15, RabByungElement(index: 3), Zodiac.fromName("牛"), 5, 11)
        #expect(rbd2.solarDay.getName() == "1961-06-24")
    }

    // MARK: - RabByungDay：tyme4j test6

    @Test func testRabByungDayTest6() throws {
        let d = try SolarDay.fromYmd(1952, 2, 23)
        let rbd = try #require(d.rabByungDay)
        #expect(rbd.rabByungMonth.rabByungYear.getName() + rbd.rabByungMonth.getName() + rbd.getName() == "第十六饶迥铁兔年十二月廿八")

        let rbd2 = try RabByungDay.fromElementZodiac(15, RabByungElement(index: 3), Zodiac.fromName("兔"), 12, 28)
        #expect(rbd2.solarDay.getName() == "1952-02-23")
    }

    // MARK: - RabByungDay：tyme4j test7 & test8（连续特殊日）

    @Test func testRabByungDayTest7and8() throws {
        // test7：2025-04-26 = 藏历木蛇年二月廿九
        let d7 = try SolarDay.fromYmd(2025, 4, 26)
        let rbd7 = try #require(d7.rabByungDay)
        #expect(rbd7.rabByungMonth.rabByungYear.getName() + rbd7.rabByungMonth.getName() + rbd7.getName() == "第十七饶迥木蛇年二月廿九")

        // test8：2025-04-25 = 藏历木蛇年二月廿七（廿八为缺日）
        let d8 = try SolarDay.fromYmd(2025, 4, 25)
        let rbd8 = try #require(d8.rabByungDay)
        #expect(rbd8.rabByungMonth.rabByungYear.getName() + rbd8.rabByungMonth.getName() + rbd8.getName() == "第十七饶迥木蛇年二月廿七")
    }

    // MARK: - RabByungDay：subtract & next

    @Test func testRabByungDaySubtractAndNext() throws {
        let d1 = try RabByungDay.fromYmd(2025, 2, 25)
        let d2 = try RabByungDay.fromYmd(2025, 2, 20)
        #expect(d1.subtract(d2) == 5)
        #expect(d2.subtract(d1) == -5)

        let next = d2.next(5)
        #expect(next.day == d1.day)
        #expect(next.rabByungMonth.year == d1.rabByungMonth.year)
    }

    // MARK: - RabByungDay：边界：超出范围返回 self

    @Test func testRabByungDayNextBoundary() throws {
        let last = try RabByungDay.fromYmd(2050, 12, 30)
        let beyond = last.next(100)
        #expect(beyond.year == last.year)
        #expect(beyond.month == last.month)
        #expect(beyond.day == last.day)

        let first = try RabByungDay.fromYmd(1950, 12, 1)
        let before = first.next(-100)
        #expect(before.year == first.year)
        #expect(before.month == first.month)
        #expect(before.day == first.day)
    }

    // MARK: - SolarDay.rabByungDay：范围外返回 nil

    @Test func testSolarDayRabByungDayOptional() throws {
        // 1951-01-07 在纪元日之前，应返回 nil
        let d = try SolarDay.fromYmd(1951, 1, 7)
        #expect(d.rabByungDay == nil)

        // 1951-01-08 是纪元首日（藏历1950年十二月初一）
        let d2 = try SolarDay.fromYmd(1951, 1, 8)
        #expect(d2.rabByungDay?.day == 1)
        #expect(d2.rabByungDay?.month == 12)
        #expect(d2.rabByungDay?.isLeap == false)

        // 2051-02-12 超出上界（最后一天是 2051-02-11），应返回 nil
        let d3 = try SolarDay.fromYmd(2051, 2, 12)
        #expect(d3.rabByungDay == nil)
    }

    // MARK: - RabByungDay：init 错误路径（Issue #108）

    @Test func testRabByungDayValidation() throws {
        let m = try RabByungMonth.fromYm(1950, 12)
        // 1950/12: leapDays=[16], missDays=[21]

        // day=0 无效
        #expect(throws: TymeError.self) { _ = try RabByungDay(m, 0) }

        // day=31 超出范围（1-30）
        #expect(throws: TymeError.self) { _ = try RabByungDay(m, 31) }

        // day=-31 超出范围
        #expect(throws: TymeError.self) { _ = try RabByungDay(m, -31) }

        // 缺日：1950/12 第21日为缺日（missDays=[21]），正日 21 不可构建
        #expect(throws: TymeError.self) { _ = try RabByungDay(m, 21) }

        // 非闰日传负值（isLeap=true）：1950/12 leapDays=[16]，-17 不在闰日集合中
        #expect(throws: TymeError.self) { _ = try RabByungDay(m, -17) }

        // 正常日：第16日（正日）和闰十六日均有效
        #expect(throws: Never.self) { _ = try RabByungDay(m, 16) }
        #expect(throws: Never.self) { _ = try RabByungDay(m, -16) }
    }

    // MARK: - RabByungDay：next(0) 返回 self（Issue #108）

    @Test func testRabByungDayNextZero() throws {
        let d = try RabByungDay.fromYmd(2025, 2, 25)
        let d0 = d.next(0)
        // next(0) 直接返回 self
        #expect(d0 === d)
        #expect(d0.year == d.year)
        #expect(d0.month == d.month)
        #expect(d0.day == d.day)
        #expect(d0.isLeap == d.isLeap)
    }

    // MARK: - RabByungDay：dayWithLeap 符号约定（Issue #108）

    @Test func testRabByungDayDayWithLeap() throws {
        // 普通日：dayWithLeap 为正数
        let normal = try RabByungDay.fromYmd(1950, 12, 1)
        #expect(normal.dayWithLeap == 1)
        #expect(normal.isLeap == false)

        // 闰日：dayWithLeap 为负数（-16 表示闰十六）
        let m = try RabByungMonth.fromYm(1950, 12)
        let leap = try RabByungDay(m, -16)
        #expect(leap.dayWithLeap == -16)
        #expect(leap.isLeap == true)
        #expect(leap.day == 16)
    }
}
