import 'package:flutter/material.dart';
import 'package:society_app/constant/pallete.dart';

class AttachmentSection extends StatelessWidget {
  const AttachmentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                Icon(Icons.attach_file, color: Pallete.textBtnClr),
                Text('Attach file',
                    style: TextStyle(color: Pallete.textBtnClr)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
