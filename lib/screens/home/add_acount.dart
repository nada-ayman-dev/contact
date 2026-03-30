import 'package:flutter/material.dart';
import '/constants/app_colors.dart';
import '/constants/app_images.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  /// 🔥 اختيار صورة
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// 🔹 الكارد الكبير
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    /// صورة + بيانات
                    Row(
                      children: [
                        /// 🔥 صورة قابلة للضغط
                        GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.gold),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child:
                                  selectedImage != null
                                      ? Image.file(
                                        selectedImage!,
                                        fit: BoxFit.cover,
                                      )
                                      : Image.asset(
                                        AppImages.background,
                                        fit: BoxFit.cover,
                                      ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        /// 🔥 البيانات (Live)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nameController.text.isEmpty
                                    ? "User Name"
                                    : nameController.text,
                                style: const TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                emailController.text.isEmpty
                                    ? "example@email.com"
                                    : emailController.text,
                                style: const TextStyle(color: AppColors.gold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                phoneController.text.isEmpty
                                    ? "+200000000000"
                                    : phoneController.text,
                                style: const TextStyle(color: AppColors.gold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// 🔹 TextFields
              buildTextField("Enter User Name", nameController),
              const SizedBox(height: 15),

              buildTextField("Enter User Email", emailController),
              const SizedBox(height: 15),

              buildTextField("Enter User Phone", phoneController),
              const SizedBox(height: 25),

              /// 🔹 زرار
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, {
                      "name": nameController.text,
                      "email": emailController.text,
                      "phone": phoneController.text,
                      "image": selectedImage,
                    });
                  },
                  child: const Text(
                    "Enter user",
                    style: TextStyle(color: AppColors.darkBlue, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 TextField
  Widget buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        setState(() {}); // 🔥 تحديث الكارد لايف
      },
      style: const TextStyle(color: AppColors.gold),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.hintText),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.gold),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.gold, width: 2),
        ),
      ),
    );
  }
}
