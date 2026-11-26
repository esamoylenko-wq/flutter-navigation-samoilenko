import 'package:flutter/foundation.dart';
import '../models/book.dart';

class LibraryState extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _readerName = 'Єлизавета Самойленко';
  String _cardNumber = 'ST-2026-041';
  final List<ReservedBook> _reservedBooks = [];

  bool get isLoggedIn => _isLoggedIn;
  String get readerName => _readerName;
  String get cardNumber => _cardNumber;
  List<ReservedBook> get reservedBooks => List.unmodifiable(_reservedBooks);

  void login({String? name, String? card}) {
    if (name != null && name.trim().isNotEmpty) {
      _readerName = name.trim();
    }
    if (card != null && card.trim().isNotEmpty) {
      _cardNumber = card.trim();
    }
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void updateProfile({required String name, required String card}) {
    _readerName = name.trim();
    _cardNumber = card.trim();
    notifyListeners();
  }

  bool isBookReserved(String bookId) {
    return _reservedBooks.any((item) => item.book.id == bookId);
  }

  void reserveBook(Book book, DateTime returnDate) {
    _reservedBooks.removeWhere((item) => item.book.id == book.id);
    _reservedBooks.insert(
      0,
      ReservedBook(book: book, returnDate: returnDate),
    );
    notifyListeners();
  }

  void cancelReservation(String bookId) {
    _reservedBooks.removeWhere((item) => item.book.id == bookId);
    notifyListeners();
  }
}

final LibraryState libraryState = LibraryState();