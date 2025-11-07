# Aqlli xarajatlar hisoblagichi (cet)

Bu - Flutter yordamida yaratilgan «Aqlli xarajatlar hisoblagichi» mobil ilovasi bo‘lib, foydalanuvchilarga kirim va chiqim tranzaksiyalarini qo‘shish, kategoriyaga ajratish, balansni ko‘rish va vizual tahlillar (diagrammalar) orqali xarajatlarni kuzatish imkonini beradi. Ilova ko‘p platformali (Android, iOS, web, desktop) ishlashga mo‘ljallangan.

## Tezkor mazmun
- Ilova nomi: cet (Aqlli xarajatlar hisoblagichi)
- Til: Dart + Flutter
- Asosiy paketlar: Provider, Hive, shared_preferences, intl, fl_chart

## Asosiy funksiyalar
- Tranzaksiyalarni qo‘shish, tahrirlash va o‘chirish
- Kategoriya bo‘yicha saralash va tahlil
- Diagrammalar orqali vizual tahlil (fl_chart yordamida)
- Localization (Ingliz, Rus, O‘zbek)
- Mahalliy saqlash: Hive (tranzaksiyalar uchun), SharedPreferences (sozlamalar uchun)

## Loyihaning tuzilishi (muhim fayllar)
- `lib/main.dart` — ilovaning kirish nuqtasi, Provider va Locale konfiguratsiyalari
- `lib/providers/` — holat provayderlari (til, tranzaksiyalar)
- `lib/models/` — ma'lumot modellari va Hive adapterlar
- `lib/widgets/` — qayta ishlatiladigan UI komponentlar
- `lib/utils/` — yordamchi funksiyalar (kategoriya va boshqalar)
- `lib/l10n/` — ARB fayllari va lokalizatsiya resurslari

## Ishga tushirish (developer uchun)
1. Loyihani klonlash:

```bash
git clone <repo-url>
cd cet
```

2. Paketlarni o‘rnatish:

```bash
flutter pub get
```

3. Hive adapterlarini generatsiya qilish (agar model o‘zgartirilgan bo‘lsa):

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Ilovani ishga tushirish:

```bash
flutter run -d <device>
# yoki
flutter build apk --release
```

## Lokalizatsiya (til qo‘llab-quvvatlash)
- ARB fayllari: `lib/l10n/app_en.arb`, `app_ru.arb`, `app_uz.arb`.
- `AppLocalizations` gen-l10n orqali hosil bo‘ladi va `AppLocalizations.of(context)` orqali foydalaniladi.
- Til sozlamalari `SharedPreferences` orqali saqlanadi va `LanguageProvider` yordamida yuklanadi.

## Texnologiyalar va asosiy paketlar
- Flutter (Dart)
- Provider — state management
- Hive & hive_flutter — mahalliy NoSQL saqlash
- shared_preferences — kichik sozlamalar uchun
- intl, flutter_localizations — internationalizatsiya
- fl_chart — diagrammalar
- google_fonts — shriftlar

## Muammolar va ularning echimi (tezkor)
- Agar Android buildida Kotlin kompilyatori ichki xato bersa (`Internal compiler error`), `android/settings.gradle.kts` dagi Kotlin plugin versiyasini 1.9.10 yoki 1.8.x ga pasaytirib ko‘ring. So‘ng:

```bash
flutter clean
flutter pub get
cd android
./gradlew assembleDebug --stacktrace
```


