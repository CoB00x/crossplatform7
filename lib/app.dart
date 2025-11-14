import 'package:flutter/material.dart';
import 'shared/app_theme.dart';
import 'features/doctors/state/doctors_container.dart';
import 'features/appointments/state/appointments_container.dart';
import 'features/profile/state/profile_container.dart';
import 'features/gallery/screens/medical_gallery_screen.dart';
import 'features/department/screens/department_screen.dart';
import 'features/doctors/screens/doctors_list_screen.dart';
import 'features/appointments/screens/appointments_list_screen.dart';
import 'features/profile/screens/profile_list_screen.dart';
import 'features/contacts/screens/contacts_screen.dart';

class MedicalCenterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Медицинский Центр',
      theme: AppTheme.lightTheme,
      home: AppStateContainer(),
      debugShowCheckedModeBanner: false,

      // Маршрутизированная навигацияj
      routes: {
        '/': (context) => AppStateContainer(),
        '/doctors': (context) => DoctorsListScreen(),
        '/appointments': (context) => AppointmentsListScreen(),
        '/gallery': (context) => MedicalGalleryScreen(),
        '/profile': (context) => ProfileScreen(),
        '/departments': (context) => DepartmentScreen(),
        '/contacts': (context) => ContactsScreen(),
      },
    );
  }
}

class AppStateContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DoctorsContainer(
      child: AppointmentsContainer(
        child: ProfileContainer(
          child: MainNavigationScreen(),
        ),
      ),
    );
  }
}

// Главный экран с BottomNavigationBar (вертикальная навигация)
class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    DoctorsListScreen(),
    AppointmentsListScreen(),
    MedicalGalleryScreen(),
    ProfileScreen(),
    DepartmentScreen(), // Новый экран отделений
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.blue[800],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_services),
              label: 'Врачи',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Записи',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_library),
              label: 'Галерея',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Отделения',
            ),
          ],
        ),
      ),
    );
  }
}