import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NumberTrivia extends Equatable {
  final String text;
  final int number;

  const NumberTrivia({
    @required required this.text,
    @required required this.number,
  }) : super();

  @override
  List<Object> get props => [text, number];
}
