import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../../../services/image_service.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onDelete;

  const AppointmentTile({
    required this.appointment,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: ImageService.buildCircleNetworkImage(
          appointment.imageUrl,
          size: 50,
        ),
        title: Text(
          '${appointment.time} - ${appointment.doctorName}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Пациент: ${appointment.patientName}'),
            Text('Дата: ${appointment.date}'),
            Text('Цель: ${appointment.purpose}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}