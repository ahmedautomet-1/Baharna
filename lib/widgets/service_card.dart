import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ServiceCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;

  const ServiceCard({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color cardColor = data['color'] as Color? ?? AppColors.secondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: cardColor.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [cardColor, cardColor.withOpacity(0.7)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            cardColor.withOpacity(0.6),
                            cardColor,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          _getCategoryIcon(data['category'] ?? ''),
                          size: 64,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['title'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 12, color: Colors.white70),
                              const SizedBox(width: 2),
                              Text(
                                data['city'] ?? '',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.access_time, size: 12, color: Colors.white70),
                              const SizedBox(width: 2),
                              Text(
                                data['duration'] ?? '',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 14, color: AppColors.gold),
                              const SizedBox(width: 2),
                              Text(
                                '${data['rating']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' (${data['reviews']})',
                                style: const TextStyle(color: Colors.white60, fontSize: 12),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.gold,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${data['price']} ر.س',
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
