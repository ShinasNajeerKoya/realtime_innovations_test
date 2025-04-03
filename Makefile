generate-text-local:
	dart run easy_localization:generate -S "assets/languages" -o "locale_keys.g.dart" -f keys;\

manual-generate:
	flutter pub get;\
	dart run easy_localization:generate -S "assets/languages" -o "locale_keys.g.dart" -f keys;\
	dart run build_runner build --delete-conflicting-outputs ;\
