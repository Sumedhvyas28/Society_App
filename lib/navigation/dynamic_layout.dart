import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DynamicLayout extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const DynamicLayout({Key? key, required this.navigationShell})
      : super(key: key);

  @override
  _DynamicLayoutState createState() => _DynamicLayoutState();
}

class _DynamicLayoutState extends State<DynamicLayout> {
  // State variable to control layout
  bool isVertical = false;

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? Row(
            children: [
              // Vertical Navigation Rail
              NavigationRail(
                selectedIndex: widget.navigationShell.currentIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    widget.navigationShell.goBranch(index);
                    isVertical = false; // Reset to default after navigating
                  });
                },
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.apartment),
                    label: Text('My Unit'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.card_giftcard),
                    label: Text('Coupon'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.account_balance_wallet),
                    label: Text('Wallet'),
                  ),
                ],
              ),
              // Content Area
              Expanded(child: widget.navigationShell),
            ],
          )
        : Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: widget.navigationShell.currentIndex,
              onTap: (index) {
                setState(() {
                  if (index == 1) {
                    // Example: Move navbar to left only for 'My Unit' page
                    isVertical = true;
                  } else {
                    widget.navigationShell.goBranch(index);
                  }
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apartment),
                  label: 'My Unit',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard),
                  label: 'Coupon',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet),
                  label: 'Wallet',
                ),
              ],
            ),
            body: widget.navigationShell,
          );
  }
}
