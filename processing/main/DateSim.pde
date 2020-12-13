
class DateSim {
  int tickRate = 9999999;
  int day, month, year, hour, minute, second;
  DateSim(int d, int m, int y) {
    this.day = d;
    this.month = m;
    this.year = y;
  }
  void tick() {
    second += tickRate;
    calcMinutes();
  }
  void calcMinutes() {
    if (second >= 60) {
      minute += floor(second/60);
      second %= 60;
      calcHours();
    }
  }
  void calcHours() {
    if (minute >= 60) {
      hour += floor(minute/60);
      minute %= 60;
      calcDays();
    }
  }
  void calcDays() {
    if (hour >= 24) {
      day += floor(hour/24);
      hour %= 24;
      calcMonths();
    }
  }
  void calcMonths() {
    if (day > getLastDayInMonth(month, year)) {
      while (day > getLastDayInMonth(month, year)) {
        day -= getLastDayInMonth(month, year);
        month++;
        calcYears();
      }
    }
  }
  void calcYears() {
    if (month > 12) {
      year += floor(month/12);
      month %= 12;
    }
  }
  int second() { 
    return second;
  }
  int minute() { 
    return minute;
  }
  int hour() { 
    return hour;
  }
  int day() { 
    return day;
  }
  int month() { 
    return month;
  }
  int year() { 
    return year;
  }
  void print() { 
    println(nf(this.hour, 2) + ":" + nf(this.minute, 2) + ":" + nf(this.second, 2) + "  " + nf(this.day, 2) + "." + this.month + "/" + this.year);
  }
}
