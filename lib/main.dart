import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String productType;

  ProductCard({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.productType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to product details screen when the card is tapped
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              title: title,
              imageUrl: imageUrl,
              price: price,
              productType: productType,
            ),
          ),
        );
      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '\$$price',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Category: $productType',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // Add to cart logic here
                    },
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String productType;

  ProductDetails({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.productType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '\$$price',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Category: $productType',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add to cart logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added to Cart!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  String selectedCategory = "All"; // Default category filter
  TextEditingController searchController =
      TextEditingController(); // Controller for search bar

  final List<Map<String, dynamic>> products = [
    {
      'title': 'Maths',
      'imageUrl':
          'https://t3.ftcdn.net/jpg/01/33/21/60/240_F_133216088_Za1Z6sMjrAgGqKnHIj3EaghzA0hUHTYg.jpg',
      'price': 19.99,
      'productType': 'Marwari',
    },
    {
      'title': 'Me',
      'imageUrl': 'https://a-z-animals.com/media/sheep-1.jpg',
      'price': 29.99,
      'productType': 'Deccani',
      'details': 'wdwdwdwdwdwwd'
    },
    {
      'title': 'KT',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTA5AINpaJGj5C_sJ9WdqupFfji8JWdQuMtow&usqp=CAU',
      'price': 29.99,
      'productType': 'Deccani',
    },
    {
      'title': 'Lagegi',
      'imageUrl':
          'https://t3.ftcdn.net/jpg/01/33/21/60/240_F_133216088_Za1Z6sMjrAgGqKnHIj3EaghzA0hUHTYg.jpg',
      'price': 29.99,
      'productType': 'Deccani',
    },
    {
      'title': 'Product 5',
      'imageUrl':
          'https://t3.ftcdn.net/jpg/01/33/21/60/240_F_133216088_Za1Z6sMjrAgGqKnHIj3EaghzA0hUHTYg.jpg',
      'price': 29.99,
      'productType': 'Deccani',
    },
    // Add more products here
  ];

  List<Map<String, dynamic>> filteredProducts() {
    if (selectedCategory == "All") {
      return products;
    } else {
      return products
          .where((product) => product['productType'] == selectedCategory)
          .toList();
    }
  }

  List<Map<String, dynamic>> searchedProducts(String query) {
    if (query.isEmpty) {
      return filteredProducts();
    } else {
      return filteredProducts()
          .where((product) =>
              product['title'].toLowerCase().contains(query.toLowerCase()) ||
              product['productType']
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  void dispose() {
    searchController.dispose(); // Dispose of the search controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced Pawn/प्रगत अश्लील'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by product name or category',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: ["All", "Marwari", "Deccani"]
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600
                        ? 4
                        : 2, // Adjust columns based on screen size
                    childAspectRatio: 0.7, // Adjust the aspect ratio as needed
                  ),
                  itemCount: searchedProducts(searchController.text).length,
                  itemBuilder: (BuildContext context, int index) {
                    final product =
                        searchedProducts(searchController.text)[index];
                    return ProductCard(
                      title: product['title'],
                      imageUrl: product['imageUrl'],
                      price: product['price'],
                      productType: product['productType'],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
