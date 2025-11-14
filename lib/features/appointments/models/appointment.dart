class Appointment {
  final String id;
  final String doctorName;
  final String patientName;
  final String date;
  final String time;
  final String purpose;
  final String imageUrl;
  Appointment({
    required this.id,
    required this.doctorName,
    required this.patientName,
    required this.date,
    required this.time,
    required this.purpose,
    required this.imageUrl,
  });

  Appointment copyWith({
    String? id,
    String? doctorName,
    String? patientName,
    String? date,
    String? time,
    String? purpose,
    String? imageUrl,
  }) {
    return Appointment(
      id: id ?? this.id,
      doctorName: doctorName ?? this.doctorName,
      patientName: patientName ?? this.patientName,
      date: date ?? this.date,
      time: time ?? this.time,
      purpose: purpose ?? this.purpose,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}