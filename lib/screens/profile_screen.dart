import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.gold, width: 2),
                        ),
                        child: const Icon(Icons.person, size: 44, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      const Text('أحمد البحري', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      const Text('+966 5X XXX XXXX', style: TextStyle(fontSize: 13, color: Colors.white70)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildPointsCard(),
                  const SizedBox(height: 16),
                  _buildSettingsCard(),
                  const SizedBox(height: 16),
                  _buildSupportCard(),
                  const SizedBox(height: 24),
                  _buildLogout(context),
                  const SizedBox(height: 32),
                  const Text('بحرنا v1.0.0', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primary, AppColors.secondary]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.stars, color: AppColors.gold, size: 40),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('نقاط الولاء', style: TextStyle(color: Colors.white70, fontSize: 13)),
              Text('250 نقطة', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              Text('عضوية برونزية', style: TextStyle(color: AppColors.gold, fontSize: 12)),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('استبدل', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard() {
    final items = [
      {'icon': Icons.language, 'label': 'اللغة', 'value': 'العربية', 'color': AppColors.secondary},
      {'icon': Icons.dark_mode_outlined, 'label': 'المظهر', 'value': 'فاتح', 'color': const Color(0xFF7C3AED)},
      {'icon': Icons.notifications_outlined, 'label': 'الإشعارات', 'value': 'مفعّل', 'color': AppColors.success},
      {'icon': Icons.credit_card_outlined, 'label': 'طرق الدفع', 'value': '', 'color': AppColors.gold},
    ];
    return _buildCard('الإعدادات', items);
  }

  Widget _buildSupportCard() {
    final items = [
      {'icon': Icons.help_outline, 'label': 'مركز المساعدة', 'value': '', 'color': AppColors.accent},
      {'icon': Icons.security, 'label': 'سياسة الخصوصية', 'value': '', 'color': AppColors.textMuted},
      {'icon': Icons.description_outlined, 'label': 'شروط الاستخدام', 'value': '', 'color': AppColors.textMuted},
    ];
    return _buildCard('الدعم', items);
  }

  Widget _buildCard(String title, List<Map<String, dynamic>> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
            child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textMuted)),
          ),
          ...items.map((item) => ListTile(
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: (item['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 18),
            ),
            title: Text(item['label'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if ((item['value'] as String).isNotEmpty)
                  Text(item['value'] as String, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_back_ios, size: 14, color: AppColors.textMuted),
              ],
            ),
            onTap: () {},
          )),
        ],
      ),
    );
  }

  Widget _buildLogout(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.logout, color: AppColors.error),
      label: const Text('تسجيل الخروج', style: TextStyle(color: AppColors.error)),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        side: const BorderSide(color: AppColors.error),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
