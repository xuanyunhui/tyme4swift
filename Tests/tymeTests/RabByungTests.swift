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

    // MARK: - solarYear Optional（不在 SolarYear 范围内返回 nil）

    @Test func testSolarYearOptional() throws {
        // 正常年份：有 solarYear
        let y = try RabByungYear.fromYear(2024)
        #expect(y.solarYear != nil)
        #expect(y.solarYear?.getName() == "2024年")

        // rabByungIndex=150 时 year=10083，超出 SolarYear 范围（1-9999）
        let boundary = try RabByungYear.fromSixtyCycle(150, SixtyCycle.fromIndex(59))
        #expect(boundary.year > 9999)
        #expect(boundary.solarYear == nil)
    }
}
