class UserRole {
  static const client = 'client';
  static const provider = 'provider';
}

class ServiceRequest {
  final String id;
  final String serviceType;
  final String description;
  final DateTime scheduledDate;
  final double? rating;
  final String? review;

  ServiceRequest({
    required this.id,
    required this.serviceType,
    required this.description,
    required this.scheduledDate,
    this.rating,
    this.review,
  });
}

class Message {
  final String sender;
  final String content;
  final DateTime timestamp;

  Message({
    required this.sender,
    required this.content,
    required this.timestamp,
  });
}

class Earnings {
  final double total;
  final double available;

  Earnings({required this.total, required this.available});
}