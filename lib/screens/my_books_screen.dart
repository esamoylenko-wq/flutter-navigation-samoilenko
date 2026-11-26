import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import '../state/library_state.dart';

class MyBooksScreen extends StatelessWidget {
  const MyBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: libraryState,
      builder: (context, _) {
        final items = libraryState.reservedBooks;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Мої книги'),
          ),
          body: items.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'У вас ще немає заброньованих книг',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => context.go('/catalog'),
                        child: const Text('Перейти до каталогу'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: const Icon(Icons.bookmark),
                        title: Text(
                          item.book.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          '${item.book.author}\nПовернути до: ${item.formattedReturnDate}',
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Скасувати бронювання',
                          onPressed: () =>
                              libraryState.cancelReservation(item.book.id),
                        ),
                        onTap: () =>
                            context.go('/catalog/book/${item.book.id}'),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}