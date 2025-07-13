import 'package:flutter/material.dart';
import '../../modal/mobile_modal/mobile_modalList.dart';
import '../../resources/color/color.dart';
import '../../resources/company_mobileServices/company_services.dart';
import '../../resources/customDrawer/bottumNavigation.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    // Group categories
    final Set<String> categories = mobileList.map((e) => e.category).toSet();

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Text('Category'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColor.wow2,
      ),
      bottomNavigationBar: BottomNavigation(index: 1),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          final category = categories.elementAt(index);
          final representativeImage = mobileList.firstWhere((m) => m.category == category).image;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CompanyMobilesScreen(
                    brandName: category,
                    mobiles: mobileList.where((m) => m.category == category).toList(),
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.wow3,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(
                        representativeImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      category,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

