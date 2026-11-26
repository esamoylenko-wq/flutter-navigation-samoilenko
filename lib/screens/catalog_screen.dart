import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import '../models/book.dart';

class CatalogScreen extends StatelessWidget {
  final String? selectedGenre;

  const CatalogScreen({
    super.key,
    this.selectedGenre,
  });

  @override
  Widget build(BuildContext context) {
    final activeGenre =
        (selectedGenre != null && kBookGenres.contains(selectedGenre))
            ? selectedGenre!
            : 'Усі';

    final filteredBooks = activeGenre == 'Усі'
        ? kLibraryBooks
        : kLibraryBooks.where((book) => book.genre == activeGenre).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог бібліотеки'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: kBookGenres.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final genre = kBookGenres[index];
                final isSelected = genre == activeGenre;
                return FilterChip(
                  label: Text(genre),
                  selected: isSelected,
                  onSelected: (_) {
                    if (genre == 'Усі') {
                      context.go('/catalog');
                    } else {
                      context.go('/catalog?genre=${Uri.encodeComponent(genre)}');
                    }
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(book.id),
                    ),
                    title: Text(
                      book.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('${book.author} • ${book.genre} (${book.year})'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go('/catalog/book/${book.id}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}