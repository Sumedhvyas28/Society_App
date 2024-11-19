import 'package:flutter/material.dart';
import 'package:society_app/constant/pallete.dart';

class VisitorTypeSection extends StatelessWidget {
  final bool isFirstCheckboxChecked;
  final bool isSecondCheckboxChecked;
  final ValueChanged<bool?> onFirstCheckboxChanged;
  final ValueChanged<bool?> onSecondCheckboxChanged;

  const VisitorTypeSection({
    Key? key,
    required this.isFirstCheckboxChecked,
    required this.isSecondCheckboxChecked,
    required this.onFirstCheckboxChanged,
    required this.onSecondCheckboxChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Visitor Type',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04,
              ),
            ),
            SizedBox(height: screenWidth * 0.03),
            Row(
              children: [
                _buildCheckbox(
                  value: isFirstCheckboxChecked,
                  label: 'Vendor',
                  onChanged: onFirstCheckboxChanged,
                ),
                SizedBox(width: screenWidth * 0.03),
                _buildCheckbox(
                  value: isSecondCheckboxChecked,
                  label: 'Guest',
                  onChanged: onSecondCheckboxChanged,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE5E5E5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add_rounded, color: Pallete.textBtnClr),
                      Text('Click',
                          style: TextStyle(color: Pallete.textBtnClr)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox({
    required bool value,
    required String label,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(label),
      ],
    );
  }
}
