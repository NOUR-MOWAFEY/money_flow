# MoneyFlow Build Commands
# ========================
# This project uses dynamic IconData deserialization via Hive TypeAdapter,
# which requires --no-tree-shake-icons for all release builds.

.PHONY: apk appbundle run-release run clean

## Build a release APK
apk:
	flutter build apk --release --no-tree-shake-icons

## Build a release App Bundle (for Play Store)
appbundle:
	flutter build appbundle --release --no-tree-shake-icons

## Run in release mode on a connected device
run-release:
	flutter run --release --no-tree-shake-icons

## Run in debug mode (no flag needed)
run:
	flutter run

## Clean build artifacts
clean:
	flutter clean
