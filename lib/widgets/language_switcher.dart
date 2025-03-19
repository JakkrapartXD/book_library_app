import 'package:book_library_app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    final isEnglish = languageProvider.locale.languageCode == 'en';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.language + ': ',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            languageProvider.toggleLanguage();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isEnglish ? 'EN' : 'TH',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.translate,
                  size: 16,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
