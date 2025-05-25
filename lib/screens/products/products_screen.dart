import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacoty/widgets/custom.drawer.widget.labo.dart';
import '../../../models/product.dart';
import '../../../widget/SearchAndFilterBar.dart';
import 'product_details_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('produits').get();

    final List<Product> loadedProducts =
        snapshot.docs.map((doc) {
          final data = doc.data();
          factory Product.fromFirestore(DocumentSnapshot doc) {
            final data = doc.data() as Map<String, dynamic>;

            return Product(
              medicineId: BigInt.tryParse(data['medicineId'].toString()) ?? BigInt.zero,
              name: data['name'] ?? '',
              manufacturer: data['manufacturer'] ?? '',
              activeIngredients: data['activeIngredients'] ?? '',
              dosage: data['dosage'] ?? '',
              formulation: data['formulation'] ?? '',
              registrationDate: DateTime.tryParse(data['registrationDate'].toString()) ?? DateTime.now(),
              isActive: data['isActive'] ?? false,
            );
          }
        }).toList();

    setState(() {
      allProducts = loadedProducts;
      filteredProducts = loadedProducts;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredProducts =
          allProducts.where((product) {
            return product.nomProduit.toLowerCase().contains(query) ||
                product.categorie.toLowerCase().contains(query) ||
                product.codeProduit.toLowerCase().contains(query);
          }).toList();
    });
  }

  void _handleFilter() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Fonction Filtrer à implémenter")),
    );
  }

  void _navigateToProductDetails(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text("Produits", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          SearchAndFilterBar(
            searchController: _searchController,
            onFilterPressed: _handleFilter,
          ),
          Expanded(
            child:
                filteredProducts.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.shopping_bag,
                              color: Colors.green,
                            ),
                            title: Text(
                              product.nomProduit,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${product.prixMad} MAD - Qté: ${product.quantite}",
                              style: TextStyle(fontSize: 20),
                            ),
                            trailing: Text(product.codeProduit),
                            onTap: () => _navigateToProductDetails(product),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          // Navigue vers l'écran d'ajout (à créer)
          Navigator.pushNamed(context, '/ajouter-produit');
        },
      ),
    );
  }
}
