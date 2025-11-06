import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: (String languageCode) {
        languageProvider.changeLanguage(languageCode);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(value: 'en', child: Text(l10n.english)),
        PopupMenuItem<String>(value: 'ru', child: Text(l10n.russian)),
        PopupMenuItem<String>(value: 'uz', child: Text(l10n.uzbek)),
      ],
    );
  }
}
