import 'package:flutter/material.dart';
import 'filter_model.dart';
import 'mock_data.dart';

class SearchFilterScreen extends StatefulWidget {
  const SearchFilterScreen({super.key});

  @override
  State<SearchFilterScreen> createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends State<SearchFilterScreen> {
  String query = '';
  List<String> filteredResults = allProducts;

  void updateSearch(String value) {
    setState(() {
      query = value;
      filteredResults = allProducts
          .where((product) => product.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void openFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(builder: (context, setStateModal) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Apply Filters', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const Align(alignment: Alignment.centerLeft, child: Text("Category")),
                Wrap(
                  spacing: 8,
                  children: filterCategories.map((filter) {
                    return FilterChip(
                      label: Text(filter.name),
                      selected: filter.isSelected,
                      onSelected: (selected) {
                        setStateModal(() {
                          filter.isSelected = selected;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                const Align(alignment: Alignment.centerLeft, child: Text("Brand")),
                Wrap(
                  spacing: 8,
                  children: brands.map((brand) {
                    return FilterChip(
                      label: Text(brand.name),
                      selected: brand.isSelected,
                      onSelected: (selected) {
                        setStateModal(() {
                          brand.isSelected = selected;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      // Apply filters (simplified logic)
                      filteredResults = allProducts.where((product) {
                        final brandSelected = brands.where((b) => b.isSelected).any((b) => product.contains(b.name));
                        final categorySelected = filterCategories.where((c) => c.isSelected).any((c) => product.contains(c.name));
                        return brandSelected || categorySelected || (brands.every((b) => !b.isSelected) && filterCategories.every((c) => !c.isSelected));
                      }).toList();
                    });
                  },
                  child: const Text("Apply"),
                )
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search & Filters"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: openFilterSheet,
          )
        ],
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: updateSearch,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredResults.isEmpty
                  ? const Center(child: Text("No results found"))
                  : ListView.builder(
                itemCount: filteredResults.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.shopping_bag),
                      title: Text(filteredResults[index]),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
