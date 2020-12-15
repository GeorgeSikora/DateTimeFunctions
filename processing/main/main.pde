
String[] nazevDne = { "neděle", "pondělí", "úterý", "středa", "čtvrtek", "pátek", "sobota" };

DateSim date;

/* 
 timer1 - 1 minute
 timer2 - 10 minutes
 timer3 - 1 hour
 timer4 - 8 hours
 */

long timer1 = 0;
long timer2 = 0;
long timer3 = 0;
long timer4 = 0;

int dateNow, dateLast;

int dateTimeShift;
byte seasonType = 0; // 1 - summer, 0 - winter

void setup() {

  frameRate(999);

  //int date1  = Date(13, 38, 5, 12, 2020);
  //printDate(date1);
  //int date2  = Date(10, 30, 12, 12, 2020);
  //println(DateHigher(date1, date2));

  date = new DateSim(25, 10, 2020);

  dateNow  = Date(date.day(), date.month(), date.year());
  dateLast = Date(date.day(), date.month(), date.year());

  getNextTimeShift();
}

void getNextTimeShift() {

  int year = getYear(dateNow);

  int summerShiftDay = getLastDayOfWeekInMonth(0, 3, year);
  int summerShift = Date(3, 0, summerShiftDay, 3, year); // z 3 na 2 hod

  int winterShiftDay = getLastDayOfWeekInMonth(0, 10, year);
  int winterShift = Date(2, 0, winterShiftDay, 10, year); // z 2 na 3 hod

  if (DateHigher(summerShift, dateNow)) {
    println("Čekáme na letní časík");
    seasonType = 0;
  } else {
    if (DateHigher(winterShift, dateNow)) {
      println("Čekáme už jen na zimní čas");
      seasonType = 1;
    } else {
      year++;

      summerShiftDay = getLastDayOfWeekInMonth(0, 3, year);
      summerShift = Date(summerShiftDay, 3, year); // z 3 na 2 hod
      println("Čekáme na letní časík");
      seasonType = 0;
    }
  }

  print("Aktuální čas ");
  printDate(dateNow);

  print("Den posunu ");
  if (seasonType == 0) {
    printDate(summerShift);
    dateTimeShift = summerShift;
  } else {
    printDate(winterShift);
    dateTimeShift = winterShift;
  }
}

void draw() {

  if (millis() > timer1) {
    timer1 = millis() + 60000L;
    //println("1 minute");
    if (millis() > timer2) {
      timer2 = millis() + 600000L;
      //println("10 minutes");
      if (millis() > timer3) {

        timer3 = millis() + 3600000L;
        //println("1 hour");
        if (millis() > timer4) {
          timer4 = millis() + 28800000L;
          //println("8 hours");
        }
      }
    }
  }

  date.tick();
  date.print();

  // get RTC date
  dateNow = Date(date.hour(), date.minute(), date.day(), date.month(), date.year());

  //if (!DateEquals(dateNow, dateLast)) {

  //println("Its new day, lets check some things");

  if (DateHigher(dateNow, dateTimeShift)) {

    if (seasonType == 0) {
      println("Today at 2am we will shift time to 3am !");
      dateNow
    } else {
      println("Today at 3am we will shift time to 2am !");
    }

    getNextTimeShift();
  }
  //}

  dateLast = dateNow;
}

int getDay(int d, int m, int r) {
  byte[] t = { 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4 };
  if (m < 3) r -= 1;
  return (r + r / 4 - r / 100 + r / 400 + t[m - 1] + d) % 7;
}

int getLastDayInMonth(int m, int y) {
  if (m < 1 || m > 12) return -1;
  if (m == 2) return (y + 4) % 4 == 0 ? 29 : 28;
  if (m > 7) m++;
  return 30 + m % 2;
}

String getMonthName(int m) {
  if (m < 1 || m > 12) return "none";
  String[] monthsName = {"Leden", "Únor", "Březen", "Duben", "Květen", "Červen", "Červenec", "Srpen", "Září", "Říjen", "Listopad", "Prosinec"};
  return monthsName[m-1];
}

int getLastDayOfWeekInMonth(int d, int m, int y) {
  int lastDay = getLastDayInMonth(m, y);
  for (int i = 0; i < 7; i++) {
    if (getDay(lastDay - i, m, y) == d) return lastDay - i;
  }
  return -1;
}
