class TimeApiDto {
  int? year;
  int? month;
  int? day;
  int? hour;
  int? minute;
  int? seconds;
  int? milliSeconds;
  String? dateTime;
  String? date;
  String? time;
  String? timeZone;
  String? dayOfWeek;
  bool? dstActive;

  TimeApiDto(
      {this.year,
      this.month,
      this.day,
      this.hour,
      this.minute,
      this.seconds,
      this.milliSeconds,
      this.dateTime,
      this.date,
      this.time,
      this.timeZone,
      this.dayOfWeek,
      this.dstActive});

  TimeApiDto.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
    hour = json['hour'];
    minute = json['minute'];
    seconds = json['seconds'];
    milliSeconds = json['milliSeconds'];
    dateTime = json['dateTime'];
    date = json['date'];
    time = json['time'];
    timeZone = json['timeZone'];
    dayOfWeek = json['dayOfWeek'];
    dstActive = json['dstActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    data['day'] = day;
    data['hour'] = hour;
    data['minute'] = minute;
    data['seconds'] = seconds;
    data['milliSeconds'] = milliSeconds;
    data['dateTime'] = dateTime;
    data['date'] = date;
    data['time'] = time;
    data['timeZone'] = timeZone;
    data['dayOfWeek'] = dayOfWeek;
    data['dstActive'] = dstActive;
    return data;
  }
}
