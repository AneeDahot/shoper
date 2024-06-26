import 'package:flutter/material.dart';

class YourOrdersWidget extends StatelessWidget {
   YourOrdersWidget({super.key});

  final List<String> imageUrls = [
   'https://fastly.picsum.photos/id/807/2000/2000.jpg?hmac=QF7ItcVSx-ffgZAFjn_pa1Tiwn9LLi1UzMNmX8W6uaQ',
    'https://i.pcmag.com/imagery/reviews/00W0JgzHikgfvGNQaKnk3fU-1.fit_lim.size_120x68.v1701739889.jpg',
    'https://i.pcmag.com/imagery/reviews/02diPul1HrVKpsDR3DGqJUw-1.fit_lim.size_120x68.v1709770971.jpg',
    'https://i.pcmag.com/imagery/reviews/01DwPnq2ew5930qO5p4LXWH-1.fit_lim.size_120x68.v1677608790.jpg',
    'https://i.pcmag.com/imagery/reviews/00W0JgzHikgfvGNQaKnk3fU-1.fit_lim.size_120x68.v1701739889.jpg',
    'https://i.pcmag.com/imagery/reviews/02diPul1HrVKpsDR3DGqJUw-1.fit_lim.size_120x68.v1709770971.jpg',
    'https://i.pcmag.com/imagery/reviews/01DwPnq2ew5930qO5p4LXWH-1.fit_lim.size_120x68.v1677608790.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      // color: Colors.grey.shade200, // Light grey background
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Orders',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                Text(
                  'See All',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Expanded(
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: imageUrls.length,
    itemBuilder: (context, index) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                imageUrls[index],
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 0.4, // Maintain image size
                fit: BoxFit.cover, // Fill the container
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  'laptop',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$200',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  // Add other details as needed
                ],
              ),
            ),
          ],
        ),
      );
    },
  ),
),

        ],
      ),
    );
  }
}
