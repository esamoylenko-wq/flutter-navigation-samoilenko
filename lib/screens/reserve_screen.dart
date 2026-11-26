import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import '../models/book.dart';
import '../state/library_state.dart';

class ReserveScreen extends StatefulWidget {
  final String bookId;

  const ReserveScreen({
    super.key,
    required this.bookId,
  });

  @override
  State<ReserveScreen> createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  late DateTime _returnDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _returnDate = DateTime(now.year, now.month, now.day + 14);
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day.$month.${date.year}';
  }

  Future<void> _pickDate() async {
    final picked = await context.push<DateTime>(
      '/select-date',
      extra: _returnDate,
    );
    if (picked != null && mounted) {
      setState(() {
        _returnDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = findBookById(widget.bookId);

    if (book == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Помилка')),
        body: const Center(child: Text('Книгу не знайдено')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Бронювання книги'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.menu_book),
                title: Text(
                  book.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(book.author),
              ),
            ),
            const SizedBox(height: 16),
            Text('Читач: ${libraryState.readerName}'),
            Text('Читацький квиток: ${libraryState.cardNumber}'),
            const Divider(height: 32),
            const Text(
              'Дата повернення книги:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today),
              label: Text('Обрано: ${_formatDate(_returnDate)} (змінити)'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  libraryState.reserveBook(book, _returnDate);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Книгу «${book.title}» заброньовано до ${_formatDate(_returnDate)}!',
                      ),
                    ),
                  );
                  context.go('/my-books');
                },
                icon: const Icon(Icons.bookmark_added),
                label: const Text('Підтвердити бронювання'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}