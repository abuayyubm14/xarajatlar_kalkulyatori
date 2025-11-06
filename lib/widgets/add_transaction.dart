import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction_model.dart';
import '../utils/category_helper.dart';

class AddTransactionSheet extends StatefulWidget {
  const AddTransactionSheet({super.key});

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = '';
  bool _isIncome = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedCategory = CategoryHelper.getCategories(context).first;
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<TransactionProvider>(context, listen: false);

      final transaction = Transaction(
        id: DateTime.now().toString(),
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        date: _selectedDate,
        category: _selectedCategory,
        isIncome: _isIncome,
        note: _noteController.text.isEmpty ? null : _noteController.text,
      );

      provider.addTransaction(transaction);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categories = CategoryHelper.getCategories(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(l10n.category),
                const SizedBox(width: 16),
                ChoiceChip(
                  label: Text(l10n.expense),
                  selected: !_isIncome,
                  onSelected: (selected) {
                    setState(() => _isIncome = !selected);
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: Text(l10n.income),
                  selected: _isIncome,
                  onSelected: (selected) {
                    setState(() => _isIncome = selected);
                  },
                ),
              ],
            ),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: l10n.title),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.validationEnterTitle;
                }
                return null;
              },
            ),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(labelText: l10n.amount),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.validationEnterAmount;
                }
                if (double.tryParse(value) == null) {
                  return l10n.validationEnterValidNumber;
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              value: _selectedCategory.isNotEmpty
                  ? _selectedCategory
                  : categories.first,
              decoration: InputDecoration(labelText: l10n.category),
              items: categories.map((category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
            ),
            InkWell(
              onTap: () => _selectDate(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 8),
                    Text(
                      '${l10n.date}: ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                    ),
                  ],
                ),
              ),
            ),
            TextFormField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: l10n.note,
                helperText: l10n.optional,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(l10n.addTransaction),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
