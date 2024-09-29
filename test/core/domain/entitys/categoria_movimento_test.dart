import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SubCategorias', () {
    test('Cria uma categoria com subCategoria', () async {
      final categoria = Categoria.make(name: 'Teste1', subCategorias: [
        Categoria.make(name: 'SubCat1'),
        Categoria.make(name: 'SubCat2'),
      ]);

      expect(categoria.subCategorias.length, 2);
      expect(categoria.subCategorias.first.name, 'SubCat1');
      expect(categoria.subCategorias[1].name, 'SubCat2');
    });

    test('Cria uma categoria sem subCategoria', () async {
      final categoria = Categoria.make(name: 'Teste1');

      expect(categoria.name, 'Teste1');
      expect(categoria.subCategorias.length, 0);
    });

    test('Serializa a categoria', () async {
      final categoria = Categoria.make(
        name: 'Teste1',
        subCategorias: [
          Categoria.make(name: 'SubCat1'),
          Categoria.make(name: 'SubCat2'),
        ],
      ).toMap();

      expect(categoria['name'], 'Teste1');
      expect(categoria['subCategorias'], isA<List<Map<String, dynamic>>>());
      expect(categoria['subCategorias'][0]['name'], 'SubCat1');
      expect(categoria['subCategorias'][1]['name'], 'SubCat2');
    });

    test('Descerializa a categoria', () async {
      final categoriaMap = Categoria.make(
        name: 'Teste1',
        subCategorias: [
          Categoria.make(name: 'SubCat1'),
          Categoria.make(name: 'SubCat2'),
        ],
      ).toMap();

      final categoria = Categoria.fromMap(categoriaMap);

      expect(categoria.name, 'Teste1');
      expect(categoria.subCategorias.length, 2);
      expect(categoria.subCategorias.first.name, 'SubCat1');
    });
  });
}
