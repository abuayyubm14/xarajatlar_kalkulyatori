import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class CategoryHelper {
  static List<String> getCategories(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.categoryFood,
      l10n.categoryTransportation,
      l10n.categoryShopping,
      l10n.categoryBills,
      l10n.categoryEntertainment,
      l10n.categoryHealthcare,
      l10n.categoryOthers,
    ];
  }

  static String getLocalizedCategory(BuildContext context, String category) {
    final l10n = AppLocalizations.of(context)!;
    final Map<String, String> categoryMap = {
      'Food': l10n.categoryFood,
      'Transportation': l10n.categoryTransportation,
      'Shopping': l10n.categoryShopping,
      'Bills': l10n.categoryBills,
      'Entertainment': l10n.categoryEntertainment,
      'Healthcare': l10n.categoryHealthcare,
      'Others': l10n.categoryOthers,
    };
    return categoryMap[category] ?? l10n.categoryOthers;
  }
}
