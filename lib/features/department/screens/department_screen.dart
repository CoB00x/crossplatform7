import 'package:flutter/material.dart';

class DepartmentScreen extends StatelessWidget {
  final List<Map<String, dynamic>> departments = [
    {
      'name': 'Кардиология',
      'icon': Icons.favorite,
      'color': Colors.red,
      'doctors': 8,
      'description': 'Диагностика и лечение заболеваний сердца'
    },
    {
      'name': 'Хирургия',
      'icon': Icons.content_cut,
      'color': Colors.orange,
      'doctors': 12,
      'description': 'Оперативное лечение различных заболеваний'
    },
    {
      'name': 'Педиатрия',
      'icon': Icons.child_care,
      'color': Colors.green,
      'doctors': 6,
      'description': 'Лечение детей от 0 до 18 лет'
    },
    {
      'name': 'Неврология',
      'icon': Icons.accessibility,
      'color': Colors.purple,
      'doctors': 5,
      'description': 'Диагностика и лечение нервной системы'
    },
    {
      'name': 'Стоматология',
      'icon': Icons.medical_services,
      'color': Colors.blue,
      'doctors': 7,
      'description': 'Лечение и профилактика заболеваний зубов'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Отделения клиники'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.contacts),
            onPressed: () {
              Navigator.pushNamed(context, '/contacts');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: departments.length,
              itemBuilder: (context, index) {
                final department = departments[index];
                return Container(
                  margin: EdgeInsets.all(4),
                  child: ElevatedButton(
                    onPressed: () {
                      // Демонстрация горизонтальной навигации
                      _showDepartmentDetails(context, department);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: department['color'],
                    ),
                    child: Text(
                      department['name'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: departments.length,
              itemBuilder: (context, index) {
                final department = departments[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: department['color'],
                      child: Icon(
                        department['icon'],
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      department['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(department['description']),
                    trailing: Chip(
                      label: Text('${department['doctors']} врачей'),
                      backgroundColor: department['color'].withOpacity(0.2),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DepartmentDetailScreen(
                            department: department,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDepartmentDetails(BuildContext context, Map<String, dynamic> department) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              department['icon'],
              size: 50,
              color: department['color'],
            ),
            SizedBox(height: 16),
            Text(
              department['name'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(department['description']),
            SizedBox(height: 8),
            Text('Врачей: ${department['doctors']}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Закрыть'),
            ),
          ],
        ),
      ),
    );
  }
}

// Детальный экран отделения
class DepartmentDetailScreen extends StatelessWidget {
  final Map<String, dynamic> department;

  const DepartmentDetailScreen({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(department['name']),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: department['color'],
                child: Icon(
                  department['icon'],
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              department['name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              department['description'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.people),
                      title: Text('Количество врачей'),
                      trailing: Text('${department['doctors']}'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.access_time),
                      title: Text('Часы работы'),
                      trailing: Text('8:00 - 20:00'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Телефон'),
                      trailing: Text('+7 (495) 123-45-67'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Назад к списку отделений'),
            ),
          ],
        ),
      ),
    );
  }
}