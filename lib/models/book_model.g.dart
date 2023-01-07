// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookModelAdapter extends TypeAdapter<BookModel> {
  @override
  final int typeId = 0;

  @override
  BookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookModel(
      title: fields[0] as String,
      poster: fields[1] as String,
      id: fields[2] as String,
      releaseDate: fields[3] as String?,
      overview: fields[4] as String?,
      cost: fields[5] as int?,
      genre: fields[6] as String?,
      rateing: fields[7] as double?,
      writer: fields[8] as String?,
      page: fields[9] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.poster)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.releaseDate)
      ..writeByte(4)
      ..write(obj.overview)
      ..writeByte(5)
      ..write(obj.cost)
      ..writeByte(6)
      ..write(obj.genre)
      ..writeByte(7)
      ..write(obj.rateing)
      ..writeByte(8)
      ..write(obj.writer)
      ..writeByte(9)
      ..write(obj.page);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
