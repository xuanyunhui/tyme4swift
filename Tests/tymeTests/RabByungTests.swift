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

    // MARK: - RabByungMonth：next() 正常导航

    @Test func testRabByungMonthNext() throws {
        let m = try RabByungMonth.fromYm(2024, 1)
        #expect(m.next(1).getName() == "二月")
        #expect(m.next(1).year == 2024)
        #expect(m.next(12).year == 2025)
        #expect(m.next(0).getName() == "正月")
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
        let d7 = try SolarDay.fromYmd(2025, 4, 26)
        let rbd7 = try #require(d7.rabByungDay)
        #expect(rbd7.rabByungMonth.getName() + rbd7.getName() == "二月廿九")

        let d8 = try SolarDay.fromYmd(2025, 4, 25)
        let rbd8 = try #require(d8.rabByungDay)
        #expect(rbd8.rabByungMonth.getName() + rbd8.getName() == "二月廿七")
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
    }
}
