import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:random_meetings/Common/app_static_settings.dart';
import 'package:random_meetings/DTO/ProfileDTO.dart';

class ProfileViewerScreen extends StatefulWidget {
  const ProfileViewerScreen({super.key, required this.userId});

  final int userId;

  @override
  State<ProfileViewerScreen> createState() => _ProfileViewerScreenState();
}

class _ProfileViewerScreenState extends State<ProfileViewerScreen> {
  bool loaded = false;
  ProfileDTO? profileData;

  void fetchUser() async {
    final res = await Dio().get(Connection.getApiUserByIdUrl(widget.userId));
    if (res.statusCode! < 400) {
      loaded = true;
      profileData = ProfileDTO.fromJson(res.data["data"]);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: loaded
            ? Text(profileData!.username)
            : const Text("Cargando perfil..."),
      ),
      body: loaded
          ? ProfileViewer(
              profileData: profileData!,
            )
          : const LoadingPlacer(),
    );
  }
}

class LoadingPlacer extends StatelessWidget {
  const LoadingPlacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ProfileViewer extends StatelessWidget {
  const ProfileViewer({super.key, required this.profileData});

  final ProfileDTO profileData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              width: double.maxFinite,
              height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Image.network(Connection.getApiProfileImage(
                        profileData.profilePic!))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              profileData.username,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(profileData.description ?? "No hay descripción", style: const TextStyle(fontSize: 14),),
          )
        ],
      ),
    );
  }
}
