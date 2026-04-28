import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/storage_service.dart';

class Cars extends StatefulWidget {
  const Cars({super.key});

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  final List<Map<String, dynamic>> allCars = [
    {
      'id': 'mercedes_s_class',
      'name': 'Mercedes S-Class',
      'price': 'KSh 18,500,000',
      'year': '2024',
      'type': 'Luxury',
      'image': Icons.directions_car,
      'imageAsset': 'assets/mercedes_s_class.jpg',
    },
    {
      'id': 'bmw_m5',
      'name': 'BMW M5',
      'price': 'KSh 13,500,000',
      'year': '2024',
      'type': 'Sports',
      'image': Icons.directions_car,
      'imageAsset': 'assets/bmw_m5.jpg',
    },
    {
      'id': 'toyota_land_cruiser',
      'name': 'Toyota Land Cruiser',
      'price': 'KSh 8,500,000',
      'year': '2023',
      'type': 'SUV',
      'image': Icons.local_shipping,
      'imageAsset': 'assets/toyota_land_cruiser.jpg',
    },
    {
      'id': 'mercedes_c_class',
      'name': 'Mercedes C-Class',
      'price': 'KSh 7,200,000',
      'year': '2024',
      'type': 'Sedan',
      'image': Icons.directions_car,
      'imageAsset': 'assets/mercedes_c_class.jpg',
    },
    {
      'id': 'porsche_911',
      'name': 'Porsche 911',
      'price': 'KSh 25,000,000',
      'year': '2025',
      'type': 'Sports',
      'image': Icons.speed,
      'imageAsset': 'assets/porsche_911.jpg',
    },
    {
      'id': 'range_rover',
      'name': 'Range Rover',
      'price': 'KSh 18,000,000',
      'year': '2025',
      'type': 'Luxury',
      'image': Icons.local_shipping,
      'imageAsset': 'assets/range_rover.jpg',
    },
  ];

  String selectedFilter = 'All';
  String searchQuery = '';

  List<Map<String, dynamic>> get filteredCars {
    final query = searchQuery.toLowerCase().trim();
    return allCars.where((car) {
      final matchesFilter = selectedFilter == 'All' || car['type'] == selectedFilter;
      final matchesSearch = query.isEmpty ||
          car['name'].toLowerCase().contains(query) ||
          car['type'].toLowerCase().contains(query) ||
          car['year'].toString().contains(query);
      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Browse Cars',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 63, 3, 3),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) => setState(() => searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search cars, type, year...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip('All'),
                _buildFilterChip('SUV'),
                _buildFilterChip('Sports'),
                _buildFilterChip('Luxury'),
                _buildFilterChip('Sedan'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: filteredCars.isEmpty
                ? const Center(
                    child: Text('No cars match your search.', style: TextStyle(color: Colors.grey)),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filteredCars.length,
                    itemBuilder: (context, index) {
                      return _buildCarCard(filteredCars[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) {
          setState(() {
            selectedFilter = label;
          });
        },
        selectedColor: const Color.fromARGB(255, 63, 3, 3),
        backgroundColor: Colors.grey.shade200,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildCarCard(Map<String, dynamic> car) {
    return GestureDetector(
      onTap: () => _showPurchaseDialog(car),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(51),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: car['imageAsset'] != null
                        ? Image.asset(
                            car['imageAsset'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          )
                        : car['imageUrl'] != null
                            ? Image.network(
                                car['imageUrl'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    car['image'],
                                    size: 60,
                                    color: const Color.fromARGB(255, 63, 3, 3),
                                  );
                                },
                              )
                            : Icon(
                                car['image'],
                                size: 60,
                                color: const Color.fromARGB(255, 63, 3, 3),
                              ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${car['year']} • ${car['type']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          car['price'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 63, 3, 3),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 63, 3, 3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPurchaseDialog(Map<String, dynamic> car) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Purchase Car'),
          content: Text('Buy ${car['name']} for ${car['price']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 63, 3, 3),
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _addOrder(car);
    }
  }

  Future<void> _addOrder(Map<String, dynamic> car) async {
    final orders = await StorageService.loadOrders();
    final newOrder = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'car': car['name'],
      'date': DateTime.now().toIso8601String().split('T').first,
      'status': 'Processing',
      'price': car['price'],
      'image': car['image'],
      'imageAsset': car['imageAsset'],
      'imageUrl': car['imageUrl'],
      'type': car['type'],
      'year': car['year'],
    };
    orders.add(newOrder);
    await StorageService.saveOrders(orders);
    Get.snackbar('Success', 'Order created for ${car['name']}', snackPosition: SnackPosition.BOTTOM);
  }
}
