import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:giftappgp/View/Shared/datebar.dart';
import 'package:giftappgp/utils/AppColors.dart';

class appbar extends StatelessWidget {
  late Function fun;
  appbar({required this.fun});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: DateTime.now().hour < 12
                          ? const Text(
                              'Good Morning',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          : const Text(
                              'Good Afternoon',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                    InkWell(
                      onTap: () {
                        fun();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                datebar(),
                Row(
                  children: [Icon(Icons.add_circle_outline_sharp)],
                )
              ],
            ))
      ],
    );
  }
}

Widget _widget(
        {required IconData icon, required title, required Function() fun}) =>
    InkWell(
      onTap: fun,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(icon),
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
