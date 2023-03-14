class PrayerTime {
  List<Timing> data = [];
  PrayerTime.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((e) {
      data.add(Timing.fromJson(e));
    });
  }
}

class Timing {
  late PrayerTiming timing;
  late Data readable;

  Timing.fromJson(Map<String, dynamic> json) {
    timing = PrayerTiming.fromJson(json["timings"]);
    readable = Data.fromJson(json["date"]);
  }
}

class PrayerTiming {
  late String fajr;
  late String duhur;
  late String asr;
  late String maghrib;
  late String isha;
  PrayerTiming.fromJson(Map<String, dynamic> json) {
    fajr = json["Fajr"];
    duhur = json["Dhuhr"];
    asr = json["Asr"];
    maghrib = json["Maghrib"];
    isha = json["Isha"];
  }
}

class Data {
  late String readable;
  Data.fromJson(Map<String, dynamic> json) {
    readable = json["readable"];
  }
}
