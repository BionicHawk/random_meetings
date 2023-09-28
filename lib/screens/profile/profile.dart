import 'package:flutter/material.dart';

import 'package:random_meetings/Common/navigation_bar.dart';
import 'package:random_meetings/screens/home/home.dart';
import 'package:random_meetings/screens/settings/settings.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key});

  void goToHome(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  void goToSettings(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Quitar la flecha de retroceso
       backgroundColor: Color(0xFFFF1154), // Cambiar el color de fondo a rojo
       title: Text("Perfil"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 600, // Ancho de la imagen
              height: 250, // Alto de la imagen 
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0), 
                child: Image.asset(
                  'assets/profile.jpg',
                  fit: BoxFit.cover, 
                ),
              ),
            ),
            const SizedBox(height: 16), // Espacio entre la foto y el nombre de usuario
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWithIcon(title: 'Nombre de usuario', icon: Icons.edit),
                Text(
                  'User',
                  style: TextStyle(height: 1.5),
                ),
                TitleWithIcon(title: 'Sobre mi', icon: Icons.edit),
                Text(
                  'Soy un amante de los museos. Disfruto explorando obras de arte, objetos históricos y'
                  ' exposiciones culturales en mi tiempo libre. Los museos son mi lugar favorito para aprender y encontrar inspiración.',
                  style: TextStyle(height: 2.5),
                ),
                TitleWithIcon(title: 'Ubicación', icon: Icons.edit),
                Text(
                  'Monterrey, Nuevo León',
                  style: TextStyle(height: 1.5),
                ),
                TitleWithIcon(title: 'Intereses', icon: Icons.edit),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomTextContainer(text: 'MUSICA'),
                    CustomTextContainer(text: 'MUSEOS'),
                    CustomTextContainer(text: 'HISTORIA'),
         
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarMap(
        userAtProfile: true,
        goToHome: () => goToHome(context),
        goToSettings: () => goToSettings(context),
      ),
    );
  }
}

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;

  const TitleWithIcon({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(icon),
          onPressed: () {},
        ),
      ],
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  final String text;

  const CustomTextContainer({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Color(0xFFFF1154),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
