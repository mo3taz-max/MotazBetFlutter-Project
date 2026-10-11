import 'package:flutter/material.dart';

void main() => runApp(const MotazBetApp());

const gold = Color(0xFFD8B45A);
const bg = Color(0xFF101114);
const panel = Color(0xFF202228);
const walletNumber = '01016989069';

class MotazBetApp extends StatelessWidget {
  const MotazBetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motaz Bet Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: gold,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bg,
          foregroundColor: gold,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class DemoRequest {
  DemoRequest(this.amount, this.sender);
  final String amount;
  final String sender;
  String status = 'قيد المراجعة';
}

class RequestStore {
  static final List<DemoRequest> requests = [];
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MOTAZ BET  •  DEMO')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text('توقعات رياضية', style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('نسخة تجريبية فقط — لا توجد مراهنات أو تحويلات مالية حقيقية.',
              style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 18),
          const MatchCard(title: 'كرة القدم', teams: 'فريق النسر  •  فريق الصقور', result: 'توقع تجريبي: 2 - 1'),
          const MatchCard(title: 'كرة القدم', teams: 'فريق المدينة  •  فريق الساحل', result: 'توقع تجريبي: 1 - 1'),
          const SizedBox(height: 12),
          GoldButton(label: 'المحفظة التجريبية', onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const DepositPage()));
          }),
          const SizedBox(height: 8),
          OutlinedButton(
            style: OutlinedButton.styleFrom(foregroundColor: gold),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminPage())),
            child: const Text('لوحة المسؤول التجريبية'),
          ),
        ],
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  const MatchCard({super.key, required this.title, required this.teams, required this.result});
  final String title, teams, result;

  @override
  Widget build(BuildContext context) => Card(
    color: panel,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: gold)),
        const SizedBox(height: 6),
        Text(teams, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        Text(result, style: const TextStyle(color: Colors.white70)),
      ]),
    ),
  );
}

class GoldButton extends StatelessWidget {
  const GoldButton({super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => FilledButton(
    style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: bg, padding: const EdgeInsets.all(14)),
    onPressed: onPressed,
    child: Text(label),
  );
}

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});
  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final amount = TextEditingController();
  final sender = TextEditingController();

  @override
  void dispose() {
    amount.dispose();
    sender.dispose();
    super.dispose();
  }

  void submit() {
    if (amount.text.trim().isEmpty || sender.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('أدخل بيانات تجريبية لإكمال النموذج')));
      return;
    }
    RequestStore.requests.add(DemoRequest(amount.text.trim(), sender.text.trim()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم حفظ الطلب في النسخة التجريبية فقط')));
    amount.clear();
    sender.clear();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('طلب إيداع تجريبي')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const Text('لا ترسل أموالًا حقيقية. هذا نموذج واجهة فقط.', style: TextStyle(color: Colors.white70)),
      const SizedBox(height: 18),
      const Text('رقم المحفظة المعروض', style: TextStyle(color: gold)),
      SelectableText(walletNumber, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 18),
      const Text('المبلغ التجريبي'),
      const SizedBox(height: 6),
      TextField(controller: amount, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: 'مثال: 100', filled: true, fillColor: panel, border: OutlineInputBorder())),
      const SizedBox(height: 14),
      const Text('رقم المُرسِل (بيانات تجريبية فقط)'),
      const SizedBox(height: 6),
      TextField(controller: sender, keyboardType: TextInputType.phone, decoration: const InputDecoration(hintText: '01xxxxxxxxx', filled: true, fillColor: panel, border: OutlineInputBorder())),
      const SizedBox(height: 14),
      const Card(color: panel, child: Padding(padding: EdgeInsets.all(14), child: Text('رفع الصور والتحقق من التحويل غير مفعّلين في هذه النسخة. لا تستخدم بيانات أو إثباتات مالية حقيقية.', style: TextStyle(color: Colors.white70)))),
      const SizedBox(height: 12),
      GoldButton(label: 'إرسال طلب تجريبي', onPressed: submit),
    ]),
  );
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('لوحة المسؤول التجريبية')),
    body: RequestStore.requests.isEmpty
      ? const Center(child: Text('لا توجد طلبات تجريبية في هذه الجلسة.'))
      : ListView.builder(
          padding: const EdgeInsets.all(14),
          itemCount: RequestStore.requests.length,
          itemBuilder: (context, i) {
            final req = RequestStore.requests[i];
            return Card(
              color: panel,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('طلب تجريبي ${i + 1}', style: const TextStyle(color: gold, fontWeight: FontWeight.bold)),
                  Text('المبلغ: ${req.amount}'),
                  Text('رقم المُدخل: ${req.sender}'),
                  Text('الحالة: ${req.status}'),
                  const SizedBox(height: 8),
                  Wrap(spacing: 8, children: [
                    TextButton(onPressed: () => setState(() => req.status = 'مقبول تجريبيًا'), child: const Text('قبول تجريبي')),
                    TextButton(onPressed: () => setState(() => req.status = 'مرفوض تجريبيًا'), child: const Text('رفض تجريبي')),
                  ]),
                ]),
              ),
            );
          },
        ),
  );
}