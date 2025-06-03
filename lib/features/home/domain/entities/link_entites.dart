import 'package:equatable/equatable.dart';
import 'package:groceries/features/home/domain/entities/product_entites.dart';

class Link extends Equatable {
  final String? url;
  final String label;
  final bool active;

  const Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'] as String?,
      label: json['label'] as String? ?? '',
      active: json['active'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [url, label, active];
}