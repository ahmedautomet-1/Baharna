import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'booking_screen.dart';

class ServiceDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const ServiceDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Color cardColor = data['color'] as Color? ?? AppColors.secondary;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: cardColor,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [cardColor, cardColor.withOpacity(0.6)],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Icon(
                        _getCategoryIcon(data['category'] ?? ''),
                        size: 100,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: cardColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          data['category'] ?? '',
                          style: TextStyle(color: cardColor, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, size: 18, color: AppColors.gold),
                      const SizedBox(width: 4),
                      Text(
                        '${data['rating']} (${data['reviews']} تقييم)',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    data['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: AppColors.secondary),
                      const SizedBox(width: 4),
                      Text(
                        data['city'] ?? '',
                        style: const TextStyle(color: AppColors.secondary, fontSize: 14),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.access_time, size: 16, color: AppColors.textMuted),
                      const SizedBox(width: 4),
                      Text(
                        data['duration'] ?? '',
                        style: const TextStyle(color: AppColors.textMuted, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildInfoCards(),
                  const SizedBox(height: 20),
                  _buildDescription(),
                  const SizedBox(height: 20),
                  _buildProviderCard(cardColor),
                  const SizedBox(height: 20),
                  _buildIncludes(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Color(0x1A0A2647), blurRadius: 20, offset: Offset(0, -4)),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('السعر للشخص', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                Text(
                  '${data['price']} ر.س',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BookingScreen(data: data)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(
                  'احجز الآن',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCards() {
    return Row(
      children: [
        _infoCard(Icons.people_outline, '10 أشخاص', 'الحد الأقصى'),
        const SizedBox(width: 12),
        _infoCard(Icons.verified_user_outlined, 'موثّق', 'المزود'),
        const SizedBox(width: 12),
        _infoCard(Icons.security, 'مؤمّن', 'الرحلة'),
      ],
    );
  }

  Widget _infoCard(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.secondary, size: 22),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primary)),
            Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('وصف الرحلة', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        Text(
          'استمتع بتجربة بحرية لا تُنسى في ${data['city']} مع أفضل مزودي الخدمات المعتمدين. رحلة آمنة وممتعة مع معدات متكاملة وطاقم محترف.',
          style: const TextStyle(color: AppColors.textMuted, fontSize: 14, height: 1.7),
        ),
      ],
    );
  }

  Widget _buildProviderCard(Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('مركز بحرنا البحري', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary)),
              Row(
                children: [
                  const Icon(Icons.star, size: 14, color: AppColors.gold),
                  const Text(' 4.9 ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const Text('• موثّق رسمياً', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('تواصل', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildIncludes() {
    final includes = ['معدات السلامة الكاملة', 'دليل بحري محترف', 'تأمين شامل', 'مشروبات ومرطبات'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('ما يشمله السعر', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 10),
        ...includes.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.success, size: 18),
              const SizedBox(width: 8),
              Text(item, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
            ],
          ),
        )),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'قوارب': return Icons.sailing;
      case 'غوص': return Icons.scuba_diving;
      case 'صيد': return Icons.phishing;
      case 'ألعاب': return Icons.beach_access;
      case 'جزر': return Icons.tour;
      case 'تدريب': return Icons.school;
      default: return Icons.water;
    }
  }
}
