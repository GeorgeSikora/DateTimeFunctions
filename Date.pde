
byte[] Date(int d, int m, int y) {
  int data = d;
  data <<= 4;
  data |= m;
  data <<= 7;
  data |= y- 2000;
  return new byte[]{(byte) (data >> 8), (byte) data};
}

int getDay(byte[] date) {
  return date[0] >> 3 & 31;
}
int getMonth(byte[] date) {
  return date[0] << 1 & 15 | date[1] >> 7 & 1;
}
int getYear(byte[] date) {
  return (date[1] & 127) + 2000;
}
void printDate(byte[] date) {
  println(getDay(date) + ". " + getMonth(date) + " " + getYear(date));
}

boolean DateEquals(byte[] date1, byte[] date2) {
  return date1[0] == date2[0] && date1[1] == date2[1];
}

boolean DateHigher(byte[] date1, byte[] date2) {
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
      return (d1 > d2);
    }
  }
}
