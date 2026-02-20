import com.tyme.solar.SolarDay;
import com.tyme.solar.SolarTime;
import com.tyme.solar.SolarTerm;
import com.tyme.lunar.LunarDay;
import com.tyme.rabbyung.RabByungDay;
import java.io.*;
import java.time.LocalDate;
import java.util.*;

public class TruthTableGenerator {

    static class SolarLunarEntry {
        String solar;
        String lunarYear;
        String lunarMonth;
        String lunarDay;
        boolean isLeapMonth;

        SolarLunarEntry(String solar, String lunarYear, String lunarMonth, String lunarDay, boolean isLeapMonth) {
            this.solar = solar;
            this.lunarYear = lunarYear;
            this.lunarMonth = lunarMonth;
            this.lunarDay = lunarDay;
            this.isLeapMonth = isLeapMonth;
        }
    }

    static class SixtyCycleEntry {
        String solar;
        String sixtyCycleYear;
        String sixtyCycleMonth;
        String sixtyCycleDay;
        String duty;
        String twelveStar;
        String dayNineStar;
        String twentyEightStar;

        SixtyCycleEntry(String solar, String sixtyCycleYear, String sixtyCycleMonth, String sixtyCycleDay,
                        String duty, String twelveStar, String dayNineStar, String twentyEightStar) {
            this.solar = solar;
            this.sixtyCycleYear = sixtyCycleYear;
            this.sixtyCycleMonth = sixtyCycleMonth;
            this.sixtyCycleDay = sixtyCycleDay;
            this.duty = duty;
            this.twelveStar = twelveStar;
            this.dayNineStar = dayNineStar;
            this.twentyEightStar = twentyEightStar;
        }
    }

    static class EightCharEntry {
        String solarTime;
        String yearPillar;
        String monthPillar;
        String dayPillar;
        String hourPillar;

        EightCharEntry(String solarTime, String yearPillar, String monthPillar, String dayPillar, String hourPillar) {
            this.solarTime = solarTime;
            this.yearPillar = yearPillar;
            this.monthPillar = monthPillar;
            this.dayPillar = dayPillar;
            this.hourPillar = hourPillar;
        }
    }

    static class SolarTermEntry {
        int year;
        int termIndex;
        String termName;
        String solarDate;

        SolarTermEntry(int year, int termIndex, String termName, String solarDate) {
            this.year = year;
            this.termIndex = termIndex;
            this.termName = termName;
            this.solarDate = solarDate;
        }
    }

    static class ConstellationEntry {
        String solar;
        String constellation;

        ConstellationEntry(String solar, String constellation) {
            this.solar = solar;
            this.constellation = constellation;
        }
    }

    static class SixStarEntry {
        String solar;
        String sixStar;

        SixStarEntry(String solar, String sixStar) {
            this.solar = solar;
            this.sixStar = sixStar;
        }
    }

    static class RabByungEntry {
        String solar;
        String rabByungYear;
        String rabByungMonth;
        String rabByungDay;

        RabByungEntry(String solar, String rabByungYear, String rabByungMonth, String rabByungDay) {
            this.solar = solar;
            this.rabByungYear = rabByungYear;
            this.rabByungMonth = rabByungMonth;
            this.rabByungDay = rabByungDay;
        }
    }

    static class SolarFestivalEntry {
        String solar;
        String name;

        SolarFestivalEntry(String solar, String name) {
            this.solar = solar;
            this.name = name;
        }
    }

    static class LunarFestivalEntry {
        String solar;
        String name;

        LunarFestivalEntry(String solar, String name) {
            this.solar = solar;
            this.name = name;
        }
    }

    static class DogDayEntry {
        String solar;
        String dogDay;

        DogDayEntry(String solar, String dogDay) {
            this.solar = solar;
            this.dogDay = dogDay;
        }
    }

    static class NineDayEntry {
        String solar;
        String nineDay;

        NineDayEntry(String solar, String nineDay) {
            this.solar = solar;
            this.nineDay = nineDay;
        }
    }

    // Generate EightChar entries (every 30 days, all 12 even hours)
    private static List<EightCharEntry> generateEightCharEntries() {
        List<EightCharEntry> entries = new ArrayList<>();
        LocalDate current = LocalDate.of(2000, 1, 1);
        LocalDate end = LocalDate.of(2030, 12, 31);

        while (!current.isAfter(end)) {
            try {
                for (int hour = 0; hour < 24; hour += 2) {
                    SolarTime st = SolarTime.fromYmdHms(current.getYear(), current.getMonthValue(), current.getDayOfMonth(), hour, 0, 0);
                    com.tyme.eightchar.EightChar ec = st.getLunarHour().getEightChar();

                    String solarTimeStr = String.format("%04d-%02d-%02d %02d", current.getYear(), current.getMonthValue(), current.getDayOfMonth(), hour);
                    entries.add(new EightCharEntry(
                        solarTimeStr,
                        ec.getYear().getName(),
                        ec.getMonth().getName(),
                        ec.getDay().getName(),
                        ec.getHour().getName()
                    ));
                }
            } catch (Exception e) {
                System.err.println("Error processing " + current + ": " + e.getMessage());
            }
            current = current.plusDays(30);
        }

        return entries;
    }

    // Generate SolarTerm entries (all 24 terms for each year)
    private static List<SolarTermEntry> generateSolarTermEntries() {
        List<SolarTermEntry> entries = new ArrayList<>();

        for (int year = 1900; year <= 2100; year++) {
            for (int termIndex = 0; termIndex < 24; termIndex++) {
                try {
                    SolarTerm term = SolarTerm.fromIndex(year, termIndex);
                    SolarDay sd = term.getSolarDay();
                    String solarDateStr = String.format("%04d-%02d-%02d", sd.getYear(), sd.getMonth(), sd.getDay());
                    entries.add(new SolarTermEntry(
                        year,
                        termIndex,
                        term.getName(),
                        solarDateStr
                    ));
                } catch (Exception e) {
                    System.err.println("Error processing SolarTerm year=" + year + " termIndex=" + termIndex + ": " + e.getMessage());
                }
            }
        }

        return entries;
    }

    // Generate RabByung entries (every 30 days from 1950-02-01 to 2050-02-11)
    private static List<RabByungEntry> generateRabByungEntries() {
        List<RabByungEntry> entries = new ArrayList<>();
        LocalDate current = LocalDate.of(1950, 2, 1);
        LocalDate end = LocalDate.of(2050, 2, 11);

        while (!current.isAfter(end)) {
            try {
                SolarDay solar = SolarDay.fromYmd(current.getYear(), current.getMonthValue(), current.getDayOfMonth());
                RabByungDay rabByung = solar.getRabByungDay();
                String solarStr = current.toString();
                entries.add(new RabByungEntry(
                    solarStr,
                    rabByung.getRabByungMonth().getRabByungYear().getName(),
                    rabByung.getRabByungMonth().getName(),
                    rabByung.getName()
                ));
            } catch (Exception e) {
                System.err.println("Error processing " + current + ": " + e.getMessage());
            }
            current = current.plusDays(30);
        }

        return entries;
    }

    // Generate SolarFestival entries (enumerated by fromIndex, year 1900-2100, i=0-9)
    private static List<SolarFestivalEntry> generateSolarFestivalEntries(int[] errorCount) {
        List<SolarFestivalEntry> entries = new ArrayList<>();

        for (int year = 1900; year <= 2100; year++) {
            for (int i = 0; i < 10; i++) {
                try {
                    com.tyme.festival.SolarFestival festival = com.tyme.festival.SolarFestival.fromIndex(year, i);
                    SolarDay day = festival.getDay();
                    String solarStr = String.format("%04d-%02d-%02d", day.getYear(), day.getMonth(), day.getDay());
                    entries.add(new SolarFestivalEntry(solarStr, festival.getName()));
                } catch (IllegalArgumentException e) {
                    // Skip if out of range (expected)
                } catch (Exception e) {
                    System.err.println("Error processing SolarFestival year=" + year + " i=" + i + ": " + e.getMessage());
                    errorCount[0]++;
                }
            }
        }

        return entries;
    }

    // Generate LunarFestival entries (enumerated by fromIndex, year 1900-2100, i=0-12)
    private static List<LunarFestivalEntry> generateLunarFestivalEntries(int[] errorCount) {
        List<LunarFestivalEntry> entries = new ArrayList<>();

        for (int year = 1900; year <= 2100; year++) {
            for (int i = 0; i < 13; i++) {
                try {
                    com.tyme.festival.LunarFestival festival = com.tyme.festival.LunarFestival.fromIndex(year, i);
                    SolarDay day = festival.getDay().getSolarDay();
                    String solarStr = String.format("%04d-%02d-%02d", day.getYear(), day.getMonth(), day.getDay());
                    entries.add(new LunarFestivalEntry(solarStr, festival.getName()));
                } catch (IllegalArgumentException e) {
                    // Skip if out of range (expected)
                } catch (Exception e) {
                    System.err.println("Error processing LunarFestival year=" + year + " i=" + i + ": " + e.getMessage());
                    errorCount[0]++;
                }
            }
        }

        return entries;
    }

    // Generate DogDay entries (scan daily from 1900-06-01 to 2100-09-30, record non-null results)
    private static List<DogDayEntry> generateDogDayEntries(int[] errorCount) {
        List<DogDayEntry> entries = new ArrayList<>();
        LocalDate current = LocalDate.of(1900, 6, 1);
        LocalDate end = LocalDate.of(2100, 9, 30);

        while (!current.isAfter(end)) {
            try {
                SolarDay solar = SolarDay.fromYmd(current.getYear(), current.getMonthValue(), current.getDayOfMonth());
                com.tyme.culture.dog.DogDay dogDay = solar.getDogDay();
                if (dogDay != null) {
                    String solarStr = current.toString();
                    entries.add(new DogDayEntry(solarStr, dogDay.toString()));
                }
            } catch (Exception e) {
                System.err.println("Error processing dogDay " + current + ": " + e.getMessage());
                errorCount[0]++;
            }
            current = current.plusDays(1);
        }

        return entries;
    }

    // Generate NineDay entries (scan daily from 1900-11-01 to 2101-03-31, record non-null results)
    private static List<NineDayEntry> generateNineDayEntries(int[] errorCount) {
        List<NineDayEntry> entries = new ArrayList<>();
        LocalDate current = LocalDate.of(1900, 11, 1);
        LocalDate end = LocalDate.of(2101, 3, 31);

        while (!current.isAfter(end)) {
            try {
                SolarDay solar = SolarDay.fromYmd(current.getYear(), current.getMonthValue(), current.getDayOfMonth());
                com.tyme.culture.nine.NineDay nineDay = solar.getNineDay();
                if (nineDay != null) {
                    String solarStr = current.toString();
                    entries.add(new NineDayEntry(solarStr, nineDay.toString()));
                }
            } catch (Exception e) {
                System.err.println("Error processing nineDay " + current + ": " + e.getMessage());
                errorCount[0]++;
            }
            current = current.plusDays(1);
        }

        return entries;
    }

    public static void main(String[] args) throws Exception {
        String outputDir = "/Users/ruining/Developer/tyme4swift/Tests/tymeTests/Fixtures/";
        if (args.length > 0 && args[0].equals("--output")) {
            outputDir = args[1];
        }

        // Create output directory if not exists
        new File(outputDir).mkdirs();

        // Global error counter for unexpected errors
        int[] errorCount = {0};

        System.out.println("Generating truth tables...");

        // Generate solar_lunar.json (sample every 7 days)
        System.out.print("Generating solar_lunar.json...");
        List<SolarLunarEntry> solarLunarEntries = new ArrayList<>();
        LocalDate current = LocalDate.of(1900, 1, 31);
        LocalDate end = LocalDate.of(2100, 12, 31);

        while (!current.isAfter(end)) {
            try {
                SolarDay solar = SolarDay.fromYmd(current.getYear(), current.getMonthValue(), current.getDayOfMonth());
                LunarDay lunar = solar.getLunarDay();

                String lunarYearName = lunar.getLunarMonth().getLunarYear().getName();
                String lunarMonthName = lunar.getLunarMonth().getName();
                String lunarDayName = lunar.getName();
                boolean isLeap = lunar.getLunarMonth().isLeap();

                solarLunarEntries.add(new SolarLunarEntry(
                    current.toString(),
                    lunarYearName,
                    lunarMonthName,
                    lunarDayName,
                    isLeap
                ));
            } catch (Exception e) {
                System.err.println("Error processing " + current + ": " + e.getMessage());
            }
            current = current.plusDays(7);
        }

        System.out.println(" " + solarLunarEntries.size() + " entries");

        // Generate sixty_cycle.json (sample every 15 days)
        System.out.print("Generating sixty_cycle.json...");
        List<SixtyCycleEntry> sixtyCycleEntries = new ArrayList<>();
        current = LocalDate.of(1900, 1, 31);

        while (!current.isAfter(end)) {
            try {
                SolarDay solar = SolarDay.fromYmd(current.getYear(), current.getMonthValue(), current.getDayOfMonth());
                com.tyme.sixtycycle.SixtyCycleDay scd = solar.getSixtyCycleDay();
                String yearName = scd.getYear().getName();
                String monthName = scd.getMonth().getName();
                String dayName = scd.getSixtyCycle().getName();
                String dutyName = scd.getDuty().getName();
                String twelveStarName = scd.getTwelveStar().getName();
                String dayNineStarName = scd.getNineStar().getName() + scd.getNineStar().getColor();
                String twentyEightStarName = scd.getTwentyEightStar().getName();

                sixtyCycleEntries.add(new SixtyCycleEntry(
                    current.toString(),
                    yearName,
                    monthName,
                    dayName,
                    dutyName,
                    twelveStarName,
                    dayNineStarName,
                    twentyEightStarName
                ));
            } catch (Exception e) {
                System.err.println("Error processing " + current + ": " + e.getMessage());
            }
            current = current.plusDays(15);
        }

        System.out.println(" " + sixtyCycleEntries.size() + " entries");

        // Generate eight_char.json
        System.out.print("Generating eight_char.json...");
        List<EightCharEntry> eightCharEntries = generateEightCharEntries();
        System.out.println(" " + eightCharEntries.size() + " entries");

        // Generate solar_term.json
        System.out.print("Generating solar_term.json...");
        List<SolarTermEntry> solarTermEntries = generateSolarTermEntries();
        System.out.println(" " + solarTermEntries.size() + " entries");

        // Generate rab_byung.json
        System.out.print("Generating rab_byung.json...");
        List<RabByungEntry> rabByungEntries = generateRabByungEntries();
        System.out.println(" " + rabByungEntries.size() + " entries");

        // Generate constellation.json (sample every 7 days, 1900-2100)
        System.out.print("Generating constellation.json...");
        List<ConstellationEntry> constellationEntries = new ArrayList<>();
        current = LocalDate.of(1900, 1, 31);
        while (!current.isAfter(end)) {
            try {
                SolarDay solar = SolarDay.fromYmd(current.getYear(), current.getMonthValue(), current.getDayOfMonth());
                constellationEntries.add(new ConstellationEntry(
                    current.toString(),
                    solar.getConstellation().getName()
                ));
            } catch (Exception e) {
                System.err.println("Error processing " + current + ": " + e.getMessage());
            }
            current = current.plusDays(7);
        }
        System.out.println(" " + constellationEntries.size() + " entries");

        // Generate six_star.json (sample every 7 days, 1900-2100)
        System.out.print("Generating six_star.json...");
        List<SixStarEntry> sixStarEntries = new ArrayList<>();
        current = LocalDate.of(1900, 1, 31);
        while (!current.isAfter(end)) {
            try {
                SolarDay solar = SolarDay.fromYmd(current.getYear(), current.getMonthValue(), current.getDayOfMonth());
                sixStarEntries.add(new SixStarEntry(
                    current.toString(),
                    solar.getLunarDay().getSixStar().getName()
                ));
            } catch (Exception e) {
                System.err.println("Error processing " + current + ": " + e.getMessage());
            }
            current = current.plusDays(7);
        }
        System.out.println(" " + sixStarEntries.size() + " entries");

        // Generate solar_festival.json
        System.out.print("Generating solar_festival.json...");
        List<SolarFestivalEntry> solarFestivalEntries = generateSolarFestivalEntries(errorCount);
        System.out.println(" " + solarFestivalEntries.size() + " entries");

        // Generate lunar_festival.json
        System.out.print("Generating lunar_festival.json...");
        List<LunarFestivalEntry> lunarFestivalEntries = generateLunarFestivalEntries(errorCount);
        System.out.println(" " + lunarFestivalEntries.size() + " entries");

        // Generate dog_day.json
        System.out.print("Generating dog_day.json...");
        List<DogDayEntry> dogDayEntries = generateDogDayEntries(errorCount);
        System.out.println(" " + dogDayEntries.size() + " entries");

        // Generate nine_day.json
        System.out.print("Generating nine_day.json...");
        List<NineDayEntry> nineDayEntries = generateNineDayEntries(errorCount);
        System.out.println(" " + nineDayEntries.size() + " entries");

        // Write solar_lunar.json
        writeJson(outputDir + "solar_lunar.json", solarLunarEntries);

        // Write sixty_cycle.json
        writeJson(outputDir + "sixty_cycle.json", sixtyCycleEntries);

        // Write eight_char.json
        writeJson(outputDir + "eight_char.json", eightCharEntries);

        // Write solar_term.json
        writeJson(outputDir + "solar_term.json", solarTermEntries);

        // Write rab_byung.json
        writeJson(outputDir + "rab_byung.json", rabByungEntries);

        // Write constellation.json
        writeJson(outputDir + "constellation.json", constellationEntries);

        // Write six_star.json
        writeJson(outputDir + "six_star.json", sixStarEntries);

        // Write solar_festival.json
        writeJson(outputDir + "solar_festival.json", solarFestivalEntries);

        // Write lunar_festival.json
        writeJson(outputDir + "lunar_festival.json", lunarFestivalEntries);

        // Write dog_day.json
        writeJson(outputDir + "dog_day.json", dogDayEntries);

        // Write nine_day.json
        writeJson(outputDir + "nine_day.json", nineDayEntries);

        // Print error summary
        if (errorCount[0] > 0) {
            System.err.println("Warning: " + errorCount[0] + " unexpected errors during generation (see above).");
        } else {
            System.out.println("All entries generated without unexpected errors.");
        }

        System.out.println("Done!");
    }

    private static void writeJson(String filename, List<?> entries) throws IOException {
        try (FileWriter writer = new FileWriter(filename)) {
            writer.write("[\n");
            for (int i = 0; i < entries.size(); i++) {
                Object entry = entries.get(i);
                if (entry instanceof SolarLunarEntry) {
                    SolarLunarEntry e = (SolarLunarEntry) entry;
                    writer.write(String.format(
                        "  {\"solar\":\"%s\",\"lunarYear\":\"%s\",\"lunarMonth\":\"%s\",\"lunarDay\":\"%s\",\"isLeapMonth\":%s}",
                        e.solar, e.lunarYear, e.lunarMonth, e.lunarDay, e.isLeapMonth
                    ));
                } else if (entry instanceof SixtyCycleEntry) {
                    SixtyCycleEntry e = (SixtyCycleEntry) entry;
                    writer.write(String.format(
                        "  {\"solar\":\"%s\",\"sixtyCycleYear\":\"%s\",\"sixtyCycleMonth\":\"%s\",\"sixtyCycleDay\":\"%s\",\"duty\":\"%s\",\"twelveStar\":\"%s\",\"dayNineStar\":\"%s\",\"twentyEightStar\":\"%s\"}",
                        e.solar, e.sixtyCycleYear, e.sixtyCycleMonth, e.sixtyCycleDay,
                        e.duty, e.twelveStar, e.dayNineStar, e.twentyEightStar
                    ));
                } else if (entry instanceof EightCharEntry) {
                    EightCharEntry e = (EightCharEntry) entry;
                    writer.write(String.format(
                        "  {\"solarTime\":\"%s\",\"yearPillar\":\"%s\",\"monthPillar\":\"%s\",\"dayPillar\":\"%s\",\"hourPillar\":\"%s\"}",
                        e.solarTime, e.yearPillar, e.monthPillar, e.dayPillar, e.hourPillar
                    ));
                } else if (entry instanceof SolarTermEntry) {
                    SolarTermEntry e = (SolarTermEntry) entry;
                    writer.write(String.format(
                        "  {\"year\":%d,\"termIndex\":%d,\"termName\":\"%s\",\"solarDate\":\"%s\"}",
                        e.year, e.termIndex, e.termName, e.solarDate
                    ));
                } else if (entry instanceof RabByungEntry) {
                    RabByungEntry e = (RabByungEntry) entry;
                    writer.write(String.format(
                        "  {\"solar\":\"%s\",\"rabByungYear\":\"%s\",\"rabByungMonth\":\"%s\",\"rabByungDay\":\"%s\"}",
                        e.solar, e.rabByungYear, e.rabByungMonth, e.rabByungDay
                    ));
                } else if (entry instanceof ConstellationEntry) {
                    ConstellationEntry e = (ConstellationEntry) entry;
                    writer.write(String.format(
                        "  {\"solar\":\"%s\",\"constellation\":\"%s\"}",
                        e.solar, e.constellation
                    ));
                } else if (entry instanceof SixStarEntry) {
                    SixStarEntry e = (SixStarEntry) entry;
                    writer.write(String.format(
                        "  {\"solar\":\"%s\",\"sixStar\":\"%s\"}",
                        e.solar, e.sixStar
                    ));
                } else if (entry instanceof SolarFestivalEntry) {
                    SolarFestivalEntry e = (SolarFestivalEntry) entry;
                    writer.write(String.format(
                        "  {\"solar\":\"%s\",\"name\":\"%s\"}",
                        e.solar, e.name
                    ));
                } else if (entry instanceof LunarFestivalEntry) {
                    LunarFestivalEntry e = (LunarFestivalEntry) entry;
                    writer.write(String.format(
                        "  {\"solar\":\"%s\",\"name\":\"%s\"}",
                        e.solar, e.name
                    ));
                } else if (entry instanceof DogDayEntry) {
                    DogDayEntry e = (DogDayEntry) entry;
                    writer.write(String.format(
                        "  {\"solar\":\"%s\",\"dogDay\":\"%s\"}",
                        e.solar, e.dogDay
                    ));
                } else if (entry instanceof NineDayEntry) {
                    NineDayEntry e = (NineDayEntry) entry;
                    writer.write(String.format(
                        "  {\"solar\":\"%s\",\"nineDay\":\"%s\"}",
                        e.solar, e.nineDay
                    ));
                }

                if (i < entries.size() - 1) {
                    writer.write(",\n");
                } else {
                    writer.write("\n");
                }
            }
            writer.write("]\n");
        }
    }
}
