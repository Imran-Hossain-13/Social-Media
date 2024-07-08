import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:untitled/view/dashboasrd/home/home_screen.dart';
import 'package:untitled/view/dashboasrd/profile/profile.dart';
import 'package:untitled/view/dashboasrd/user/user_list.dart';
import '../../res/color.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final tabController = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen(){
    return [
      const HomeScreen(),
      const Center(child: Text("Add"),),
      const UserListScreen(),
      const UserListScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem(){
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home,color: AppColors.whiteColor,size: 37,),
        inactiveIcon: const Icon(Icons.home,color: AppColors.whiteColor,size: 33,),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.camera_alt,color: AppColors.whiteColor,size: 37,),
        inactiveIcon: const Icon(Icons.camera_alt,color: AppColors.whiteColor,size: 33,),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.message,color: AppColors.whiteColor,size: 37,),
        inactiveIcon: const Icon(Icons.message,color: AppColors.whiteColor,size: 33,),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.supervised_user_circle_rounded,color: AppColors.whiteColor,size: 37,),
        inactiveIcon: const Icon(Icons.supervised_user_circle_rounded,color: AppColors.whiteColor,size: 33,),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person,color: AppColors.whiteColor,size: 37,),
        inactiveIcon: const Icon(Icons.person,color: AppColors.whiteColor,size: 33,),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(),
      items: _navBarItem(),
      controller: tabController,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0),
        colorBehindNavBar: Colors.red,
      ),
      navBarStyle: NavBarStyle.style6,
      backgroundColor: AppColors.primaryButtonColor,
    );
  }
}
