import 'package:flutter/material.dart';
import '/constants/app_colors.dart';
import '/constants/app_images.dart';
import '/screens/home/add_acount.dart';
import '/screens/splash/splash_screen.dart';
import '/widgets/contact_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> contacts = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage(AppImages.adding), context);
  }

  void _addContact(Map<String, dynamic> contact) {
    setState(() {
      contacts.add(contact);
    });
  }

  void _deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Contacts',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: contacts.isEmpty ? _buildEmptyState() : _buildContactsList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.gold,
        onPressed: () async {
          final newContact = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContactScreen()),
          );
          if (newContact != null) {
            _addContact(newContact);
          }
        },
        child: const Icon(Icons.add, color: AppColors.darkBlue, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RepaintBoundary(
            child: Image.asset(
              AppImages.adding,
              width: 300,
              fit: BoxFit.contain,
              gaplessPlayback: true,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "No Contacts Yet",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Tap + to add your first contact",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.gold, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: GridView.builder(
        itemCount: contacts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 177 / 286,
        ),
        itemBuilder: (context, index) {
          return ContactCard(
            user: contacts[index],
            onDelete: () => _deleteContact(index),
          );
        },
      ),
    );
  }
}
