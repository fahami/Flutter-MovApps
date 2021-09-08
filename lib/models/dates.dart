class Dates {
  String? maximum;
  String? minimum;

  Dates({this.maximum, this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: json['maximum'] as String?,
        minimum: json['minimum'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'maximum': maximum,
        'minimum': minimum,
      };
}
