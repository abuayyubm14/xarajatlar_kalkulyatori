import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/transaction_provider.dart';
import '../utils/category_helper.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        final transactions = provider.transactions;

        final l10n = AppLocalizations.of(context)!;

        if (transactions.isEmpty) {
          return Center(child: Text(l10n.noTransactions));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: transaction.isIncome
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                child: Icon(
                  transaction.isIncome ? Icons.add : Icons.remove,
                  color: transaction.isIncome ? Colors.green : Colors.red,
                ),
              ),
              title: Text(transaction.title),
              subtitle: Text(
                '${CategoryHelper.getLocalizedCategory(context, transaction.category)} • ${DateFormat.yMMMd().format(transaction.date)}',
              ),
              trailing: Text(
                '\$${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: transaction.isIncome ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // TODO: Implement edit transaction
              },
            );
          },
        );
      },
    );
  }
}
