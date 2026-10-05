class Household {
  final String id;
  final String name;
  final String inviteCode;

  Household({required this.id, required this.name, required this.inviteCode});

  factory Household.fromJson(Map<String, dynamic> json) => Household(
    id: json['id'] as String,
    name: json['name'] as String,
    inviteCode: json['invite_code'] as String,
  );
}
