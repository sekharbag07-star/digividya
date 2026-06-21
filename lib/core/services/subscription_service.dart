import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserData(
    String userId,
  ) async {
    final doc = await _firestore.collection('users').doc(userId).get();

    if (!doc.exists) return null;

    return doc;
  }

  Future<bool> isSubscriptionExpired(String userId) async {
    final doc = await getUserData(userId);

    if (doc == null) return true;

    final data = doc.data()!;

    final bool subscriptionActive = data['subscriptionActive'] ?? false;

    if (!subscriptionActive) return true;

    final Timestamp? endDate = data['subscriptionEndDate'];

    if (endDate == null) return true;

    return DateTime.now().isAfter(endDate.toDate());
  }

  Future<bool> isTrialExpired(String userId) async {
    final doc = await getUserData(userId);

    if (doc == null) return true;

    final data = doc.data()!;

    final bool trialActive = data['trialActive'] ?? false;

    if (!trialActive) return false;

    final Timestamp? trialEndDate = data['trialEndDate'];

    if (trialEndDate == null) return true;

    return DateTime.now().isAfter(trialEndDate.toDate());
  }

  Future<void> expireSubscription(String userId) async {
    await _firestore.collection('users').doc(userId).update({
      'subscriptionActive': false,
      'paymentStatus': 'expired',
    });
  }

  Future<void> expireTrial(String userId) async {
    await _firestore.collection('users').doc(userId).update({
      'trialActive': false,
    });
  }

  Future<void> activateSubscription({
    required String userId,
    required String transactionId,
    int durationDays = 30,
    String plan = 'monthly',
  }) async {
    final now = DateTime.now();

    await _firestore.collection('users').doc(userId).update({
      'trialActive': false,

      'subscriptionActive': true,

      'paymentStatus': 'paid',

      'transactionId': transactionId,

      'subscriptionPlan': plan,

      'lastPaymentDate': Timestamp.fromDate(now),

      'subscriptionStartDate': Timestamp.fromDate(now),

      'subscriptionEndDate': Timestamp.fromDate(
        now.add(Duration(days: durationDays)),
      ),
    });
  }
}
