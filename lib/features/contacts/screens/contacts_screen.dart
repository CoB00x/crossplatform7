import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Контакты'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Маршрутизированная навигация назад
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          _buildContactCard(
            'Главный корпус',
            'г. Москва, ул. Медицинская, д. 1',
            '+7 (495) 123-45-67',
            Icons.business,
            Colors.blue,
          ),
          _buildContactCard(
            'Педиатрическое отделение',
            'г. Москва, ул. Детская, д. 15',
            '+7 (495) 123-45-68',
            Icons.child_care,
            Colors.green,
          ),
          _buildContactCard(
            'Хирургический центр',
            'г. Москва, ул. Операционная, д. 3',
            '+7 (495) 123-45-69',
            Icons.content_cut,
            Colors.orange,
          ),
          _buildContactCard(
            'Стоматология',
            'г. Москва, ул. Зубная, д. 7',
            '+7 (495) 123-45-70',
            Icons.medical_services,
            Colors.red,
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Навигация по именованному маршруту
                    Navigator.pushNamed(context, '/doctors');
                  },
                  child: Text('Перейти к врачам'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/appointments');
                  },
                  child: Text('Перейти к записям'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/gallery');
                  },
                  child: Text('Перейти к галерее'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(String title, String address, String phone, IconData icon, Color color) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(icon, color: Colors.white),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(address),
                  SizedBox(height: 4),
                  Text(phone),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}