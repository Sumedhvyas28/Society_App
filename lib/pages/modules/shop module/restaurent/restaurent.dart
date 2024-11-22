import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/models/dummy/shop_modules/restaurent.dart';

class RestaurentPage extends StatefulWidget {
  const RestaurentPage({super.key});

  @override
  State<RestaurentPage> createState() => _RestaurentPageState();
}

class _RestaurentPageState extends State<RestaurentPage> {
  int? expandedIndex; // Track the currently expanded card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Restaurant'),
      backgroundColor: Pallete.mainDashColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            children: List.generate(restaurentItems.length, (index) {
              return _buildCard(context, index, restaurentItems[index]);
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, int index, dynamic item) {
    bool isExpanded =
        expandedIndex == index; // Check if the current card is expanded

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  // Toggle expanded state
                  expandedIndex = isExpanded ? null : index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.asset(
                      item['img'],
                      width: 60,
                      height: 60,
                    ),
                    Expanded(
                      child: Text(
                        item['title'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.arrow_drop_up // Change icon when expanded
                          : Icons.arrow_drop_down,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded) ...[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the specific page on first button press
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        restaurentItems[index]['page']));
                          },
                          child: Text(
                            'Order',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Pallete.btnColor,
                            minimumSize: const Size.fromHeight(40),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8), // Spacing between buttons
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      restaurentItems[index]['Chat']));
                        },
                        child: const Text(
                          'chat',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: Pallete.btnColor,
                          minimumSize: const Size.fromHeight(40),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
