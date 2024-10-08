import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

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
    _loadSearchHistory(); 
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
      _saveSearchHistory();
    });
  }

  // Clear all search history
  _clearSearchHistory() {
    setState(() {
      _searchHistory.clear();
      _saveSearchHistory();
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
          autofocus: true, 
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          onSubmitted: (query) {
            setState(() {
              _searchQuery = query;
              if (query.isNotEmpty && !_searchHistory.contains(query)) {
                _searchHistory.add(query);
                _saveSearchHistory();
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
          ? _buildSearchHistory()
          : searchResults.isEmpty
              ? Center(child: Text('No products found.'))
              : _buildSearchResults(searchResults),
      floatingActionButton: _searchHistory.isNotEmpty
          ? FloatingActionButton(
              child: Icon(Icons.delete_sweep), 
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


  Widget _buildSearchHistory() {
    return ListView(
      children: _searchHistory.map((historyItem) {
        return ListTile(
          title: Text(historyItem),
          trailing: IconButton(
            icon: Icon(Icons.delete), 
            onPressed: () {
              _removeFromSearchHistory(historyItem);  
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
