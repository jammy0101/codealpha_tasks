import 'package:flutter/material.dart';
import '../../modal/mobile_modal/mobil_modal.dart';
import '../../resources/color/color.dart';

class CompanyMobilesScreen extends StatelessWidget {
  final String brandName;
  final List<MobileModel> mobiles;

  const CompanyMobilesScreen({
    super.key,
    required this.brandName,
    required this.mobiles,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Text(brandName),
        backgroundColor: AppColor.wow2,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: mobiles.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, i) {
          final mobile = mobiles[i];
          return Container(
            decoration: BoxDecoration(
              color: AppColor.wow3,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      mobile.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    mobile.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
