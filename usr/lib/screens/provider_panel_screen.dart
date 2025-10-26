import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ProviderPanelScreen extends StatefulWidget {
  const ProviderPanelScreen({super.key});

  @override
  State<ProviderPanelScreen> createState() => _ProviderPanelScreenState();
}

class _ProviderPanelScreenState extends State<ProviderPanelScreen> {
  final List<ServiceRequest> _requests = [
    // Mock requests
    ServiceRequest(
      id: '1',
      serviceType: 'Plumbing',
      description: 'Fix leaky faucet',
      scheduledDate: DateTime.now().add(const Duration(days: 2)),
    ),
  ];
  final Earnings _earnings = Earnings(total: 150000, available: 120000); // Mock in UGX

  void _respondToRequest(String id) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Response sent!')),
    );
    // NOTE: Actual responses require Supabase database updates
  }

  void _withdrawMoney() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Withdrawal requested via MTN/Airtel!')),
    );
    // NOTE: Payments and withdrawals require Supabase integration with mobile money APIs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Panel')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Requests Section
                const Text('Service Requests', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _requests.length,
                  itemBuilder: (context, index) {
                    final req = _requests[index];
                    return Card(
                      child: ListTile(
                        title: Text(req.serviceType),
                        subtitle: Text('${req.description}\nScheduled: ${req.scheduledDate}'),
                        trailing: ElevatedButton(
                          onPressed: () => _respondToRequest(req.id),
                          child: const Text('Respond'),
                        ),
                      ),
                    );
                  },
                ),
                const Divider(height: 40),
                // Earnings Section
                const Text('Earnings Tracker', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Total Earnings: UGX ${_earnings.total}'),
                Text('Available for Withdrawal: UGX ${_earnings.available}'),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  hint: const Text('Select Mobile Money'),
                  items: const [
                    DropdownMenuItem(value: 'MTN', child: Text('MTN Mobile Money')),
                    DropdownMenuItem(value: 'Airtel', child: Text('Airtel Money')),
                  ],
                  onChanged: (value) {},
                ),
                ElevatedButton(
                  onPressed: _withdrawMoney,
                  child: const Text('Withdraw Money'),
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}