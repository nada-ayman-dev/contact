import 'dart:io';
import 'package:flutter/material.dart';
import '/constants/app_colors.dart';
import '/screens/home/add_acount.dart';

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
      body: users.isEmpty ? buildEmptyState() : buildGrid(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.gold,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddContactScreen(),
            ),
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
          Image.asset("assets/images/adding.gif", width: 200),
          const SizedBox(height: 20),
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
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: users.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          final user = users[index];

          return Container(
            width: 177,
            height: 286,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1D4), // الخلفية الكريمية للكارد
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
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
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: user["image"] != null
                            ? Image.file(user["image"], width: 177, height: 177, fit: BoxFit.cover)
                            : Image.asset("assets/images/background_image.gif", width: 177, height: 177, fit: BoxFit.cover),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            user["name"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // البيانات تحت الصورة
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.email, size: 16),
                          const SizedBox(width: 5),
                          Expanded(child: Text(user["email"], overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 16),
                          const SizedBox(width: 5),
                          Text(user["phone"]),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () {
                            setState(() {
                              users.removeAt(index);
                            });
                          },
                          child: const Text("Delete"),
                        ),
                      ),
                    ],
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