import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_2/bloc/profile/profile_bloc.dart';
import 'package:test_2/bloc/user/user_bloc.dart';
import 'package:test_2/view/components/custom_tabbar.dart';
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
  
  @override
  void initState() {
    super.initState();
    _loadUserProfile();
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
                
                    Padding(
                      padding: const EdgeInsets.all(10.0),
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
                            Text(
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
                            Text(
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
                            Text(
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
                  Center(child: Text("Contenido de Sonidos")),
                  Center(child: Text("Contenido de Compartido"))
                ],
              ),
            ),
            
          ],
        ),
      )
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