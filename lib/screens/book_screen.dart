import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import '../models/book.dart';
import '../state/library_state.dart';

class BookScreen extends StatelessWidget {
  final String bookId;

  const BookScreen({
    super.key,
    required this.bookId,
  });

  @override
  Widget build(BuildContext context) {
    final book = findBookById(bookId);

    if (book == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Книгу не знайдено')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Книга з ID "$bookId" відсутня у каталозі.'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.go('/catalog'),
                child: const Text('До каталогу'),
              ),
            ],
          ),
        ),
      );
    }

    return ListenableBuilder(
      listenable: libraryState,
      builder: (context, _) {
        final isReserved = libraryState.isBookReserved(book.id);

        return Scaffold(
          appBar: AppBar(
            title: Text(book.title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(label: Text('${book.genre} • ${book.year} р.')),
                const SizedBox(height: 12),
                Text(
                  book.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Автор: ${book.author}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                ),
                const Divider(height: 32),
                const Text(
                  'Опис книги',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  book.description,
                  style: const TextStyle(fontSize: 15, height: 1.4),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () =>
                        context.push('/catalog/book/${book.id}/reserve'),
                    icon: Icon(
                      isReserved ? Icons.edit_calendar : Icons.bookmark_add,
                    ),
                    label: Text(
                      isReserved
                          ? 'Змінити дату бронювання'
                          : 'Забронювати книгу',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}