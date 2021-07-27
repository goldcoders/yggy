import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final Map<String, dynamic> appMetadata;
  final Map<String, dynamic> userMetadata;
  final String? aud;
  final String? email;
  final String? createdAt;
  final String? confirmedAt;
  final String? lastSignInAt;
  final String? role;
  final String? updatedAt;

  UserEntity({
    this.id,
    Map<String, dynamic>? appMetadata,
    Map<String, dynamic>? userMetadata,
    this.aud,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.confirmedAt,
    this.lastSignInAt,
  })  : appMetadata = appMetadata ?? {},
        userMetadata = userMetadata ?? {};

  @override
  List<Object?> get props => [
        id,
        appMetadata,
        userMetadata,
        aud,
        email,
        createdAt,
        confirmedAt,
        lastSignInAt,
        role,
        updatedAt
      ];
}
