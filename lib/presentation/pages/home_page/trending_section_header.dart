import 'package:flutter/material.dart';

class TrendingSectionHeader extends StatelessWidget {
  const TrendingSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xFFF2673A),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Trending Products',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.calendar_month_outlined,
                      color: Colors.white, size: 16.0),
                  Text(
                    'Last Date 29/02/22',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              )
            ],
          ),
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: const BorderSide(color: Colors.white),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'View all',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 16.0,
                  )
                ],
              )),
        ],
      ),
    );
  }
}
