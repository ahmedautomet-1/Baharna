import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/service_card.dart';
import 'service_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _selectedCity = 'الكل';
  String _selectedCategory = 'الكل';

  final List<String> _cities = ['الكل', 'جدة', 'ينبع', 'الخبر', 'الدمام', 'أملج'];
  final List<String> _categories = ['الكل', 'قوارب', 'غوص', 'صيد', 'ألعاب', 'جزر'];

  final List<Map<String, dynamic>> _services = [
    {'title': 'يخت خاص في الغروب', 'city': 'جدة', 'price': '500', 'rating': 4.9, 'reviews': 88, 'duration': '3 ساعات', 'category': 'قوارب', 'color': const Color(0xFF1566C0)},
    {'title': 'غوص في الأعماق', 'city': 'ينبع', 'price': '320', 'rating': 4.8, 'reviews': 72, 'duration': '4 ساعات', 'category': 'غوص', 'color': const Color(0xFF0891B2)},
    {'title': 'صيد السمك مع الأسرة', 'city': 'الخبر', 'price': '180', 'rating': 4.6, 'reviews': 54, 'duration': '5 ساعات', 'category': 'صيد', 'color': const Color(0xFF059669)},
    {'title': 'ألعاب مائية مثيرة', 'city': 'الدمام', 'price': '150', 'rating': 4.5, 'reviews': 39, 'duration': '2 ساعات', 'category': 'ألعاب', 'color': const Color(0xFFD97706)},
    {'title': 'رحلة جزيرة استوائية', 'city': 'أملج', 'price': '600', 'rating': 5.0, 'reviews': 27, 'duration': 'يوم كامل', 'category': 'جزر', 'color': const Color(0xFF7C3AED)},
    {'title': 'دورة غوص للمبتدئين', 'city': 'جدة', 'price': '400', 'rating': 4.7, 'reviews': 61, 'duration': '6 ساعات', 'category': 'تدريب', 'color': const Color(0xFFDC2626)},
  ];

  List<Map<String, dynamic>> get _filtered => _services.where((s) {
    final cityOk = _selectedCity == 'الكل' || s['city'] == _selectedCity;
    final catOk = _selectedCategory == 'الكل' || s['category'] == _selectedCategory;
    return cityOk && catOk;
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('استكشاف'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.map_outlined), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: _filtered.isEmpty
              ? const Center(child: Text('لا توجد نتائج'))
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: _filtered.length,
                  itemBuilder: (_, i) => ServiceCard(
                    data: _filtered[i],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ServiceDetailScreen(data: _filtered[i])),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          _filterRow('المدينة', _cities, _selectedCity, (v) => setState(() => _selectedCity = v)),
          const SizedBox(height: 8),
          _filterRow('النوع', _categories, _selectedCategory, (v) => setState(() => _selectedCategory = v)),
        ],
      ),
    );
  }

  Widget _filterRow(String label, List<String> items, String selected, ValueChanged<String> onChanged) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: items.map((item) => GestureDetector(
          onTap: () => onChanged(item),
          child: Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: selected == item ? AppColors.secondary : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected == item ? AppColors.secondary : Colors.grey.shade300,
              ),
            ),
            child: Text(
              item,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: selected == item ? Colors.white : AppColors.textMuted,
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }
}
