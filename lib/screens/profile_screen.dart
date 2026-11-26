import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import '../state/library_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _cardController;
  bool _hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: libraryState.readerName);
    _cardController = TextEditingController(text: libraryState.cardNumber);
    _nameController.addListener(_checkChanges);
    _cardController.addListener(_checkChanges);
  }

  void _checkChanges() {
    final dirty = _nameController.text.trim() != libraryState.readerName ||
        _cardController.text.trim() != libraryState.cardNumber;
    if (dirty != _hasUnsavedChanges) {
      setState(() {
        _hasUnsavedChanges = dirty;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    libraryState.updateProfile(
      name: _nameController.text,
      card: _cardController.text,
    );
    setState(() {
      _hasUnsavedChanges = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Дані профілю збережено')),
    );
  }

  Future<void> _confirmDiscard() async {
    final shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Незбережені зміни'),
        content: const Text(
          'У формі профілю є незбережені зміни. Вийти без збереження?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Залишитися'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Вийти'),
          ),
        ],
      ),
    );

    if (shouldDiscard == true && mounted) {
      _nameController.text = libraryState.readerName;
      _cardController.text = libraryState.cardNumber;
      setState(() {
        _hasUnsavedChanges = false;
      });
      context.go('/catalog');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: libraryState,
      builder: (context, _) {
        return PopScope(
          canPop: !_hasUnsavedChanges,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop && _hasUnsavedChanges) {
              _confirmDiscard();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Профіль читача'),
              leading: _hasUnsavedChanges
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      tooltip: 'Назад до каталогу',
                      onPressed: _confirmDiscard,
                    )
                  : null,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(
                        libraryState.isLoggedIn
                            ? Icons.verified_user
                            : Icons.person_off_outlined,
                        color: libraryState.isLoggedIn
                            ? Colors.green
                            : Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        libraryState.isLoggedIn
                            ? 'Статус: Авторизований читач'
                            : 'Статус: Гість (вхід не виконано)',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
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
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: _hasUnsavedChanges ? _saveProfile : null,
                    icon: const Icon(Icons.save),
                    label: const Text('Зберегти зміни'),
                  ),
                  const SizedBox(height: 12),
                  if (libraryState.isLoggedIn)
                    OutlinedButton.icon(
                      onPressed: libraryState.logout,
                      icon: const Icon(Icons.logout),
                      label: const Text('Вийти з акаунту'),
                    )
                  else
                    OutlinedButton.icon(
                      onPressed: () => context.push('/login'),
                      icon: const Icon(Icons.login),
                      label: const Text('Увійти в акаунт'),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}