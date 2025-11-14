import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageService {
  static final List<String> _medicalImages = [
    'https://png.pngtree.com/background/20230613/original/pngtree-various-medical-devices-on-wheels-sit-next-to-eachother-in-a-picture-image_3426773.jpg',
    'https://framerusercontent.com/images/fxr1oDL9iiRZfGqnoOJPi9X7t8.png',
    'https://avatars.mds.yandex.net/i?id=05c0ccfb74fc2759a1ebffc9ea36ed09c34811d8-16336042-images-thumbs&n=13',
    'https://www.32top.ru/image/clinicSnippet/large/1029469.png',
    'https://avatars.mds.yandex.net/i?id=0948de4e6d0e069dd42132a765cd4b43_l-5419733-images-thumbs&n=13',
    'https://www.groupdentistrynow.com/wp-content/uploads/2020/01/dentists2.png',
  ];

  static final List<String> _doctorAvatars = [
    'https://avatars.mds.yandex.net/i?id=0c4dfc9984b695c0e8e77eca05489fe18ac4a639-12900429-images-thumbs&n=13',
    'https://avatars.mds.yandex.net/i?id=beb50b6c2dd2bd72dbb1e99e7e190c582fbd0cb1-8199228-images-thumbs&n=13',
    'https://avatars.mds.yandex.net/i?id=d9ab49f0c777060524955c5b732cd5faa933f60b-5233313-images-thumbs&n=13',
    'https://cdn-icons-png.flaticon.com/512/846/846958.png',
    'https://pngfre.com/wp-content/uploads/Stethoscope-26.png',
    'https://avatars.mds.yandex.net/i?id=ed5da289ec51bfefea28463aa199b880ab43f16f-5869855-images-thumbs&n=13',
  ];

  static String getRandomMedicalImage() {
    final random = DateTime.now().millisecondsSinceEpoch % _medicalImages.length;
    return _medicalImages[random];
  }

  static String getDoctorImage(String doctorId) {
    final index = doctorId.hashCode % _doctorAvatars.length;
    return _doctorAvatars[index.abs()];
  }

  static String getAppointmentImage(String appointmentId) {
    final index = appointmentId.hashCode % _medicalImages.length;
    return _medicalImages[index.abs()];
  }

  static Widget buildNetworkImage(
      String imageUrl, {
        double? width,
        double? height,
        BoxFit fit = BoxFit.cover,
      }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => _buildLoadingPlaceholder(width, height),
      errorWidget: (context, url, error) {
        print('Ошибка загрузки изображения: $error');
        print('URL: $url');
        return _buildErrorPlaceholder(width, height);
      },
    );
  }

  static Widget buildCircleNetworkImage(
      String imageUrl, {
        double size = 50,
      }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue[100],
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              color: Colors.blue[800],
            ),
          ),
          errorWidget: (context, url, error) => _buildCircleErrorPlaceholder(size),
        ),
      ),
    );
  }

  static Widget _buildLoadingPlaceholder(double? width, double? height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.blue[800],
        ),
      ),
    );
  }

  static Widget _buildErrorPlaceholder(double? width, double? height) {
    return Container(
      width: width,
      height: height,
      color: Colors.blue[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.medical_services,
            color: Colors.blue[800],
            size: 40,
          ),
          SizedBox(height: 8),
          Text(
            'Загрузка...',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue[800],
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  

  static Widget _buildCircleErrorPlaceholder(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue[100],
      ),
      child: Icon(
        Icons.person,
        color: Colors.blue[800],
        size: size * 0.6,
      ),
    );
  }
}