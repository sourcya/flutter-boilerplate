// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../../app/wishlist/data/model/db/database_wishlist_item.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 1445632275177036296),
      name: 'DatabaseWishlistItem',
      lastPropertyId: const obx_int.IdUid(4, 4222888110350666162),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 2872691284660032660),
            name: 'id',
            type: 6,
            flags: 129),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 4293275983892659383),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 8603797034349474411),
            name: 'imageUrl',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 4222888110350666162),
            name: 'date',
            type: 10,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(1, 1445632275177036296),
      lastIndexId: const obx_int.IdUid(0, 0),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    DatabaseWishlistItem: obx_int.EntityDefinition<DatabaseWishlistItem>(
        model: _entities[0],
        toOneRelations: (DatabaseWishlistItem object) => [],
        toManyRelations: (DatabaseWishlistItem object) => {},
        getId: (DatabaseWishlistItem object) => object.id,
        setId: (DatabaseWishlistItem object, int id) {
          object.id = id;
        },
        objectToFB: (DatabaseWishlistItem object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final imageUrlOffset = object.imageUrl == null
              ? null
              : fbb.writeString(object.imageUrl!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, imageUrlOffset);
          fbb.addInt64(3, object.date?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final dateValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 10);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final imageUrlParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final dateParam = dateValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(dateValue);
          final object = DatabaseWishlistItem(
              id: idParam,
              name: nameParam,
              imageUrl: imageUrlParam,
              date: dateParam);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [DatabaseWishlistItem] entity fields to define ObjectBox queries.
class DatabaseWishlistItem_ {
  /// see [DatabaseWishlistItem.id]
  static final id = obx.QueryIntegerProperty<DatabaseWishlistItem>(
      _entities[0].properties[0]);

  /// see [DatabaseWishlistItem.name]
  static final name =
      obx.QueryStringProperty<DatabaseWishlistItem>(_entities[0].properties[1]);

  /// see [DatabaseWishlistItem.imageUrl]
  static final imageUrl =
      obx.QueryStringProperty<DatabaseWishlistItem>(_entities[0].properties[2]);

  /// see [DatabaseWishlistItem.date]
  static final date =
      obx.QueryDateProperty<DatabaseWishlistItem>(_entities[0].properties[3]);
}