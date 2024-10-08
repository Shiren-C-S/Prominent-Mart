import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart'; // Ensure to import your product provider

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _searchHistory = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadSearchHistory(); // Load search history from SharedPreferences
  }

  // Load search history from SharedPreferences
  _loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory = prefs.getStringList('searchHistory') ?? [];
    });
  }

  // Save search history to SharedPreferences
  _saveSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('searchHistory', _searchHistory);
  }

  // Remove individual search history item
  _removeFromSearchHistory(String item) {
    setState(() {
      _searchHistory.remove(item);
      _saveSearchHistory(); // Update local storage after removal
    });
  }

  // Clear all search history
  _clearSearchHistory() {
    setState(() {
      _searchHistory.clear();
      _saveSearchHistory(); // Update local storage after clearing history
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final searchResults = productProvider.products
        .where((product) =>
            product.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true, // Set autofocus so the cursor is visible and blinking
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          onSubmitted: (query) {
            setState(() {
              _searchQuery = query;
              if (query.isNotEmpty && !_searchHistory.contains(query)) {
                _searchHistory.add(query); // Add new search term to history
                _saveSearchHistory(); // Save updated history
              }
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _searchController.clear();
                _searchQuery = "";
              });
            },
          ),
        ],
      ),
      body: _searchQuery.isEmpty
          ? _buildSearchHistory() // Show search history if no query is entered
          : searchResults.isEmpty
              ? Center(child: Text('No products found.'))
              : _buildSearchResults(searchResults),
      floatingActionButton: _searchHistory.isNotEmpty
          ? FloatingActionButton(
              child: Icon(Icons.delete_sweep),  // Clear all search history
              onPressed: () {
                _clearSearchHistory();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Search history cleared!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              tooltip: 'Clear all search history',
            )
          : null,
    );
  }

  // Build search results based on the query
  Widget _buildSearchResults(List searchResults) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (ctx, i) {
        final product = searchResults[i];
        return ListTile(
          leading: Image.asset(product.imageAsset, width: 50, fit: BoxFit.cover),
          title: Text(product.title),
          subtitle: Text('\$${product.price}'),
          onTap: () {
            Navigator.of(context).pushNamed('/product-details', arguments: product.id); // Navigate to product details
          },
        );
      },
    );
  }

  // Build search history with delete options for each item
  Widget _buildSearchHistory() {
    return ListView(
      children: _searchHistory.map((historyItem) {
        return ListTile(
          title: Text(historyItem),
          trailing: IconButton(
            icon: Icon(Icons.delete), // Delete icon for individual items
            onPressed: () {
              _removeFromSearchHistory(historyItem);  // Remove selected item
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$historyItem removed from search history'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          onTap: () {
            setState(() {
              _searchQuery = historyItem;
              _searchController.text = historyItem;
            });
          },
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
