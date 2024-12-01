String getHoroscope(DateTime birthday) {
  int day = birthday.day;
  int month = birthday.month;

  if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return "Aries";
  if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return "Taurus";
  if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) return "Gemini";
  if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) return "Cancer";
  if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return "Leo";
  if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return "Virgo";
  if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) return "Libra";
  if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) return "Scorpio";
  if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) return "Sagittarius";
  if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) return "Capricorn";
  if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return "Aquarius";
  if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) return "Pisces";

  return "Unknown";
}

class ZodiacPeriod {
  final DateTime start;
  final DateTime end;
  final String zodiac;

  ZodiacPeriod({required this.start, required this.end, required this.zodiac});
}

String getZodiac(DateTime date) {
  final List<ZodiacPeriod> chinesseZodiacTable = [
    ZodiacPeriod(start: DateTime(2023, 1, 22), end: DateTime(2024, 2, 9), zodiac: "Rabbit"),
    ZodiacPeriod(start: DateTime(2022, 2, 1), end: DateTime(2023, 1, 21), zodiac: "Tiger"),
    ZodiacPeriod(start: DateTime(2021, 2, 12), end: DateTime(2022, 1, 31), zodiac: "Ox"),
    ZodiacPeriod(start: DateTime(2020, 1, 25), end: DateTime(2021, 2, 11), zodiac: "Rat"),
    ZodiacPeriod(start: DateTime(2019, 2, 5), end: DateTime(2020, 1, 24), zodiac: "Pig"),
    ZodiacPeriod(start: DateTime(2018, 2, 16), end: DateTime(2019, 2, 4), zodiac: "Dog"),
    ZodiacPeriod(start: DateTime(2017, 1, 28), end: DateTime(2018, 2, 15), zodiac: "Rooster"),
    ZodiacPeriod(start: DateTime(2016, 2, 8), end: DateTime(2017, 1, 27), zodiac: "Monkey"),
    ZodiacPeriod(start: DateTime(2015, 2, 19), end: DateTime(2016, 2, 7), zodiac: "Goat"),
    ZodiacPeriod(start: DateTime(2014, 1, 31), end: DateTime(2015, 2, 18), zodiac: "Horse"),
    ZodiacPeriod(start: DateTime(2013, 2, 10), end: DateTime(2014, 1, 30), zodiac: "Snake"),
    ZodiacPeriod(start: DateTime(2012, 1, 23), end: DateTime(2013, 2, 9), zodiac: "Dragon"),
    ZodiacPeriod(start: DateTime(2011, 2, 3), end: DateTime(2012, 1, 22), zodiac: "Rabbit"),
    ZodiacPeriod(start: DateTime(2010, 2, 14), end: DateTime(2011, 2, 2), zodiac: "Tiger"),
    ZodiacPeriod(start: DateTime(2009, 1, 26), end: DateTime(2010, 2, 13), zodiac: "Ox"),
    ZodiacPeriod(start: DateTime(2008, 2, 7), end: DateTime(2009, 1, 25), zodiac: "Rat"),
    ZodiacPeriod(start: DateTime(2007, 2, 18), end: DateTime(2008, 2, 6), zodiac: "Boar"),
    ZodiacPeriod(start: DateTime(2006, 1, 29), end: DateTime(2007, 2, 17), zodiac: "Dog"),
    ZodiacPeriod(start: DateTime(2005, 2, 9), end: DateTime(2006, 1, 28), zodiac: "Rooster"),
    ZodiacPeriod(start: DateTime(2004, 1, 22), end: DateTime(2005, 2, 8), zodiac: "Monkey"),
    ZodiacPeriod(start: DateTime(2003, 2, 1), end: DateTime(2004, 1, 21), zodiac: "Goat"),
    ZodiacPeriod(start: DateTime(2002, 2, 12), end: DateTime(2003, 1, 31), zodiac: "Horse"),
    ZodiacPeriod(start: DateTime(2001, 1, 24), end: DateTime(2002, 2, 11), zodiac: "Snake"),
    ZodiacPeriod(start: DateTime(2000, 2, 5), end: DateTime(2001, 1, 23), zodiac: "Dragon"),
    ZodiacPeriod(start: DateTime(1999, 2, 16), end: DateTime(2000, 2, 4), zodiac: "Rabbit"),
    ZodiacPeriod(start: DateTime(1998, 1, 28), end: DateTime(1999, 2, 15), zodiac: "Tiger"),
    ZodiacPeriod(start: DateTime(1997, 2, 7), end: DateTime(1998, 1, 27), zodiac: "Ox"),
    ZodiacPeriod(start: DateTime(1996, 2, 19), end: DateTime(1997, 2, 6), zodiac: "Rat"),
    ZodiacPeriod(start: DateTime(1995, 1, 31), end: DateTime(1996, 2, 18), zodiac: "Boar"),
    ZodiacPeriod(start: DateTime(1994, 2, 10), end: DateTime(1995, 1, 30), zodiac: "Dog"),
    ZodiacPeriod(start: DateTime(1993, 1, 23), end: DateTime(1994, 2, 9), zodiac: "Rooster"),
    ZodiacPeriod(start: DateTime(1992, 2, 4), end: DateTime(1993, 1, 22), zodiac: "Monkey"),
    ZodiacPeriod(start: DateTime(1991, 2, 15), end: DateTime(1992, 2, 3), zodiac: "Goat"),
    ZodiacPeriod(start: DateTime(1990, 1, 27), end: DateTime(1991, 2, 14), zodiac: "Horse"),
    ZodiacPeriod(start: DateTime(1989, 2, 6), end: DateTime(1990, 1, 26), zodiac: "Snake"),
    ZodiacPeriod(start: DateTime(1988, 2, 17), end: DateTime(1989, 2, 5), zodiac: "Dragon"),
    ZodiacPeriod(start: DateTime(1987, 1, 29), end: DateTime(1988, 2, 16), zodiac: "Rabbit"),
    ZodiacPeriod(start: DateTime(1986, 2, 9), end: DateTime(1987, 1, 28), zodiac: "Tiger"),
    ZodiacPeriod(start: DateTime(1985, 2, 20), end: DateTime(1986, 2, 8), zodiac: "Ox"),
    ZodiacPeriod(start: DateTime(1984, 2, 2), end: DateTime(1985, 2, 19), zodiac: "Rat"),
    ZodiacPeriod(start: DateTime(1983, 2, 13), end: DateTime(1984, 2, 1), zodiac: "Boar"),
    ZodiacPeriod(start: DateTime(1982, 1, 25), end: DateTime(1983, 2, 12), zodiac: "Dog"),
    ZodiacPeriod(start: DateTime(1981, 2, 5), end: DateTime(1982, 1, 24), zodiac: "Rooster"),
    ZodiacPeriod(start: DateTime(1980, 2, 16), end: DateTime(1981, 2, 4), zodiac: "Monkey"),
    ZodiacPeriod(start: DateTime(1979, 1, 28), end: DateTime(1980, 2, 15), zodiac: "Goat"),
    ZodiacPeriod(start: DateTime(1978, 2, 7), end: DateTime(1979, 1, 27), zodiac: "Horse"),
    ZodiacPeriod(start: DateTime(1977, 2, 18), end: DateTime(1978, 2, 6), zodiac: "Snake"),
    ZodiacPeriod(start: DateTime(1976, 1, 31), end: DateTime(1977, 2, 17), zodiac: "Dragon"),
    ZodiacPeriod(start: DateTime(1975, 2, 11), end: DateTime(1976, 1, 30), zodiac: "Rabbit"),
    ZodiacPeriod(start: DateTime(1974, 1, 23), end: DateTime(1975, 2, 10), zodiac: "Tiger"),
    ZodiacPeriod(start: DateTime(1973, 2, 3), end: DateTime(1974, 1, 22), zodiac: "Ox"),
    ZodiacPeriod(start: DateTime(1972, 1, 16), end: DateTime(1973, 2, 2), zodiac: "Rat"),
    ZodiacPeriod(start: DateTime(1971, 1, 27), end: DateTime(1972, 1, 15), zodiac: "Boar"),
    ZodiacPeriod(start: DateTime(1970, 2, 6), end: DateTime(1971, 1, 26), zodiac: "Dog"),
    ZodiacPeriod(start: DateTime(1969, 2, 17), end: DateTime(1970, 2, 5), zodiac: "Rooster"),
    ZodiacPeriod(start: DateTime(1968, 1, 30), end: DateTime(1969, 2, 16), zodiac: "Monkey"),
    ZodiacPeriod(start: DateTime(1967, 2, 9), end: DateTime(1968, 1, 29), zodiac: "Goat"),
    ZodiacPeriod(start: DateTime(1966, 1, 21), end: DateTime(1967, 2, 8), zodiac: "Horse"),
    ZodiacPeriod(start: DateTime(1965, 2, 2), end: DateTime(1966, 1, 20), zodiac: "Snake"),
    ZodiacPeriod(start: DateTime(1964, 2, 13), end: DateTime(1965, 2, 1), zodiac: "Dragon"),
    ZodiacPeriod(start: DateTime(1963, 1, 25), end: DateTime(1964, 2, 12), zodiac: "Rabbit"),
    ZodiacPeriod(start: DateTime(1962, 2, 5), end: DateTime(1963, 1, 24), zodiac: "Tiger"),
    ZodiacPeriod(start: DateTime(1961, 2, 15), end: DateTime(1962, 2, 4), zodiac: "Ox"),
    ZodiacPeriod(start: DateTime(1960, 1, 28), end: DateTime(1961, 2, 14), zodiac: "Rat"),
    ZodiacPeriod(start: DateTime(1959, 2, 8), end: DateTime(1960, 1, 27), zodiac: "Boar"),
    ZodiacPeriod(start: DateTime(1958, 2, 18), end: DateTime(1959, 2, 7), zodiac: "Dog"),
    ZodiacPeriod(start: DateTime(1957, 1, 31), end: DateTime(1958, 2, 17), zodiac: "Rooster"),
    ZodiacPeriod(start: DateTime(1956, 2, 12), end: DateTime(1957, 1, 30), zodiac: "Monkey"),
    ZodiacPeriod(start: DateTime(1955, 1, 24), end: DateTime(1956, 2, 11), zodiac: "Goat"),
    ZodiacPeriod(start: DateTime(1954, 2, 3), end: DateTime(1955, 1, 23), zodiac: "Horse"),
    ZodiacPeriod(start: DateTime(1953, 2, 14), end: DateTime(1954, 2, 2), zodiac: "Snake"),
    ZodiacPeriod(start: DateTime(1952, 1, 27), end: DateTime(1953, 2, 13), zodiac: "Dragon"),
    ZodiacPeriod(start: DateTime(1951, 2, 6), end: DateTime(1952, 1, 26), zodiac: "Rabbit"),
    ZodiacPeriod(start: DateTime(1950, 2, 17), end: DateTime(1951, 2, 5), zodiac: "Tiger"),
    ZodiacPeriod(start: DateTime(1949, 1, 29), end: DateTime(1950, 2, 16), zodiac: "Ox"),
    ZodiacPeriod(start: DateTime(1948, 2, 10), end: DateTime(1949, 1, 28), zodiac: "Rat"),
    ZodiacPeriod(start: DateTime(1947, 1, 22), end: DateTime(1948, 2, 9), zodiac: "Boar"),
    ZodiacPeriod(start: DateTime(1946, 2, 2), end: DateTime(1947, 1, 21), zodiac: "Dog"),
    ZodiacPeriod(start: DateTime(1945, 2, 13), end: DateTime(1946, 2, 1), zodiac: "Rooster"),
    ZodiacPeriod(start: DateTime(1944, 1, 25), end: DateTime(1945, 2, 12), zodiac: "Monkey"),
    ZodiacPeriod(start: DateTime(1943, 2, 5), end: DateTime(1944, 1, 24), zodiac: "Goat"),
    ZodiacPeriod(start: DateTime(1942, 2, 15), end: DateTime(1943, 2, 4), zodiac: "Horse"),
    ZodiacPeriod(start: DateTime(1941, 1, 27), end: DateTime(1942, 2, 14), zodiac: "Snake"),
    ZodiacPeriod(start: DateTime(1940, 2, 8), end: DateTime(1941, 1, 26), zodiac: "Dragon"),
    ZodiacPeriod(start: DateTime(1939, 2, 19), end: DateTime(1940, 2, 7), zodiac: "Rabbit"),
    ZodiacPeriod(start: DateTime(1938, 1, 31), end: DateTime(1939, 2, 18), zodiac: "Tiger"),
    ZodiacPeriod(start: DateTime(1937, 2, 11), end: DateTime(1938, 1, 30), zodiac: "Ox"),
    ZodiacPeriod(start: DateTime(1936, 1, 24), end: DateTime(1937, 2, 10), zodiac: "Rat"),
    ZodiacPeriod(start: DateTime(1935, 2, 4), end: DateTime(1936, 1, 23), zodiac: "Boar"),
    ZodiacPeriod(start: DateTime(1934, 2, 14), end: DateTime(1935, 2, 3), zodiac: "Dog"),
    ZodiacPeriod(start: DateTime(1933, 1, 26), end: DateTime(1934, 2, 13), zodiac: "Rooster"),
    ZodiacPeriod(start: DateTime(1932, 2, 6), end: DateTime(1933, 1, 25), zodiac: "Monkey"),
    ZodiacPeriod(start: DateTime(1931, 2, 17), end: DateTime(1932, 2, 5), zodiac: "Goat"),
    ZodiacPeriod(start: DateTime(1930, 1, 30), end: DateTime(1931, 2, 16), zodiac: "Horse"),
    ZodiacPeriod(start: DateTime(1929, 2, 10), end: DateTime(1930, 1, 29), zodiac: "Snake"),
    ZodiacPeriod(start: DateTime(1928, 1, 23), end: DateTime(1929, 2, 9), zodiac: "Dragon"),
    ZodiacPeriod(start: DateTime(1927, 2, 2), end: DateTime(1928, 1, 22), zodiac: "Rabbit"),
    ZodiacPeriod(start: DateTime(1926, 2, 13), end: DateTime(1927, 2, 1), zodiac: "Tiger"),
    ZodiacPeriod(start: DateTime(1925, 1, 25), end: DateTime(1926, 2, 12), zodiac: "Ox"),
    ZodiacPeriod(start: DateTime(1924, 2, 5), end: DateTime(1925, 1, 24), zodiac: "Rat"),
    ZodiacPeriod(start: DateTime(1923, 2, 16), end: DateTime(1924, 2, 4), zodiac: "Boar"),
    ZodiacPeriod(start: DateTime(1922, 1, 28), end: DateTime(1923, 2, 15), zodiac: "Dog"),
    ZodiacPeriod(start: DateTime(1921, 2, 8), end: DateTime(1922, 1, 27), zodiac: "Rooster"),
    ZodiacPeriod(start: DateTime(1920, 2, 20), end: DateTime(1921, 2, 7), zodiac: "Monkey"),
    ZodiacPeriod(start: DateTime(1919, 2, 1), end: DateTime(1920, 2, 19), zodiac: "Goat"),
    ZodiacPeriod(start: DateTime(1918, 2, 11), end: DateTime(1919, 1, 31), zodiac: "Horse"),
    ZodiacPeriod(start: DateTime(1917, 1, 23), end: DateTime(1918, 2, 10), zodiac: "Snake"),
    ZodiacPeriod(start: DateTime(1916, 2, 3), end: DateTime(1917, 1, 22), zodiac: "Dragon"),
    ZodiacPeriod(start: DateTime(1915, 2, 14), end: DateTime(1916, 2, 2), zodiac: "Rabbit"),
    ZodiacPeriod(start: DateTime(1914, 1, 26), end: DateTime(1915, 2, 13), zodiac: "Tiger"),
    ZodiacPeriod(start: DateTime(1913, 2, 6), end: DateTime(1914, 1, 25), zodiac: "Ox"),
    ZodiacPeriod(start: DateTime(1912, 2, 18), end: DateTime(1913, 2, 5), zodiac: "Rat"),
  ];

  for (ZodiacPeriod entry in chinesseZodiacTable) {
    if (date.isAfter(entry.start) && date.isBefore(entry.end)) {
      return entry.zodiac;
    }
  }
  return "Unknown";
}


