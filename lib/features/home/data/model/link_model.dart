import 'package:groceries/features/home/domain/entities/link_entites.dart';

class LinkModel extends Link {
  LinkModel({
    required String? url,
    required String label,
    required bool active,
  }) : super(
    url: url,
    label: label,
    active: active,
  );

  factory LinkModel.fromJson(Map<String, dynamic> json) {
    return LinkModel(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}
