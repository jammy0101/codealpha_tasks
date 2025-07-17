// models/order_model.dart
import 'mobil_modal.dart';

class OrderModel {
  final String id;
  final List<MobileModel> items;
  final double total;
  final String userId;
  final DateTime createdAt;
  final String status; // e.g., pending, shipped, delivered

  OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.userId,
    required this.createdAt,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'items': items.map((e) => e.toJson()).toList(),
    'total': total,
    'userId': userId,
    'createdAt': createdAt.toIso8601String(),
    'status': status,
  };

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      items: List<MobileModel>.from(json['items'].map((e) => MobileModel.fromJson(e))),
      total: json['total'],
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
    );
  }
  /// ✅ Add this copyWith method
  OrderModel copyWith({
    String? id,
    List<MobileModel>? items,
    double? total,
    String? userId,
    DateTime? createdAt,
    String? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      items: items ?? this.items,
      total: total ?? this.total,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}
