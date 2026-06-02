import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const BookingScreen({super.key, required this.data});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _persons = 2;
  int _step = 0;
  String _selectedDate = '';
  String _selectedPayment = 'mada';
  bool _confirmed = false;

  final List<String> _dates = ['الجمعة 6 يونيو', 'السبت 7 يونيو', 'الأحد 8 يونيو', 'الاثنين 9 يونيو'];
  final List<Map<String, dynamic>> _payments = [
    {'id': 'mada', 'label': 'مدى', 'icon': Icons.credit_card},
    {'id': 'apple', 'label': 'Apple Pay', 'icon': Icons.apple},
    {'id': 'stc', 'label': 'STC Pay', 'icon': Icons.phone_android},
    {'id': 'tabby', 'label': 'تابي (تقسيط)', 'icon': Icons.calendar_month},
  ];

  double get _total => (double.tryParse(widget.data['price']?.toString() ?? '0') ?? 0) * _persons;

  @override
  Widget build(BuildContext context) {
    if (_confirmed) return _buildConfirmation();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('تأكيد الحجز'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _step == 0 ? _buildStep1() : _step == 1 ? _buildStep2() : _buildStep3(),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: List.generate(3, (i) => Expanded(
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: i <= _step ? AppColors.gold : Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: i <= _step ? AppColors.primary : Colors.white54,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              if (i < 2)
                Expanded(
                  child: Container(
                    height: 2,
                    color: i < _step ? AppColors.gold : Colors.white24,
                  ),
                ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionCard(
          title: 'اختر التاريخ',
          child: Column(
            children: _dates.map((date) => GestureDetector(
              onTap: () => setState(() => _selectedDate = date),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _selectedDate == date ? AppColors.secondary : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _selectedDate == date ? AppColors.secondary : Colors.grey.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today,
                      size: 18,
                      color: _selectedDate == date ? Colors.white : AppColors.textMuted,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      date,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _selectedDate == date ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    if (_selectedDate == date)
                      const Icon(Icons.check_circle, color: Colors.white, size: 18),
                  ],
                ),
              ),
            )).toList(),
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          title: 'عدد الأشخاص',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _counterBtn(Icons.remove, () {
                if (_persons > 1) setState(() => _persons--);
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  '$_persons',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ),
              _counterBtn(Icons.add, () {
                if (_persons < 10) setState(() => _persons++);
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return _buildSectionCard(
      title: 'طريقة الدفع',
      child: Column(
        children: _payments.map((p) => GestureDetector(
          onTap: () => setState(() => _selectedPayment = p['id']),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _selectedPayment == p['id'] ? AppColors.secondary : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _selectedPayment == p['id'] ? AppColors.secondary : Colors.grey.shade200,
              ),
            ),
            child: Row(
              children: [
                Icon(p['icon'] as IconData,
                  color: _selectedPayment == p['id'] ? Colors.white : AppColors.secondary,
                ),
                const SizedBox(width: 12),
                Text(
                  p['label'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _selectedPayment == p['id'] ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                if (_selectedPayment == p['id'])
                  const Icon(Icons.check_circle, color: Colors.white, size: 18),
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildStep3() {
    return Column(
      children: [
        _buildSectionCard(
          title: 'ملخص الحجز',
          child: Column(
            children: [
              _summaryRow('الخدمة', widget.data['title'] ?? ''),
              _summaryRow('المدينة', widget.data['city'] ?? ''),
              _summaryRow('التاريخ', _selectedDate),
              _summaryRow('عدد الأشخاص', '$_persons أشخاص'),
              _summaryRow('طريقة الدفع', _payments.firstWhere((p) => p['id'] == _selectedPayment)['label'] as String),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('الإجمالي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(
                    '${_total.toStringAsFixed(0)} ر.س',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.primary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmation() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 56),
            ),
            const SizedBox(height: 24),
            const Text('تم الحجز بنجاح!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary)),
            const SizedBox(height: 8),
            const Text('سيتواصل معك مزود الخدمة قريباً', style: TextStyle(color: AppColors.textMuted, fontSize: 15)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
              child: const Text('العودة للرئيسية'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _counterBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.secondary),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x1A0A2647), blurRadius: 20, offset: Offset(0, -4))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('الإجمالي:', style: TextStyle(color: AppColors.textMuted)),
              Text(
                '${_total.toStringAsFixed(0)} ر.س',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              if (_step < 2) {
                setState(() => _step++);
              } else {
                setState(() => _confirmed = true);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.primary,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(
              _step == 2 ? 'تأكيد الدفع' : 'التالي',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
