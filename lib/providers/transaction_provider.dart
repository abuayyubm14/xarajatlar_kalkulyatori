import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  late Box<Transaction> _transactionBox;
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TransactionAdapter());
    _transactionBox = await Hive.openBox<Transaction>('transactions');
    _loadTransactions();
  }

  void _loadTransactions() {
    _transactions = _transactionBox.values.toList();
    notifyListeners();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await _transactionBox.put(transaction.id, transaction);
    _loadTransactions();
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _transactionBox.put(transaction.id, transaction);
    _loadTransactions();
  }

  Future<void> deleteTransaction(String id) async {
    await _transactionBox.delete(id);
    _loadTransactions();
  }

  double getTotalIncome() {
    return _transactions
        .where((t) => t.isIncome)
        .fold(0, (sum, item) => sum + item.amount);
  }

  double getTotalExpense() {
    return _transactions
        .where((t) => !t.isIncome)
        .fold(0, (sum, item) => sum + item.amount);
  }

  Map<String, double> getCategoryTotals({bool? isIncome}) {
    final filteredTransactions = isIncome == null
        ? _transactions
        : _transactions.where((t) => t.isIncome == isIncome);

    return filteredTransactions.fold<Map<String, double>>({}, (
      Map<String, double> map,
      transaction,
    ) {
      map[transaction.category] =
          (map[transaction.category] ?? 0) + transaction.amount;
      return map;
    });
  }
}
