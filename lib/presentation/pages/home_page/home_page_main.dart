import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/presentation/controllers/login_controller.dart';
import 'package:flutter_application_1/presentation/pages/home_page/logout_drawer.dart';
import 'package:get/get.dart';

import '../../../domain/repositories/category_repository.dart';
import '../../../domain/repositories/product_repository.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/entities/product.dart';
import '../../../data/repositories/category_repository_impl.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../domain/entities/failure.dart';
import 'categories_page.dart';
import 'full_screen.dart';
import 'trending_products_grid.dart';
import 'trending_section_header.dart';

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
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    categoryRepository = CategoryRepositoryImpl();
    productRepository = ProductRepositoryImpl();
    _fetchCategories();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final result = await productRepository.fetchProducts(limit: 4, offset: 1);
    if (mounted) {
      result.fold(
        (failure) => setState(() => Failure(message: "can't fetch products")),
        (productList) => setState(() => products = productList),
      );
    }
  }

  Future<void> _fetchCategories() async {
    final result = await categoryRepository.getCategories();
    if (mounted) {
      result.fold(
        (failure) => setState(() => Failure(message: "can't fetch categories")),
        (categoryList) => setState(() => categories = categoryList),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'pcnc ecommerce',
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.subject,
                color: Colors.black,
              ),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  child: Image.asset(
                    'Images/logocut.png',
                    height: 40,
                  ),
                  borderRadius: BorderRadius.circular(80),
                ),
                const SizedBox(width: 8),
                const Text(
                  'PCNC',
                  style: TextStyle(
                    fontFamily: 'Schyler',
                    color: Color(0xFFF2673B),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: Image.asset('Images/profile.jpg', height: 40),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextField(
                  decoration: InputDecoration(
                    fillColor: Color(0xFFFFFFFF),
                    filled: true,
                    hintText: 'Search any Product..',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'All Categories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      width: 57,
                      height: 24,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.to(
                              () => CategoryGridPage(categories: categories));
                        },
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            side: BorderSide.none),
                        child: const Text(
                          'See All',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1), fontSize: 12),
                        ),
                      ),
                    )
                  ],
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => FullScreenImageScreen(
                                            imageUrl: category.image,
                                          ));
                                    },
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(300),
                                        child: FadeInImage(
                                          height: 56,
                                          width: 56,
                                          fit: BoxFit.cover,
                                          image: NetworkImage(category.image),
                                          placeholder: const AssetImage(
                                              "Images/default.png"),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'Images/default.png',
                                              fit: BoxFit.cover,
                                              height: 56,
                                              width: 56,
                                            );
                                          },
                                        )),
                                  ),
                                  const SizedBox(height: 8),
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
                    : const Center(child: Text("no categories found")),
                products.isNotEmpty
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 8,
                          childAspectRatio: 171 / 241,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return SizedBox(
                            width: 170,
                            height: 241,
                            child: Card(
                              color: const Color(0xffffffff),
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => FullScreenImageScreen(
                                              imageUrl: product.images![0],
                                            ));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: FadeInImage(
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          image:
                                              NetworkImage(product.images![0]),
                                          placeholder: const AssetImage(
                                              "Images/default.png"),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'Images/default.png',
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            );
                                          },
                                        ),
                                      ),
                                    )),
                                    Text(
                                      product.title ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow
                                          .ellipsis, // Prevents text overflow
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      product.description ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow
                                          .ellipsis, // Prevents text overflow
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '\$${product.price?.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'Images/wishlist.png',
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          'Images/save.png',
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.cover,
                                        ),
                                        const Spacer(),
                                        Image.asset(
                                          'Images/cart.png',
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(width: 5),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: Text("No products found")),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TrendingSectionHeader(),
                ),
                const SizedBox(height: 30),
                FeaturedProductsGrid(products: products),
                const SizedBox(height: 30),
              ],
            ),
          ),
          drawer: LogoutDrawer(_scaffoldKey),
          bottomNavigationBar: Container(
            height:
                54, // Increase the height to ensure the circle is not cut off
            child: Stack(
              clipBehavior: Clip.none, // Ensure overflow is visible
              children: [
                BottomNavigationBar(
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.red,
                  selectedLabelStyle: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                  unselectedLabelStyle: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0),
                      fontWeight: FontWeight.w900,
                      fontSize: 12),
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_outlined,
                        size: 24,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.favorite_border,
                        size: 24,
                      ),
                      label: 'Wishlist',
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox.shrink(),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.search,
                        size: 24,
                      ),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.settings_outlined,
                        size: 24,
                      ),
                      label: 'Setting',
                    ),
                  ],
                ),
                Positioned(
                  top:
                      -10, // Adjust this value to control how high above the bar the icon floats
                  left: MediaQuery.of(context).size.width / 2 -
                      30, // Center the icon
                  child: GestureDetector(
                    onTap: () {
                      print('Cart tapped');
                    },
                    child: const Material(
                      elevation: 5,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        radius: 27,
                        backgroundColor: Color(0xFFFFFFFF),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
