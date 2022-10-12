#!/usr/bin/env sh
set -e
dart run mason_cli:mason bundle -t dart mason_templates/bricks/rx_bloc_base
cp rx_bloc_base_bundle.dart lib/src/templates/
rm rx_bloc_base_bundle.dart
rm -rf example/test_app
mkdir example/test_app
dart run rx_bloc_cli create --org com.primeholding --project-name test_app --include-analytics true example/test_app
cd example/test_app
flutter pub get
#flutter test
cd ../..
cp example/test_app/README.md example/
dart format lib
dart format example/test_app
