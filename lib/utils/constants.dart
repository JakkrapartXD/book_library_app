import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Constants {
  // Reading Status Colors
  static const Map<String, int> statusColors = {
    'Not Started': 0xFFBDBDBD,
    'Reading': 0xFFFFA726,
    'Finished': 0xFF66BB6A,
  };

  // Get translated book categories
  static List<String> getBookCategories(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.fiction,
      l10n.nonFiction,
      l10n.academic,
      l10n.biography,
      l10n.history,
      l10n.science,
      l10n.philosophy,
      l10n.selfHelp,
      l10n.reference,
      l10n.other,
    ];
  }

  // Get translated reading statuses
  static List<String> getReadingStatuses(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.notStarted, l10n.reading, l10n.finished];
  }

  // Get status color for a localized status
  static int getStatusColor(BuildContext context, String status) {
    final l10n = AppLocalizations.of(context)!;
    if (status == l10n.notStarted) return statusColors['Not Started']!;
    if (status == l10n.reading) return statusColors['Reading']!;
    if (status == l10n.finished) return statusColors['Finished']!;
    return 0xFFBDBDBD; // Default color
  }
}
