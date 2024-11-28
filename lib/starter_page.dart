import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:society_app/constant/pallete.dart';

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
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type:
            BottomNavigationBarType.fixed, // Ensures labels are always visible
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/navbar/home.png',
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/navbar/unit.png',
            ),
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
        ],
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
