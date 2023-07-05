import 'package:cities_and_streets/screen/street_screen.dart';
import 'package:flutter/material.dart';

class CityWidgetInfo extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  final String dateTimeImage;
  final int totalPeople;
  final double lat;
  final double long;

  const CityWidgetInfo(
      {super.key,
      required this.id,
      required this.name,
      required this.image,
      required this.dateTimeImage,
      required this.totalPeople,
      required this.lat,
      required this.long});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 328),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEAECF0), width: 1),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StreetScreen(
                cityId: id,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    Container(color: const Color(0xFFEAECF0), constraints: const BoxConstraints(maxHeight: 220),),
                    Image.network(image),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              Text(
                '$totalPeople человек',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Широта $lat°',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              Text(
                'Долгота $long°',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Фото сделано $dateTimeImage',
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF667085)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
