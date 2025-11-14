import 'package:flutter/material.dart';
import '../../../services/image_service.dart';
import '../models/appointment.dart';
import '../state/appointments_container.dart';
import '../widgets/appointment_tile.dart';
import '../../../shared/widgets/empty_state.dart';

class AppointmentsListScreen extends StatefulWidget {
  @override
  _AppointmentsListScreenState createState() => _AppointmentsListScreenState();
}

class _AppointmentsListScreenState extends State<AppointmentsListScreen> {
  final _doctorController = TextEditingController();
  final _patientController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _purposeController = TextEditingController();

  void _addAppointment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Новая запись'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _doctorController,
                decoration: InputDecoration(labelText: 'Врач'),
              ),
              TextField(
                controller: _patientController,
                decoration: InputDecoration(labelText: 'Пациент'),
              ),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Дата (ГГГГ-ММ-ДД)'),
              ),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Время'),
              ),
              TextField(
                controller: _purposeController,
                decoration: InputDecoration(labelText: 'Цель визита'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_doctorController.text.isNotEmpty &&
                  _patientController.text.isNotEmpty &&
                  _dateController.text.isNotEmpty &&
                  _timeController.text.isNotEmpty &&
                  _purposeController.text.isNotEmpty) {
                final appointment = Appointment(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  doctorName: _doctorController.text,
                  patientName: _patientController.text,
                  date: _dateController.text,
                  time: _timeController.text,
                  purpose: _purposeController.text,
                  imageUrl: ImageService.getAppointmentImage(
                      DateTime.now().millisecondsSinceEpoch.toString()
                  ),
                );
                AppointmentsContainer.of(context).addAppointment(appointment);
                _doctorController.clear();
                _patientController.clear();
                _dateController.clear();
                _timeController.clear();
                _purposeController.clear();
                Navigator.pop(context);
              }
            },
            child: Text('Записать'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appointmentsContainer = AppointmentsContainer.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Записи на прием'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addAppointment,
          ),
        ],
      ),
      body: appointmentsContainer.appointments.isEmpty
          ? const EmptyState(
        title: 'Нет записей',
        message: 'Добавьте первую запись на прием',
        icon: Icons.calendar_today,
      )
          : ListView.builder(
        itemCount: appointmentsContainer.appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointmentsContainer.appointments[index];
          return AppointmentTile(
            appointment: appointment,
            onDelete: () => appointmentsContainer.removeAppointment(appointment.id),
          );
        },
      ),
    );
  }
}