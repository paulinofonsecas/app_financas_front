import 'dart:io';

import 'package:app_financas/core/data/provider/db/db_objectivo_provider.dart';
import 'package:app_financas/core/data/provider/db/helpers/db_hive_box_names.dart';
import 'package:app_financas/core/data/provider/db/helpers/hive_db_provider.dart';
import 'package:app_financas/core/domain/entitys/objectivo.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  dependencyInitialize();

  var path = Directory.current.path;

  setUp(() {
    Hive.init('$path/test/hive_testing_path');
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    await Hive.deleteBoxFromDisk(kObjectivoBox);
    await Hive.close();
  });

  test('Save objectivo in database with success', () async {
    final objectivoProvider = DBObjectivoProvider(
      HiveDBProvider(boxName: kObjectivoBox),
    );

    final objectivo = Objectivo.fake();

    final result = await objectivoProvider.createObjectivo(objectivo);

    expect(result, isA<Right>());

    final resultObjectivo = await objectivoProvider.getObjectivo(objectivo.id);

    expect(resultObjectivo, isA<Right>());
    expect(resultObjectivo.fold((l) => null, (r) => r), objectivo);
  });

  test('Update objectivo in database with success', () async {
    final objectivoProvider = DBObjectivoProvider(
      HiveDBProvider(boxName: kObjectivoBox),
    );

    final objectivo = Objectivo.fake();

    await objectivoProvider.createObjectivo(objectivo);

    await objectivoProvider.updateObjectivo(objectivo.copyWith(
      name: 'new name',
    ));

    final result = await objectivoProvider.getObjectivo(objectivo.id);

    expect(result, isA<Right>());

    final resultObjectivo = result.fold((l) => null, (r) => r);
    expect(resultObjectivo, objectivo.copyWith(name: 'new name'));
  });

  test('Delete objectivo in database with success', () async {
    final objectivoProvider = DBObjectivoProvider(
      HiveDBProvider(boxName: kObjectivoBox),
    );

    final objectivo = Objectivo.fake();

    await objectivoProvider.createObjectivo(objectivo);

    await objectivoProvider.deleteObjectivo(objectivo.id);

    final result = await objectivoProvider.getObjectivo(objectivo.id);

    expect(result, isA<Left>());

    final resultObjectivo = result.fold((l) => l, (r) => null);
    expect(resultObjectivo, isA<Failure>());
  });

  test('List objectivo in database with success', () async {
    final objectivoProvider = DBObjectivoProvider(
      HiveDBProvider(boxName: kObjectivoBox),
    );

    final objectivo = Objectivo.fake();

    await objectivoProvider.createObjectivo(objectivo);

    final result = await objectivoProvider.listObjectivos();

    expect(result, isA<Right>());

    final resultObjectivo = result.getOrElse(() => []);
    expect(resultObjectivo, [objectivo]);
  });
}
