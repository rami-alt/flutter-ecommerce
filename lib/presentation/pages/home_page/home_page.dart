import 'package:flutter/material.dart';
import '../../../domain/repositories/category_repository';
import '../../../domain/entities/category.dart';
import '../../../data/repositories/category_repository_impl.dart';
import '../../../domain/entities/failure.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final CategoryRepository categoryRepository;
  List<Category> categories = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    categoryRepository = CategoryRepositoryImpl(); // Ensure this implements CategoryRepository
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final result = await categoryRepository.getCategories();
    result.fold(
      (failure) => setState(() => Failure(message:"can't fetch categories")),
      (categoryList) => setState(() => categories = categoryList),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.subject, color: Colors.black),
          onPressed: () {},
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 40), // Replace 'assets/logo.png' with your logo's path
            const SizedBox(width: 8),
            Text(
              'PCNC',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/avatar.png'), // Replace 'assets/avatar.png' with your avatar's path
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: categories.isNotEmpty
              ? ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return ListTile(
                      leading: Image.network(category.image, width: 40, height: 40),
                      title: Text(category.name),
                    );
                  },
                )
              : errorMessage.isNotEmpty
                  ? Text(errorMessage)
                  : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
