
int Date(int day, int month, int year) {
  int date = day;
  date <<= 4;
  date |= month;
  date <<= 11;
  date |= year- 2000;
  return date;
}

int Date(int hour, int minute, int day, int month, int year) {
  int date = minute;
  date <<= 6;
  date |= hour;
  date <<= 5;
  date |= day;
  date <<= 4;
  date |= month;
  date <<= 11;
  date |= year- 2000;
  return date;
}

int getMinute(int date) {
  return date >> 26 & 63;
}
int getHour(int date) {
  return date >> 20 & 63;
}
int getDay(int date) {
  return date >> 15 & 31;
}
int getMonth(int date) {
  return date >> 11 & 15;
}
int getYear(int date) {
  return (date & 2047) + 2000;
}
int setHour(int date, int hour) {
  return date & ~(63 << 20) | hour << 20;
}
void printDate(int date) {
  println(nf(getHour(date), 2) + ":" + nf(getMinute(date), 2) + " " + nf(getDay(date), 2) + "." + nf(getMonth(date), 2) + " " + getYear(date));
}

boolean DateEquals(int date1, int date2) {
  return date1 == date2;
}

boolean DateHigher(int date1, int date2) {
  int H1 = getHour(date1), H2 = getHour(date2);
  int M1 = getMinute(date1), M2 = getMinute(date2);
  int d1 = getDay(date1), d2 = getDay(date2);
  int m1 = getMonth(date1), m2 = getMonth(date2);
  int y1 = getYear(date1), y2 = getYear(date2);

  if (y1 > y2) {
    return true;
  } else {
    if (y1 != y2) return false;
    if (m1 > m2) {
      return true;
    } else {
      if (m1 != m2) return false;
      if (d1 > d2) {
        return true;
      } else {
        if (d1 != d2) return false;
        if (H1 > H2) {
          return true;
        } else {
          if (H1 != H2) return false;
          return (M1 > M2);
        }
      }
    }
  }
}
