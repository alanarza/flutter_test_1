import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
            onTap: (){
              const RecDialog(
                title: 'Grabar',
                description: 'grabacion',
                buttonText: 'cerrar'
              );
            },
            child: SizedBox(
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
          
              const SizedBox(height: 25),
          
              //app name
              const Text(
                "PROFILE",
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 25),

              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileData) {
                    return Text(
                      "Bienvenido/a: ${state.profile.username} \n"
                      "Id: ${state.profile.id} \n"
                      "Email: ${state.profile.email} \n"
                      ,
                      style: const TextStyle(fontSize: 18, fontFamily: 'Roboto'),
                    );
                  }
                  return const CircularProgressIndicator();
                }
              ),

              const SizedBox(height: 50),

              //sign in button
              MyButton(
                text: "Ir al login",
                onTap: () { 
                  context.go('/login');
                }
              ),

              const SizedBox(height: 10),

              //sign in button
              MyButton(
                text: "Cerrar session",
                onTap: () { 
                      userBloc.add(LogoutUser());
                    }
              ),
            ],
          ),
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