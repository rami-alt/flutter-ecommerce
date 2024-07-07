import 'package:flutter/material.dart';

import '../../../domain/repositories/category_repository.dart';
import '../../../domain/repositories/product_repository.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/entities/product.dart';
import '../../../data/repositories/category_repository_impl.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../domain/entities/failure.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final CategoryRepository categoryRepository;
  List<Category> categories = [];  
  late final ProductRepository productRepository;
  List<Product> products = [];
  String errorMessage = '';


  @override
  void initState() {
    super.initState();
    categoryRepository = CategoryRepositoryImpl(); 
    productRepository= ProductRepositoryImpl();
    _fetchCategories();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final result = await productRepository.fetchProducts(limit: 10, offset:1);
    result.fold(
      (failure) => setState(() =>{ Failure(message:"can't fetch products"),
      print(failure.message)}),
      (productList) => setState(() => products = productList),
    );
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
          icon: const Icon(Icons.subject, color: Colors.black),
          onPressed: () {},
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('Images/logocut.png', height: 40), 
            const SizedBox(width: 8),
            const Text(
              'PCNC',
              style: TextStyle(
                fontFamily: 'Schyler',
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
            child: ClipRRect (
              borderRadius: BorderRadius.circular(300),
              child: Image.asset('Images/profile.jpg', height: 40), 
            ),
          ),
        ],
      ),
body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'All Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              categories.isNotEmpty
                  ? SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(300),
                                  child:
                                FadeInImage(
                                   height: 56,
                                  width: 56,
                                  fit: BoxFit.cover,
                                  image:NetworkImage(category.image),
                                  placeholder: const AssetImage("Images/default.png"),
                                  imageErrorBuilder:(context, error, stackTrace) {
                                    return Image.asset('Images/default.png',
                                        fit: BoxFit.cover,
                                        height: 56,
                                        width: 56,
                                    );
                                           },
                                    )),const SizedBox(height: 8),
                                Text(
                                  category.name,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text("no categories found")
                    ),
            const Text(
                  'All Products',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                products.isNotEmpty
                    ? GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 171 / 241,
                      ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Card(
                            elevation: 4,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: FadeInImage(
                                    height: 124,
                                    width: 170,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(product.images![0]),
                                    placeholder: const AssetImage("Images/default.png"),
                                    imageErrorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'Images/default.png',
                                        fit: BoxFit.cover,
                                        height: 124,
                                        width: 170,
                                      );
                                    },
                                  ),
                                ),
                                Text(
                                  product.title??"",
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '\$${product.price?.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : const Center(child: Text("No products found")),
              ],
            ),
          ),
        ),
      );
  }
}