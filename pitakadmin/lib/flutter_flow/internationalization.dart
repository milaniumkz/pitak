import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['ru', 'kk'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? ruText = '',
    String? kkText = '',
  }) =>
      [ruText, kkText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Login
  {
    'foivvaxa': {
      'ru': 'Вход',
      'kk': 'Кіру',
    },
    'oiw0u2ky': {
      'ru': 'Email',
      'kk': 'Электрондық пошта',
    },
    'dfmq76pn': {
      'ru': 'Пароль',
      'kk': 'Құпия сөз',
    },
    'r7cskwr3': {
      'ru': 'Войти',
      'kk': 'Кіру үшін',
    },
    'pbhuw6na': {
      'ru': 'Забыли пароль?',
      'kk': 'Құпия сөзіңізді ұмыттыңыз ба?',
    },
    '2qa40pb7': {
      'ru': 'Home',
      'kk': 'Үй',
    },
  },
  // Home
  {
    'pkq8jjql': {
      'ru': 'Пользователей',
      'kk': 'Пайдаланушылар',
    },
    'hn5st68a': {
      'ru': 'Объявлений',
      'kk': 'Жарнамалар',
    },
    'a56bbnjj': {
      'ru': 'Пользователи',
      'kk': 'Пайдаланушылар',
    },
    '0xprfhki': {
      'ru': 'Объявления',
      'kk': 'жарнамалар',
    },
    'd4ng5b07': {
      'ru': 'Города',
      'kk': 'Қалалар',
    },
    'prsuot4o': {
      'ru': 'Категории',
      'kk': 'Санаттар',
    },
    'yzgt3twn': {
      'ru': 'Политика',
      'kk': 'Саясат',
    },
    'di0j92xm': {
      'ru': 'Условия',
      'kk': 'Шарттар',
    },
    'lkqlzq7e': {
      'ru': 'О нас',
      'kk': 'Біз туралы',
    },
    'rn030l4o': {
      'ru': 'Тарифы',
      'kk': 'Тарифтер',
    },
    'fj5vd04d': {
      'ru': 'чат',
      'kk': 'чат',
    },
    'loks2r58': {
      'ru': 'Словарь',
      'kk': 'Сөздік',
    },
    '47j48a8s': {
      'ru': 'Жалобы',
      'kk': 'Шағымдар',
    },
    'fowgb1mx': {
      'ru': 'Home',
      'kk': 'Үй',
    },
  },
  // users
  {
    '14eqcsid': {
      'ru': 'Пользователи',
      'kk': 'Пайдаланушылар',
    },
    '5hgu4dmb': {
      'ru': 'Удалить',
      'kk': 'Жою',
    },
    'p5pjntd0': {
      'ru': 'Админ',
      'kk': 'Админ',
    },
    'osl1x965': {
      'ru': 'Home',
      'kk': 'Үй',
    },
  },
  // obPage
  {
    'ovgzexk9': {
      'ru': 'Поиск',
      'kk': 'Іздеу',
    },
    'cqyektnk': {
      'ru': 'На проверке',
      'kk': 'Қаралуда',
    },
    'kj2de1v3': {
      'ru': 'Активировать',
      'kk': 'Іске қосу',
    },
    '6cgl2iyg': {
      'ru': 'Удалить',
      'kk': 'Жою',
    },
    'atcz7sea': {
      'ru': 'Активные',
      'kk': 'Белсенді',
    },
    'harwxfa1': {
      'ru': 'Активировать',
      'kk': 'Іске қосу',
    },
    'zhfg5rvx': {
      'ru': 'Удалить',
      'kk': 'Жою',
    },
    'ci7k7ncc': {
      'ru': 'Активировать',
      'kk': 'Іске қосу',
    },
    'ge329ea9': {
      'ru': 'Удалить',
      'kk': 'Жою',
    },
    '507hzmdz': {
      'ru': 'Не оплаченные',
      'kk': 'Төленбеген',
    },
    '5fk2p8ak': {
      'ru': 'Активировать',
      'kk': 'Іске қосу',
    },
    'oigia3l4': {
      'ru': 'Удалить',
      'kk': 'Жою',
    },
    'col3lzi5': {
      'ru': 'Удаленные',
      'kk': 'Жойылды',
    },
    '2lu8khip': {
      'ru': 'Активировать',
      'kk': 'Іске қосу',
    },
    'g3cknq0d': {
      'ru': 'Удалить',
      'kk': 'Жою',
    },
    'z47e3hnt': {
      'ru': 'Home',
      'kk': 'Үй',
    },
  },
  // podOb
  {
    'c1og9rgd': {
      'ru': 'Просмотр',
      'kk': 'Көру',
    },
    'y50zlssu': {
      'ru': 'Описание:',
      'kk': 'Сипаттама:',
    },
    '3qu2zgls': {
      'ru': 'позвонить',
      'kk': 'қоңырау шалу',
    },
    'l0wtov99': {
      'ru': 'Написать',
      'kk': 'Жазыңыз',
    },
    'lufxyptc': {
      'ru': 'Whats\'app',
      'kk': 'Whatsapp',
    },
    'k8e8pf39': {
      'ru': 'Instagram',
      'kk': 'Instagram',
    },
    'if87pg4c': {
      'ru': 'Home',
      'kk': 'Үй',
    },
  },
  // AllChatsPage
  {
    '6pd6e3ma': {
      'ru': 'Чаты',
      'kk': 'Чаттар',
    },
  },
  // politika
  {
    't1l396zy': {
      'ru': 'политика',
      'kk': 'саясат',
    },
    'osnjn6yo': {
      'ru': 'политика ',
      'kk': 'саясат',
    },
    'kvcokv17': {
      'ru': 'Сохранить',
      'kk': 'Сақтау',
    },
    'ddwaavgx': {
      'ru': 'Home',
      'kk': 'Үй',
    },
  },
  // uslovia
  {
    'v2uf4pvf': {
      'ru': 'Условия',
      'kk': 'Шарттар',
    },
    '063s9hvp': {
      'ru': 'Условия',
      'kk': 'Шарттар',
    },
    'komcx08c': {
      'ru': 'Сохранить',
      'kk': 'Сақтау',
    },
    '67rhvqlk': {
      'ru': 'Home',
      'kk': 'Үй',
    },
  },
  // about
  {
    '618d72fd': {
      'ru': 'О нас',
      'kk': 'Біз туралы',
    },
    'h6iohodv': {
      'ru': 'О нас',
      'kk': 'Біз туралы',
    },
    'k05hzwey': {
      'ru': 'Сохранить',
      'kk': 'Сақтау',
    },
    '0gjkd1u9': {
      'ru': 'Home',
      'kk': 'Үй',
    },
  },
  // tarif
  {
    'f4c3cb7m': {
      'ru': 'Тариф',
      'kk': 'Бағалау',
    },
    '0817bu33': {
      'ru': 'Публикация объявления',
      'kk': 'Жарнама жариялау',
    },
    'iue44mhb': {
      'ru': 'Цена',
      'kk': 'Бағасы',
    },
    'z2q2x8ov': {
      'ru': 'ТОП',
      'kk': 'ТОП',
    },
    '27igs15e': {
      'ru': 'Цена',
      'kk': 'Бағасы',
    },
    '6bg3bsvp': {
      'ru': 'Выделить цветом',
      'kk': 'Түспен бөлектеңіз',
    },
    '1jcnabuw': {
      'ru': 'Цена',
      'kk': 'Бағасы',
    },
    'aal7c78f': {
      'ru': 'Сохранить',
      'kk': 'Сақтау',
    },
    'r8z4z6s2': {
      'ru': 'Home',
      'kk': 'Үй',
    },
  },
  // city
  {
    '2nk8wyez': {
      'ru': 'Города',
      'kk': 'Қалалар',
    },
    'nl2rnjxv': {
      'ru': 'Регионы',
      'kk': 'Аймақтар',
    },
    'bi6et7ap': {
      'ru': 'Наименование',
      'kk': 'Аты',
    },
    '84wdkhw8': {
      'ru': 'Сохранить',
      'kk': 'Сақтау',
    },
    'xui75cma': {
      'ru': 'Города',
      'kk': 'Қалалар',
    },
    'lwfqxalr': {
      'ru': 'Наименование',
      'kk': 'Аты',
    },
    'w3m817sd': {
      'ru': 'Выберите регион',
      'kk': 'Аймақты таңдаңыз',
    },
    '2v09xp0i': {
      'ru': 'Search for an item...',
      'kk': 'Элементті іздеу...',
    },
    'rqdlfbva': {
      'ru': 'Option 1',
      'kk': '1-нұсқа',
    },
    'fjds1zac': {
      'ru': 'Сохранить',
      'kk': 'Сақтау',
    },
    '9dhzqda1': {
      'ru': 'Home',
      'kk': 'Үй',
    },
  },
  // kat
  {
    'y2w1rj9c': {
      'ru': 'Категории',
      'kk': 'Санаттар',
    },
    'gjovl2as': {
      'ru': 'Категории',
      'kk': 'Санаттар',
    },
    'tlla3x05': {
      'ru': 'Наименование',
      'kk': 'Аты',
    },
    'mehh1t81': {
      'ru': 'Выбрать иконку',
      'kk': 'Белгішені таңдаңыз',
    },
    '04okmqat': {
      'ru': 'Сохранить',
      'kk': 'Сақтау',
    },
    's97iqasz': {
      'ru': 'Подкатегории',
      'kk': 'Ішкі санаттар',
    },
    '6gsa0y16': {
      'ru': 'Наименование',
      'kk': 'Аты',
    },
    'h39cojuu': {
      'ru': 'Выберите категорию',
      'kk': 'Санатты таңдаңыз',
    },
    'z86043jk': {
      'ru': 'Search for an item...',
      'kk': 'Элементті іздеу...',
    },
    'einb7ib2': {
      'ru': 'Option 1',
      'kk': '1-нұсқа',
    },
    '2bjj7z6s': {
      'ru': 'Сохранить',
      'kk': 'Сақтау',
    },
    'tywg9p45': {
      'ru': 'Home',
      'kk': 'Үй',
    },
  },
  // slovar
  {
    '02frl91o': {
      'ru': 'Словарь',
      'kk': 'Сөздік',
    },
    'yohrmxpf': {
      'ru': 'Наименование',
      'kk': 'Аты',
    },
    'eyqx1kkc': {
      'ru': 'Сохранить',
      'kk': 'Сақтау',
    },
    'g1ee5wyr': {
      'ru': 'Home',
      'kk': 'Үй',
    },
  },
  // disput
  {
    'z2815crl': {
      'ru': 'Открыть объявление',
      'kk': 'Жарнаманы ашу',
    },
    'g9baidxd': {
      'ru': 'Удалить объявление',
      'kk': 'Жарнаманы жою',
    },
    'du9a9ahx': {
      'ru': 'Удалить Жалобу',
      'kk': 'Шағымды жою',
    },
    'jbhhkvyp': {
      'ru': 'Жалобы',
      'kk': 'Шағымдар',
    },
    'p2ccv1hx': {
      'ru': 'Home',
      'kk': 'Үй',
    },
  },
  // Miscellaneous
  {
    'cff2am1g': {
      'ru': 'photo profile and order',
      'kk': 'фото профиль және тапсырыс',
    },
    'zybv8d3e': {
      'ru': 'photo profile and order',
      'kk': 'фото профиль және тапсырыс',
    },
    'rolmlysj': {
      'ru': 'call Video',
      'kk': 'Бейне қоңырау',
    },
    '1h45r712': {
      'ru': 'Ошибка',
      'kk': 'Қате',
    },
    'cc7levff': {
      'ru': 'Неверный пароль',
      'kk': 'қате құпия сөз',
    },
    'w1e1gu2b': {
      'ru': '',
      'kk': '',
    },
    'c67xawbf': {
      'ru': 'Номер телефона должен начаться на +7',
      'kk': 'Телефон нөмірі +7-ден басталуы керек',
    },
    'j2qghitp': {
      'ru': '',
      'kk': '',
    },
    '3105p9li': {
      'ru': 'Введите смс код',
      'kk': 'SMS кодын енгізіңіз',
    },
    '09tjn1ht': {
      'ru': '',
      'kk': '',
    },
    'u8t9e61k': {
      'ru': '',
      'kk': '',
    },
    'shlvvf4o': {
      'ru': '',
      'kk': '',
    },
    'oe210xe9': {
      'ru': 'Неверный формат',
      'kk': 'Қате формат',
    },
    'rzvjyewa': {
      'ru': 'Загрузка фото/видео',
      'kk': 'Фотосуреттерді/бейнелерді жүктеп салу',
    },
    'mistebrl': {
      'ru': 'Успешно',
      'kk': 'Сәтті',
    },
    'ks4pnp66': {
      'ru': 'Ошибка загрузки фото/видео',
      'kk': 'Фотосуретті/бейнені жүктеу қатесі',
    },
    't20kljbi': {
      'ru': 'Отправка фото',
      'kk': 'Фото жіберу',
    },
    'ppoad0m4': {
      'ru': 'Выберите источник',
      'kk': 'Дереккөзді таңдаңыз',
    },
    'vpgvzqh9': {
      'ru': 'Гарелея',
      'kk': 'Гарели',
    },
    '1t9662lh': {
      'ru': 'Гарелея(Фото)',
      'kk': 'Гарели (фото)',
    },
    'lbp6feid': {
      'ru': 'Гарелея(Видео)',
      'kk': 'Гарели (бейне)',
    },
    '114jnrzf': {
      'ru': 'Камера',
      'kk': 'Камера',
    },
    'g6kfdg8n': {
      'ru': '',
      'kk': '',
    },
    '9ct1zunl': {
      'ru': '',
      'kk': '',
    },
    'paa4juvo': {
      'ru': '',
      'kk': '',
    },
    'fqqxs3gb': {
      'ru': '',
      'kk': '',
    },
  },
].reduce((a, b) => a..addAll(b));
