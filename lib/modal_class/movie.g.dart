// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieAdapter extends TypeAdapter<Movie> {
  @override
  final int typeId = 0;

  @override
  Movie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Movie(
      voteCount: fields[0] as int?,
      id: fields[1] as int?,
      video: fields[2] as bool?,
      voteAverage: fields[3] as String?,
      title: fields[4] as String?,
      popularity: fields[5] as double?,
      posterPath: fields[6] as String?,
      originalLanguage: fields[7] as String?,
      originalTitle: fields[8] as String?,
      genreIds: (fields[9] as List?)?.cast<int>(),
      backdropPath: fields[10] as String?,
      adult: fields[11] as bool?,
      overview: fields[12] as String?,
      releaseDate: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Movie obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.voteCount)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.video)
      ..writeByte(3)
      ..write(obj.voteAverage)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.popularity)
      ..writeByte(6)
      ..write(obj.posterPath)
      ..writeByte(7)
      ..write(obj.originalLanguage)
      ..writeByte(8)
      ..write(obj.originalTitle)
      ..writeByte(9)
      ..write(obj.genreIds)
      ..writeByte(10)
      ..write(obj.backdropPath)
      ..writeByte(11)
      ..write(obj.adult)
      ..writeByte(12)
      ..write(obj.overview)
      ..writeByte(13)
      ..write(obj.releaseDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
