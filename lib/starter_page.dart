import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/view_model/user_session.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final role = GlobalData().role; // Get the user role

    // Define the bottom nav items based on the role
    List<BottomNavigationBarItem> navItems;

    if (role == 'security_guard') {
      // Custom bottom nav items for security guards
      navItems = [
        BottomNavigationBarItem(
          icon: Image.asset('assets/navbar/home.png'),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/navbar/unit.png'),
          label: 'My Unit',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
              'assets/navbar/wallet.png'), // New icon for security-related tasks
          label: 'chat',
        ),
      ];
    } else {
      // Default bottom nav items
      navItems = [
        BottomNavigationBarItem(
          icon: Image.asset('assets/navbar/home.png'),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/navbar/unit.png'),
          label: 'My Unit',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/navbar/coupon.png'),
          label: 'Coupon',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/navbar/wallet.png'),
          label: 'Wallet',
        ),
      ];
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 20,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14,
        items: navItems, // Use the dynamic nav items
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        iconSize: 42,
        elevation: 8,
        selectedLabelStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
