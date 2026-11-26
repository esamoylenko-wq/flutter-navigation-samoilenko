import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class SelectDateScreen extends StatefulWidget {
  final DateTime initialDate;

  const SelectDateScreen({
    super.key,
    required this.initialDate,
  });

  @override
  State<SelectDateScreen> createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day.$month.${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day + 1);
    final lastDate = DateTime(now.year, now.month + 3, now.day);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Дата повернення'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Обрана дата: ${_formatDate(_selectedDate)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            CalendarDatePicker(
              initialDate: _selectedDate.isBefore(firstDate)
                  ? firstDate
                  : _selectedDate,
              firstDate: firstDate,
              lastDate: lastDate,
              onDateChanged: (newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => context.pop<DateTime>(_selectedDate),
                icon: const Icon(Icons.check),
                label: const Text('Підтвердити дату'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}