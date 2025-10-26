import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final _serviceController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  double _rating = 0.0;
  final _reviewController = TextEditingController();
  bool _isRealTime = false;

  @override
  void dispose() {
    _serviceController.dispose();
    _descriptionController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submitRequest() {
    // Simulate submission
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Request submitted successfully!')),
    );
    // NOTE: Actual request creation and real-time updates require Supabase database and functions
  }

  void _submitReview() {
    // Simulate review submission
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Review submitted!')),
    );
    // NOTE: Reviews require Supabase for storage and retrieval
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Service Request')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Request Form
                const Text('Request a Service', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextField(
                  controller: _serviceController,
                  decoration: const InputDecoration(labelText: 'Service Type (e.g., Plumbing)'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                SwitchListTile(
                  title: const Text('Real-time Request'),
                  value: _isRealTime,
                  onChanged: (value) => setState(() => _isRealTime = value),
                ),
                if (!_isRealTime) ...[
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: Text(_selectedDate == null ? 'Pick Scheduled Date' : 'Scheduled: ${DateFormat.yMd().format(_selectedDate!)}'),
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitRequest,
                  child: const Text('Book Now'),
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                ),
                const Divider(height: 40),
                // Review Section
                const Text('Leave a Review', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  children: List.generate(5, (index) => IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () => setState(() => _rating = index + 1.0),
                  )),
                ),
                TextField(
                  controller: _reviewController,
                  decoration: const InputDecoration(labelText: 'Review'),
                  maxLines: 2,
                ),
                ElevatedButton(
                  onPressed: _submitReview,
                  child: const Text('Submit Review'),
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