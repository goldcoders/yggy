import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    String? id,
    Map<String, dynamic>? appMetadata,
    Map<String, dynamic>? userMetadata,
    String? aud,
    String? email,
    String? createdAt,
    String? role,
    String? updatedAt,
    String? confirmedAt,
    String? lastSignInAt,
  }) : super(
            id: id,
            appMetadata: appMetadata,
            userMetadata: userMetadata,
            aud: aud,
            email: email,
            createdAt: createdAt,
            confirmedAt: confirmedAt,
            lastSignInAt: lastSignInAt,
            role: role,
            updatedAt: updatedAt);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String?,
        appMetadata: json['app_metadata'] as Map<String, dynamic>?,
        userMetadata: json['user_metadata'] as Map<String, dynamic>?,
        aud: json['aud'] as String?,
        email: json['email'] as String?,
        createdAt: json['created_at'] as String?,
        confirmedAt: json['confirmed_at'] as String?,
        lastSignInAt: json['last_sign_in_at'] as String?,
        role: json['role'] as String?,
        updatedAt: json['updated_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'app_metadata': appMetadata,
        'user_metadata': userMetadata,
        'aud': aud,
        'email': email,
        'created_at': createdAt,
        'confirmed_at': confirmedAt,
        'last_sign_in_at': lastSignInAt,
        'role': role,
        'updated_at': updatedAt,
      };
}
