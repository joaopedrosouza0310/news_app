import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T, E> with _$Result<T, E> {
  factory Result.data(T value) = ResultData;
  factory Result.error(E error) = ResponseError;
}
