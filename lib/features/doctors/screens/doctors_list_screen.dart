import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../state/doctors_container.dart';
import '../widgets/doctor_tile.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../services/image_service.dart';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen({super.key});

  @override
  _DoctorsListScreenState createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  final _nameController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _experienceController = TextEditingController();

  void _addDoctor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Добавить врача'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'ФИО врача',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _specialtyController,
                decoration: const InputDecoration(
                  labelText: 'Специальность',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _experienceController,
                decoration: const InputDecoration(
                  labelText: 'Опыт работы',
                  border: OutlineInputBorder(),
                ),
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
              if (_nameController.text.isNotEmpty &&
                  _specialtyController.text.isNotEmpty &&
                  _experienceController.text.isNotEmpty) {
                final doctor = Doctor(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: _nameController.text,
                  specialty: _specialtyController.text,
                  experience: _experienceController.text,
                  rating: '4.5',
                  imageUrl: ImageService.getRandomMedicalImage(),
                );
                DoctorsContainer.of(context).addDoctor(doctor);
                _nameController.clear();
                _specialtyController.clear();
                _experienceController.clear();
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Врач добавлен успешно'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final doctorsContainer = DoctorsContainer.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Врачи клиники'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.business),
            onPressed: () {
              Navigator.pushNamed(context, '/departments');
            },
          ),
          IconButton(
            icon: Icon(Icons.contacts),
            onPressed: () {
              Navigator.pushNamed(context, '/contacts');
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addDoctor,
          ),
        ],
      ),
      backgroundColor: Colors.grey[50],
      body: doctorsContainer.doctors.isEmpty
          ? const EmptyState(
        title: 'Нет врачей',
        message: 'Добавьте первого врача в клинику',
        icon: Icons.medical_services,
      )
          : ListView.builder(
        itemCount: doctorsContainer.doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctorsContainer.doctors[index];
          return DoctorTile(
            doctor: doctor,
            onDelete: () => _showDeleteDialog(context, doctor),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Doctor doctor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Удалить врача?'),
        content: Text('Вы уверены, что хотите удалить ${doctor.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              DoctorsContainer.of(context).removeDoctor(doctor.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Врач удален'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}