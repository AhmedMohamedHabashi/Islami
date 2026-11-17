import 'package:flutter/widgets.dart';
import 'package:islami/core/errors/app_errors.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';

class AppErrorLocalizer {
  AppErrorLocalizer._();

  static String getMessage(BuildContext context, String errorKey) {
    final l10n = AppLocalizations.of(context)!;

    return switch (errorKey) {
      AppErrors.networkError => l10n.networkError,
      AppErrors.timeoutError => l10n.timeoutError,
      AppErrors.serverError => l10n.serverError,
      AppErrors.unexpectedError => l10n.unexpectedError,
      AppErrors.badRequest => l10n.badRequest,
      AppErrors.unauthorized => l10n.unauthorized,
      AppErrors.forbidden => l10n.forbidden,
      AppErrors.notFound => l10n.notFound,
      AppErrors.conflict => l10n.conflict,
      AppErrors.validationError => l10n.validationError,
      AppErrors.tooManyRequests => l10n.tooManyRequests,
      AppErrors.serviceUnavailable => l10n.serviceUnavailable,
      AppErrors.cacheError => l10n.cacheError,
      AppErrors.requestCancelled => l10n.requestCancelled,
      AppErrors.speechUnavailable => l10n.speechUnavailable,
      AppErrors.speechRecognitionError => l10n.speechRecognitionError,
      _ => l10n.unexpectedError,
    };
  }
}
