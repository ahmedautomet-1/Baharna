import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/service_card.dart';
import '../widgets/category_chip.dart';
import 'service_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.sailing, 'label': 'قوارب', 'color': const Color(0xFF1566C0)},
    {'icon': Icons.scuba_diving, 'label': 'غوص', 'color': const Color(0xFF0891B2)},
    {'icon': Icons.phishing, 'label': 'صيد', 'color': const Color(0xFF059669)},
    {'icon': Icons.beach_access, 'label': 'ألعاب', 'color': const Color(0xFFD97706)},
    {'icon': Icons.tour, 'label': 'جزر', 'color': const Color(0xFF7C3AED)},
    {'icon': Icons.school, 'label': 'تدريب', 'color': const Color(0xFFDC2626)},
  ];

  final List<Map<String, dynamic>> _featured = [
    {
      'title': 'رحلة يخت غروب الشمس',
      'city': 'جدة',
      'price': '350',
      'rating': 4.9,
      'reviews': 128,
      'duration': '3 ساعات',
      'category': 'قوارب',
      'color': const Color(0xFF1566C0),
    },
    {
      'title': 'غوص في الشعاب المرجانية',
      'city': 'ينبع',
      'price': '280',
      'rating': 4.8,
      'reviews': 95,
      'duration': '4 ساعات',
      'category': 'غوص',
      'color': const Color(0xFF0891B2),
    },
    {
      'title': 'رحلة صيد العائلة',
      'city': 'الخبر',
      'price': '200',
      'rating': 4.7,
      'reviews': 67,
      'duration': '5 ساعات',
      'category': 'صيد',
      'color': const Color(0xFF059669),
    },
    {
      'title': 'جزيرة النعيم الخاصة',
      'city': 'الدمام',
      'price': '450',
      'rating': 5.0,
      'reviews': 43,
      'duration': 'يوم كامل',
      'category': 'جزر',
      'color': const Color(0xFF7C3AED),
    },
  ];

  final List<String> _cities = [
    'جدة', 'ينبع', 'الخبر', 'الدمام',
    'أملج', 'جازان', 'الجبيل', 'رأس تنورة', 'الخفجي',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildSearchBar()),
          SliverToBoxAdapter(child: _buildCategories()),
          SliverToBoxAdapter(child: _buildFeaturedSection()),
          SliverToBoxAdapter(child: _buildCitiesSection()),
          const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.secondary],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مرحباً بك 👋',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'اكتشف البحر معنا',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            left: 4,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: AppColors.gold,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.gold, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'جدة، المملكة العربية السعودية',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 13,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.white70),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'ابحث عن نشاط بحري...',
            hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 15),
            prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
            suffixIcon: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.secondary, AppColors.accent],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.tune, color: Colors.white, size: 20),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'الفئات',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _categories.length,
              itemBuilder: (_, i) => CategoryChip(
                icon: _categories[i]['icon'],
                label: _categories[i]['label'],
                color: _categories[i]['color'],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'عروض مميزة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'عرض الكل',
                  style: TextStyle(color: AppColors.secondary, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _featured.length,
            itemBuilder: (_, i) => ServiceCard(
              data: _featured[i],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ServiceDetailScreen(data: _featured[i]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Text(
            'المدن الساحلية',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: _cities.length,
          itemBuilder: (_, i) => GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.secondary.withOpacity(0.1),
                    AppColors.accent.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.accent.withOpacity(0.3),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, size: 14, color: AppColors.secondary),
                    const SizedBox(width: 4),
                    Text(
                      _cities[i],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
