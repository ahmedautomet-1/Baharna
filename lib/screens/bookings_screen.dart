import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _upcoming = [
    {'title': 'رحلة يخت الغروب', 'city': 'جدة', 'date': 'الجمعة 6 يونيو', 'time': '5:00 م', 'price': '700', 'status': 'مؤكد', 'color': const Color(0xFF1566C0)},
  ];
  final List<Map<String, dynamic>> _completed = [
    {'title': 'غوص في الأعماق', 'city': 'ينبع', 'date': 'الجمعة 23 مايو', 'time': '10:00 ص', 'price': '560', 'status': 'مكتمل', 'color': const Color(0xFF0891B2)},
    {'title': 'صيد العائلة', 'city': 'الخبر', 'date': 'الثلاثاء 20 مايو', 'time': '8:00 ص', 'price': '360', 'status': 'مكتمل', 'color': const Color(0xFF059669)},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('حجوزاتي'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.gold,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(text: 'قادمة'),
            Tab(text: 'مكتملة'),
            Tab(text: 'ملغاة'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList(_upcoming, showActions: true),
          _buildList(_completed),
          _buildEmpty(),
        ],
      ),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> items, {bool showActions = false}) {
    if (items.isEmpty) return _buildEmpty();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (_, i) => _buildBookingCard(items[i], showActions: showActions),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> b, {bool showActions = false}) {
    final color = b['color'] as Color;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                      child: Icon(Icons.sailing, color: color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(b['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary)),
                          Text(b['city']!, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: b['status'] == 'مؤكد' ? AppColors.success.withOpacity(0.1) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        b['status']!,
                        style: TextStyle(
                          color: b['status'] == 'مؤكد' ? AppColors.success : AppColors.textMuted,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(b['date']!, style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),
                    const SizedBox(width: 16),
                    const Icon(Icons.access_time, size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(b['time']!, style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),
                    const Spacer(),
                    Text('${b['price']} ر.س', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.primary)),
                  ],
                ),
                if (showActions) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: const BorderSide(color: AppColors.error),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('إلغاء'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('تتبع', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today_outlined, size: 72, color: AppColors.textMuted.withOpacity(0.4)),
          const SizedBox(height: 16),
          const Text('لا توجد حجوزات', style: TextStyle(color: AppColors.textMuted, fontSize: 16)),
        ],
      ),
    );
  }
}
