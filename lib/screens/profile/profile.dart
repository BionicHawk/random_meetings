import 'package:flutter/material.dart';
import 'package:random_meetings/Common/HardCodedData/fake_interests.dart';
import 'package:random_meetings/Common/app_static_settings.dart';
import 'package:random_meetings/screens/edit_profile/edit_profile.dart';
import 'package:random_meetings/screens/profile/components/description_item.dart';
import 'package:random_meetings/screens/profile/components/information_widget.dart';
import 'package:random_meetings/Common/Interests/interest_box.dart';
import 'package:random_meetings/screens/profile/components/profile_picture.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  static String userName = "User";
  static String description =
      "Soy un amante de los museos. Disfruto explorando obras de arte, objetos históricos y exposiciones culturales en mi tiempo libre. Los museos son mi lugar favorito para aprender y encontrar inspiración.";
  static String address = "Monterrey, Nuevo León";

  @override
  Widget build(BuildContext context) {
    String srcImage = Connection.getApiProfileImage(Connection.localUser!.profilePic!);

    void goEditProfile() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfilePicture(srcImage: srcImage),
          const SizedBox(
              height: 16), // Espacio entre la foto y el nombre de usuario
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DescriptionItem(
                labelName: "Nombre de Usuario",
                icon: Icons.person_rounded,
                editAction: goEditProfile,
                child: InformationWidget(description: Connection.localUser!.username),
              ),
              DescriptionItem(
                labelName: "Sobre mí",
                icon: Icons.question_mark_rounded,
                editAction: goEditProfile,
                child: InformationWidget(
                  description: Connection.localUser!.description ?? "No hay descripción",
                  height: 2.5,
                ),
              ),
              DescriptionItem(
                labelName: "Intereses",
                icon: Icons.interests,
                child: InterestBox(interests: FakeInterests.interests),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
