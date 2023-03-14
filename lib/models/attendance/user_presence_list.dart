import 'package:siangmalam/models/attendance/presence_response.dart';
import 'package:siangmalam/models/pageable.dart';

/*Created By Dwi Sutrisno*/

class UserPresenceResponse {
  List<PresenceResponse>? content;
  Pageable? pageable;

  UserPresenceResponse({this.content, this.pageable});

  UserPresenceResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <PresenceResponse>[];
      json['content'].forEach((v) {
        content!.add(PresenceResponse.fromJson(v));
      });
    }
    pageable = json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    if (pageable != null) {
      data['pageable'] = pageable!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'UserPresenceResponse{content: $content}';
  }
}
