import Testing
@testable import tyme

@Suite("Phase6FestivalTests")
struct Phase6FestivalTests {

    // MARK: - LunarFestival Tests

    @Test func testLunarFestivalNames() {
        #expect(LunarFestival.NAMES.count == 13)
        #expect(LunarFestival.NAMES[0] == "春节")
        #expect(LunarFestival.NAMES[1] == "元宵节")
        #expect(LunarFestival.NAMES[2] == "龙头节")
        #expect(LunarFestival.NAMES[3] == "上巳节")
        #expect(LunarFestival.NAMES[4] == "清明节")
        #expect(LunarFestival.NAMES[5] == "端午节")
        #expect(LunarFestival.NAMES[6] == "七夕节")
        #expect(LunarFestival.NAMES[7] == "中元节")
        #expect(LunarFestival.NAMES[8] == "中秋节")
        #expect(LunarFestival.NAMES[9] == "重阳节")
        #expect(LunarFestival.NAMES[10] == "冬至节")
        #expect(LunarFestival.NAMES[11] == "腊八节")
        #expect(LunarFestival.NAMES[12] == "除夕")
    }

    @Test func testLunarFestivalFromIndex_SpringFestival() {
        // 春节 is lunar 1/1 (DAY type)
        let festival = LunarFestival.fromIndex(2024, 0)
        #expect(festival != nil)
        #expect(festival?.festivalName == "春节")
        #expect(festival?.type == .day)
        #expect(festival?.index == 0)
        #expect(festival?.lunarDay.month == 1)
        #expect(festival?.lunarDay.day == 1)
    }

    @Test func testLunarFestivalFromIndex_DragonBoat() {
        // 端午节 is lunar 5/5 (DAY type)
        let festival = LunarFestival.fromIndex(2024, 5)
        #expect(festival != nil)
        #expect(festival?.festivalName == "端午节")
        #expect(festival?.type == .day)
        #expect(festival?.lunarDay.month == 5)
        #expect(festival?.lunarDay.day == 5)
    }

    @Test func testLunarFestivalFromIndex_WinterSolstice() {
        // 冬至节 is TERM type (index 10, solar term index 0 = 冬至)
        let festival = LunarFestival.fromIndex(2024, 10)
        #expect(festival != nil)
        #expect(festival?.festivalName == "冬至节")
        #expect(festival?.type == .term)
        #expect(festival?.solarTerm != nil)
        #expect(festival?.solarTerm?.name == "冬至")
    }

    @Test func testLunarFestivalFromIndex_Eve() {
        // 除夕 is EVE type (index 12)
        let festival = LunarFestival.fromIndex(2023, 12)
        #expect(festival != nil)
        #expect(festival?.festivalName == "除夕")
        #expect(festival?.type == .eve)
    }

    @Test func testLunarFestivalFromIndex_OutOfRange() {
        #expect(LunarFestival.fromIndex(2024, -1) == nil)
        #expect(LunarFestival.fromIndex(2024, 13) == nil)
    }

    @Test func testLunarFestivalFromYmd_SpringFestival() {
        // 春节 is lunar 1/1
        let festival = LunarFestival.fromYmd(2024, 1, 1)
        #expect(festival != nil)
        #expect(festival?.festivalName == "春节")
        #expect(festival?.type == .day)
    }

    @Test func testLunarFestivalFromYmd_MidAutumn() {
        // 中秋节 is lunar 8/15
        let festival = LunarFestival.fromYmd(2024, 8, 15)
        #expect(festival != nil)
        #expect(festival?.festivalName == "中秋节")
        #expect(festival?.type == .day)
    }

    @Test func testLunarFestivalFromYmd_NotAFestival() {
        // Lunar 3/1 is not a festival
        let festival = LunarFestival.fromYmd(2024, 3, 1)
        #expect(festival == nil)
    }

    @Test func testLunarFestivalSolarDay() {
        // 春节 2024: lunar 2024/1/1 → verify it returns a valid solar day
        let festival = LunarFestival.fromIndex(2024, 0)
        #expect(festival != nil)
        let solar = festival?.solarDay
        #expect(solar != nil)
        // Spring festival 2024 is Feb 10, 2024
        #expect(solar?.year == 2024)
        #expect(solar?.month == 2)
        #expect(solar?.day == 10)
    }

    @Test func testLunarFestivalNext() {
        // Spring festival index 0, next(1) should give 元宵节 same year
        let spring = LunarFestival.fromIndex(2024, 0)
        #expect(spring != nil)
        let next = spring?.next(1)
        #expect(next?.festivalName == "元宵节")
    }

    @Test func testLunarFestivalDescription() {
        let festival = LunarFestival.fromIndex(2024, 0)
        #expect(festival != nil)
        let desc = festival?.description ?? ""
        #expect(desc.contains("春节"))
    }

    @Test func testLunarFestivalFromYmd_Term_Qingming() {
        // 清明节 is TERM type (solar term index 7 = 清明)
        let qingming = SolarTerm.fromIndex(2024, 7)
        let solarDay = qingming.solarDay
        let lunarDay = try! solarDay.lunarDay
        let festival = LunarFestival.fromYmd(lunarDay.year, lunarDay.month, lunarDay.day)
        #expect(festival != nil)
        #expect(festival?.festivalName == "清明节")
        #expect(festival?.type == .term)
    }

    @Test func testLunarFestivalFromYmd_Eve() {
        // 除夕 is the last day of lunar year — lunar 2023/12/30 (if 30 days) or 12/29
        let nextNewYear = try! LunarDay.fromYmd(2024, 1, 1)
        let eveDay = nextNewYear.next(-1)
        let festival = LunarFestival.fromYmd(eveDay.year, eveDay.month, eveDay.day)
        #expect(festival != nil)
        #expect(festival?.festivalName == "除夕")
        #expect(festival?.type == .eve)
    }

    // MARK: - SolarFestival Tests

    @Test func testSolarFestivalNames() {
        #expect(SolarFestival.NAMES.count == 10)
        #expect(SolarFestival.NAMES[0] == "元旦")
        #expect(SolarFestival.NAMES[1] == "三八妇女节")
        #expect(SolarFestival.NAMES[2] == "植树节")
        #expect(SolarFestival.NAMES[3] == "五一劳动节")
        #expect(SolarFestival.NAMES[4] == "五四青年节")
        #expect(SolarFestival.NAMES[5] == "六一儿童节")
        #expect(SolarFestival.NAMES[6] == "建党节")
        #expect(SolarFestival.NAMES[7] == "八一建军节")
        #expect(SolarFestival.NAMES[8] == "教师节")
        #expect(SolarFestival.NAMES[9] == "国庆节")
    }

    @Test func testSolarFestivalFromIndex_NewYear() {
        // 元旦: Jan 1, since 1950
        let festival = SolarFestival.fromIndex(2024, 0)
        #expect(festival != nil)
        #expect(festival?.festivalName == "元旦")
        #expect(festival?.solarDay.month == 1)
        #expect(festival?.solarDay.day == 1)
        #expect(festival?.startYear == 1950)
    }

    @Test func testSolarFestivalFromIndex_NationalDay() {
        // 国庆节: Oct 1, since 1950
        let festival = SolarFestival.fromIndex(2024, 9)
        #expect(festival != nil)
        #expect(festival?.festivalName == "国庆节")
        #expect(festival?.solarDay.month == 10)
        #expect(festival?.solarDay.day == 1)
    }

    @Test func testSolarFestivalFromIndex_TeachersDay() {
        // 教师节: Sep 10, since 1985
        let festival = SolarFestival.fromIndex(2024, 8)
        #expect(festival != nil)
        #expect(festival?.festivalName == "教师节")
        #expect(festival?.solarDay.month == 9)
        #expect(festival?.solarDay.day == 10)
        #expect(festival?.startYear == 1985)
    }

    @Test func testSolarFestivalFromIndex_BeforeStartYear() {
        // 教师节 started in 1985, so 1984 should return nil
        let festival = SolarFestival.fromIndex(1984, 8)
        #expect(festival == nil)
    }

    @Test func testSolarFestivalFromIndex_OutOfRange() {
        #expect(SolarFestival.fromIndex(2024, -1) == nil)
        #expect(SolarFestival.fromIndex(2024, 10) == nil)
    }

    @Test func testSolarFestivalFromYmd_NewYear() {
        let festival = SolarFestival.fromYmd(2024, 1, 1)
        #expect(festival != nil)
        #expect(festival?.festivalName == "元旦")
    }

    @Test func testSolarFestivalFromYmd_LaborDay() {
        let festival = SolarFestival.fromYmd(2024, 5, 1)
        #expect(festival != nil)
        #expect(festival?.festivalName == "五一劳动节")
    }

    @Test func testSolarFestivalFromYmd_NotAFestival() {
        // Feb 14 is not in the official list
        let festival = SolarFestival.fromYmd(2024, 2, 14)
        #expect(festival == nil)
    }

    @Test func testSolarFestivalNext() {
        // 元旦 (index 0) → next(1) → 三八妇女节 (index 1)
        let newYear = SolarFestival.fromIndex(2024, 0)
        #expect(newYear != nil)
        let next = newYear?.next(1)
        #expect(next?.festivalName == "三八妇女节")
        #expect(next?.solarDay.year == 2024)
    }

    @Test func testSolarFestivalNextWrapsYear() {
        // 国庆节 (index 9, last) → next(1) → 元旦 (index 0) next year
        let nationalDay = SolarFestival.fromIndex(2024, 9)
        #expect(nationalDay != nil)
        let next = nationalDay?.next(1)
        #expect(next?.festivalName == "元旦")
        #expect(next?.solarDay.year == 2025)
    }

    @Test func testSolarFestivalDescription() {
        let festival = SolarFestival.fromIndex(2024, 0)
        #expect(festival != nil)
        let desc = festival?.description ?? ""
        #expect(desc.contains("元旦"))
    }

    // MARK: - LegalHoliday Tests

    @Test func testLegalHolidayNames() {
        #expect(LegalHoliday.NAMES.count == 9)
        #expect(LegalHoliday.NAMES[0] == "元旦节")
        #expect(LegalHoliday.NAMES[1] == "春节")
        #expect(LegalHoliday.NAMES[2] == "清明节")
        #expect(LegalHoliday.NAMES[3] == "劳动节")
        #expect(LegalHoliday.NAMES[4] == "端午节")
        #expect(LegalHoliday.NAMES[5] == "中秋节")
        #expect(LegalHoliday.NAMES[6] == "国庆节")
        #expect(LegalHoliday.NAMES[7] == "国庆中秋")
        #expect(LegalHoliday.NAMES[8] == "抗战胜利日")
    }

    @Test func testLegalHolidayFromYmd_NewYear2024() {
        // Jan 1, 2024 is a holiday (元旦节)
        let holiday = LegalHoliday.fromYmd(2024, 1, 1)
        #expect(holiday != nil)
        #expect(holiday?.festivalName == "元旦节")
        #expect(holiday?.isWork == false)
    }

    @Test func testLegalHolidayFromYmd_CompensatoryWorkday() {
        // 2024-02-04 is a compensatory workday (调休班) before Spring Festival
        let holiday = LegalHoliday.fromYmd(2024, 2, 4)
        #expect(holiday != nil)
        #expect(holiday?.isWork == true)
    }

    @Test func testLegalHolidayFromYmd_SpringFestival2024() {
        // Feb 10, 2024 is Spring Festival (first day)
        let holiday = LegalHoliday.fromYmd(2024, 2, 10)
        #expect(holiday != nil)
        #expect(holiday?.festivalName == "春节")
        #expect(holiday?.isWork == false)
    }

    @Test func testLegalHolidayFromYmd_NotAHoliday() {
        // A random date not in the system
        let holiday = LegalHoliday.fromYmd(2024, 3, 15)
        #expect(holiday == nil)
    }

    @Test func testLegalHolidayFromYmd_NoRecordBefore2001() {
        // Before Dec 29, 2001 there's no data
        let holiday = LegalHoliday.fromYmd(2000, 1, 1)
        #expect(holiday == nil)
    }

    @Test func testLegalHolidayTarget() {
        // For a compensatory workday, target should point to the holiday day
        let holiday = LegalHoliday.fromYmd(2024, 2, 4)
        #expect(holiday != nil)
        #expect(holiday?.target != nil)
        // The target should be a valid solar day
        let target = holiday?.target
        #expect(target?.year == 2024)
    }

    @Test func testLegalHolidayNext() {
        // From 2024/1/1 (元旦 holiday), next(1) should get the next record in 2024
        let holiday = LegalHoliday.fromYmd(2024, 1, 1)
        #expect(holiday != nil)
        let next = holiday?.next(1)
        #expect(next != nil)
        // The next record after Jan 1 in 2024 should still be in 2024
        #expect(next?.solarDay.year == 2024)
    }

    @Test func testLegalHolidayDescription() {
        let holiday = LegalHoliday.fromYmd(2024, 1, 1)
        #expect(holiday != nil)
        let desc = holiday?.description ?? ""
        #expect(desc.contains("元旦节"))
        #expect(desc.contains("休"))
    }

    @Test func testLegalHolidayDescriptionWorkday() {
        let holiday = LegalHoliday.fromYmd(2024, 2, 4)
        #expect(holiday != nil)
        let desc = holiday?.description ?? ""
        #expect(desc.contains("班"))
    }

    @Test func testLegalHolidayNextCrossYear() {
        // 2024-10-12 is the last holiday record of 2024, next(1) should go to 2025
        let lastHoliday2024 = LegalHoliday.fromYmd(2024, 10, 12)
        #expect(lastHoliday2024 != nil)
        let next = lastHoliday2024?.next(1)
        #expect(next != nil)
        #expect(next?.solarDay.year == 2025)
        #expect(next?.solarDay.month == 1)
        #expect(next?.solarDay.day == 1)
    }

    @Test func testLegalHolidayNationalDay2024() {
        // Oct 1, 2024 is National Day
        let holiday = LegalHoliday.fromYmd(2024, 10, 1)
        #expect(holiday != nil)
        #expect(holiday?.festivalName == "国庆节")
        #expect(holiday?.isWork == false)
    }
}
