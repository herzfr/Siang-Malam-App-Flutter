class PresenceStatusDto {
  int presenceId = 0;
  bool isHashCheckIn = false;
  bool isHasCheckout = false;
  String date = '';
  int? checkInTime;

  PresenceStatusDto({
    required this.presenceId,
    required this.isHashCheckIn,
    required this.isHasCheckout,
    required this.date,
    required this.checkInTime,
  });

  PresenceStatusDto.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    presenceId = json['presenceId'];
    isHashCheckIn = json['isHashCheckIn'];
    isHasCheckout = json['isHasCheckout'];
    checkInTime = json['checkInTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['presenceId'] = presenceId;
    data['isHashCheckIn'] = isHashCheckIn;
    data['isHasCheckout'] = isHasCheckout;
    data['checkInTime'] = checkInTime;
    return data;
  }

  @override
  String toString() {
    return 'PresenceStatusDto{presenceId: $presenceId, isHashCheckIn: $isHashCheckIn, isHasCheckout: $isHasCheckout, date: $date, checkInTime: $checkInTime}';
  }
}
