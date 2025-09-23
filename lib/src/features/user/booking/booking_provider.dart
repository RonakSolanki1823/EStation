import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'booking_model.dart';

class BookingProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<Booking> _bookings = [];
  bool _isLoading = false;

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;

  Future<void> fetchBookings() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await supabase
          .from('bookings')
          .select()
          .order('start_time', ascending: false);

      _bookings = data.map((json) => Booking.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching bookings: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addBooking(Booking newBooking) async {
    try {
      await supabase.from('bookings').insert(newBooking.toJson());
    } catch (e) {
      print('Error adding booking: $e');
    }
  }

  void listenToRealtimeChanges() {
    supabase.from('bookings').stream(primaryKey: ['id']).listen((data) {
      _bookings = data.map((json) => Booking.fromJson(json)).toList();
      notifyListeners();
    });
  }

  void initialize() {
    fetchBookings();
    listenToRealtimeChanges();
  }
}