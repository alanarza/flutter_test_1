import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:test_2/bloc/profile/profile_bloc.dart';
import 'package:test_2/bloc/user/user_bloc.dart';
import 'package:test_2/view/components/my_button.dart';
import 'package:test_2/view/components/rec_dialog.dart';

class ProfileView extends StatefulWidget {

  const ProfileView({
    super.key
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }
  
  @override
  void initState() {
    super.initState();
    _loadUserProfile();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future<void> _loadUserProfile() async {

    //show loading circle
    /*showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator()
      ),
    );*/

    try {
      var _profileBloc = BlocProvider.of<ProfileBloc>(context);
      _profileBloc.add(SaveProfileData());
      //if (context.mounted) Navigator.pop(context);
    } catch (error) {
      //if (context.mounted) Navigator.pop(context);
        print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  context.go('/home');
                },
              ),
            )
          ],
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                context.go('/home');
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).colorScheme.primary,
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavBarItem(CupertinoIcons.home, 'home'),
              buildNavBarItem(CupertinoIcons.search, 'search'),
              const SizedBox(width: 20),
              buildNavBarItem(CupertinoIcons.bell, 'notifications'),
              buildNavBarItem(CupertinoIcons.profile_circled, 'profile')
            ],
          ),
        ),
        floatingActionButton: ClipOval(
          child: Material(
            color: Color(0xFF7861FF),
            elevation: 10,
            child: InkWell(
              onTap: () {RecDialog("asd",context);},
              child: const SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  CupertinoIcons.mic_fill,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const CircleAvatar(
                          radius: 47,
                          backgroundImage: AssetImage("assets/images/profile2.jpg"),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundColor: Color(0xFF7861FF),
                            child: Icon(
                              Icons.edit,
                              size: 15,
                              color: Colors.white,
                            ),
                          )
                        )
                      ],
                    ),
                
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Alan Arza",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87
                        ),
                      ),
                    ),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "34",
                              style: Theme.of(context).textTheme.titleMedium
                            ),
                            const Text(
                              "Sonidos",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87
                              ),
                            ),
                          ],
                        ),
                
                        Column(
                          children: [
                            Text(
                              "340",
                              style: Theme.of(context).textTheme.titleMedium
                            ),
                            const Text(
                              "Seguidores",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87
                              ),
                            ),
                          ],
                        ),
                
                        Column(
                          children: [
                            Text(
                              "410",
                              style: Theme.of(context).textTheme.titleMedium
                            ),
                            const Text(
                              "Seguidos",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    MyButton(
                      text: "Seguir",
                      onTap: () {}
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),
            
            Container(
              color: Colors.white,
              child: const TabBar.secondary(
                labelColor: Color(0xFF7861FF),
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xFF7861FF),
                dividerColor: Colors.grey,
                tabs: [
                  Tab(text: "Sonidos"),
                  Tab(text: "Compartido")
                ],
              ),
            ),
            // Contenido del TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  tab1Content(),
                  tab2Content()
                ],
              ),
            ),
            
          ],
        ),
      )
    );
  }

  Widget tab1Content() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          cardAudioPlayer(),

          cardAudioPlayer(),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12)
            ),
            padding: const EdgeInsets.all(26),
            margin: const EdgeInsets.only(bottom: 10),
            child: const Center(
              child: Text(
                "Contenido de Sonidos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12)
            ),
            padding: const EdgeInsets.all(26),
            margin: const EdgeInsets.only(bottom: 10),
            child: const Center(
              child: Text(
                "Contenido de Sonidos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
            ),
          ),

        ]
      )
    );
  }

  Widget tab2Content() {
    return const Center(
      child: Text("Contenido de Compartido"),
    );
  }

  Widget cardAudioPlayer() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12)
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      child: Center(
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Test.mp3"),
                const SizedBox(width: 20),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFF7861FF),
                  child: IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: () {
                      if (isPlaying) {
                        player.pause();
                      } else {
                        player.play(AssetSource("audios/tu_desprecio.mp3"));
                      }
                    }
                  ),
                ),
                const SizedBox(width: 20),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFF7861FF),
                  child: IconButton(
                    icon: const Icon(Icons.stop),
                    onPressed: () {
                      player.stop();
                    }
                  ),
                ),
                
                
              ],
            ),

            Slider(
              min: 0, 
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) {
                final position = Duration(seconds: value.toInt());
                player.seek(position);
                player.resume();
              }
            ),

            Container(
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position.inSeconds)),
                  Text(formatTime((duration - position).inSeconds)),
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, String url) {
    return InkWell(
      onTap: () => {
        context.go('/$url')
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: url == 'profile' ? Color(0xFF7861FF) : Colors.black87,
          )
        ],
      ),
    );
  }
}