import 'dart:io';
import 'package:flutter/material.dart';
import '/constants/app_colors.dart';
import '/screens/home/add_acount.dart';
import '/constants/app_images.dart';
class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  List<Map<String, dynamic>> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: Stack(
        children: [
          // Main content
          users.isEmpty ? buildEmptyState() : buildGrid(),

          // "Accounts" text at top left
          Positioned(
            top: 24,
            left: 26,
            child: const Text(
              "Accounts",
              style: TextStyle(
                color: AppColors.gold, // Kramee color
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial', // Or any preferred font
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.gold,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContactScreen()),
          );

          if (result != null) {
            setState(() {
              users.add({
                "name": result["name"],
                "email": result["email"],
                "phone": result["phone"],
                "image": result["image"],
              });
            });
          }
        },
        child: const Icon(Icons.add, color: AppColors.darkBlue),
      ),
    );
  }

  Widget buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.adding, width: 200),
          const SizedBox(height: 10),
          const Text(
            "There is No Contacts Added Here",
            style: TextStyle(color: AppColors.gold, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget buildGrid() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 90, 16, 16),
      child: GridView.builder(
        itemCount: users.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 177 / 286,
        ),
        itemBuilder: (context, index) {
          final user = users[index];

          return Center(
            child: Container(
              width: 177,
              height: 286,
              decoration: BoxDecoration(
                color:  AppColors.gold, // الخلفية الكريمية للكارد
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderColor, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.borderColor.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // الصورة + الاسم
                  Container(
                    width: 177,
                    height: 177,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child:
                              user["image"] != null
                                  ? Image.file(
                                    user["image"],
                                    width: 177,
                                    height: 177,
                                    fit: BoxFit.cover,
                                  )
                                  : Image.asset(
                                    AppImages.background,
                                    width: 177,
                                    height: 177,
                                    fit: BoxFit.cover,
                                  ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.deleteIcon.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              user["name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // البيانات تحت الصورة
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.email,
                              size: 14,
                              color: AppColors.darkBlue,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                user["email"],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 11),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 14,
                              color: AppColors.darkBlue,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              user["phone"],
                              style: const TextStyle(fontSize: 11),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: SizedBox(
                            width: 140,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.deleteBg,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  users.removeAt(index);
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 16,
                                color: AppColors.deleteIcon,
                              ),
                              label: const Text(
                                "Delete",
                                style: TextStyle(
                                  color: AppColors.deleteIcon,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
