import 'package:material_ui/material_ui.dart';
import '../state/library_state.dart';

class LoginScreen extends StatefulWidget {
  final String? redirectTo;

  const LoginScreen({
    super.key,
    this.redirectTo,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _cardController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: libraryState.readerName);
    _cardController = TextEditingController(text: libraryState.cardNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вхід до бібліотеки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Для бронювання книг увійдіть за номером читацького квитка.',
              style: TextStyle(fontSize: 15),
            ),
            if (widget.redirectTo != null) ...[
              const SizedBox(height: 8),
              Text(
                'Після входу ви повернетесь до: ${widget.redirectTo}',
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Імʼя та прізвище',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cardController,
              decoration: const InputDecoration(
                labelText: 'Номер читацького квитка',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                libraryState.login(
                  name: _nameController.text,
                  card: _cardController.text,
                );
              },
              icon: const Icon(Icons.login),
              label: const Text('Увійти'),
            ),
          ],
        ),
      ),
    );
  }
}