// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Умный учет расходов';

  @override
  String get addTransaction => 'Добавить транзакцию';

  @override
  String get income => 'Доход';

  @override
  String get expense => 'Расход';

  @override
  String get balance => 'Текущий баланс';

  @override
  String get category => 'Категория';

  @override
  String get date => 'Дата';

  @override
  String get amount => 'Сумма';

  @override
  String get title => 'Название';

  @override
  String get note => 'Примечание';

  @override
  String get optional => 'Необязательно';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get noTransactions => 'Пока нет транзакций!';

  @override
  String get categoryFood => 'Еда';

  @override
  String get categoryTransportation => 'Транспорт';

  @override
  String get categoryShopping => 'Покупки';

  @override
  String get categoryBills => 'Счета';

  @override
  String get categoryEntertainment => 'Развлечения';

  @override
  String get categoryHealthcare => 'Здравоохранение';

  @override
  String get categoryOthers => 'Другое';

  @override
  String get validationEnterTitle => 'Пожалуйста, введите название';

  @override
  String get validationEnterAmount => 'Пожалуйста, введите сумму';

  @override
  String get validationEnterValidNumber =>
      'Пожалуйста, введите корректное число';

  @override
  String get language => 'Язык';

  @override
  String get english => 'Английский';

  @override
  String get russian => 'Русский';

  @override
  String get uzbek => 'Узбекский';
}
