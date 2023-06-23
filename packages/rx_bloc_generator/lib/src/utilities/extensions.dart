part of rx_bloc_generator;

/// Dart emitter instance
final _emitter =
    DartEmitter(allocator: Allocator.none, useNullSafetySyntax: true);

/// Supported types of streams
class _BlocEventStreamTypes {
  /// Constants feel more comfortable than strings
  static const String publish = 'PublishSubject';
  static const String behavior = 'BehaviorSubject';
}

/// String utilities
extension _StringExtensions on String {
  /// Capitalizes the first letter of the word
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';

  /// Converts string to red string when printed in terminal
  String toRedString() => '\x1B[31m$this\x1B[0m';
}

/// It is the main [DartFormatter]
extension _SpecExtensions on Spec {
  String toDartCodeString() => DartFormatter().format(
        accept(
          _emitter,
        ).toString(),
      );
}

extension _StateFieldElement on FieldElement {
  String get stateFieldName => '_${name}State';

  String get stateMethodName => '_mapTo${name.capitalize()}State';
}

extension _EventMethodElement on MethodElement {
  /// The event field name in the generated file
  String get eventFieldName => '_\$${name}Event';

  /// Is the the [RxBlocEvent.seed] annotation is provided
  bool get hasSeedAnnotation => RegExp(r'(?<=seed: ).*(?=\)|,)')
      .hasMatch(_rxBlocEventAnnotation?.toSource() ?? '');

  /// Provides the stream generic type
  ///
  /// Example:
  /// if `fetchNews(int param)` then -> PublishSubject<int>
  /// if `fetchNews(String param)` then -> PublishSubject<String>
  /// if `fetchNews(int p1, int p2)` then -> PublishSubject<_FetchNewsEventArgs>
  List<Reference> get streamTypeArguments => [refer(publishSubjectGenericType)];

  /// Provides the BehaviorSubject.seeded arguments as [List] of [Expression]
  /// Throws an [_RxBlocGeneratorException] if a seed is provided but
  /// the stream is not  [RxBlocEventType.behaviour]
  List<Expression> get seedPositionalArguments {
    if (hasSeedAnnotation && !isBehavior) {
      throw _RxBlocGeneratorException('Event `$name` with type `PublishSubject`'
          ' can not have a `seed` parameter.');
    }

    return [_seededArgument];
  }

  /// Provides the BehaviorSubject.seeded arguments as an [Expression]
  Expression get _seededArgument {
    var seedArgumentsMatch = RegExp(r'(?<=seed: ).*(?=\)|,)')
        .allMatches(_rxBlocEventAnnotation?.toSource() ?? '')
        .map<String>((m) => m.group(0) ?? '');

    if (seedArgumentsMatch.isEmpty) {
      throw _RxBlocGeneratorException(
          'Event `$name` seed value is missing or is null.');
    }

    var seedArguments = seedArgumentsMatch.toString();
    return refer(
      // ignore: lines_longer_than_80_chars
      '${isUsingRecord && !seedArguments.contains('(const') ? 'const ' : ''}'
      '${seedArguments.substring(1, seedArguments.length - 1)}',
    );
  }

  /// Provides the stream type based on the [RxBlocEventType] annotation
  String get eventStreamType => isBehavior
      ? _BlocEventStreamTypes.behavior +
          (hasSeedAnnotation ? '<$publishSubjectGenericType>' : '')
      : _BlocEventStreamTypes.publish;

  /// Provides the first annotation as [ElementAnnotation] if exists
  ElementAnnotation? get _eventAnnotation => metadata.firstOrNull;

  /// Provides the [RxBlocEvent] annotation as [DartObject] if exists
  DartObject? get _computedRxBlocEventAnnotation =>
      _rxBlocEventAnnotation?.computeConstantValue();

  /// Provides the [RxBlocEvent] annotation as [ElementAnnotation] if exists
  ElementAnnotation? get _rxBlocEventAnnotation => _eventAnnotation
              ?.computeConstantValue()
              ?.type
              ?.getDisplayString(withNullability: true) ==
          (RxBlocEvent).toString()
      ? _eventAnnotation
      : null;

  /// Is the event stream type a BehaviorSubject
  bool get isBehavior =>
      _computedRxBlocEventAnnotation.toString().contains('behaviour');

  /// Provides the stream type based on the number of the parameters
  /// Example:
  /// if `fetchNews(int param)` then -> int
  /// if `fetchNews(String param)` then -> String
  /// if `fetchNews(int param1, int param2)` -> _FetchNewsEventArgs
  String get publishSubjectGenericType {
    if (isUsingRecord) {
      return recordType;
    }
    return parameters.isNotEmpty
        // The only parameter's type
        ? parameters.first.type.getDisplayString(withNullability: true)
        // Default type
        : 'void';
  }

  /// Builds the stream body
  /// Example 1:
  /// _${EventMethodName}EventName.add(param)
  ///
  /// Example 2:
  /// _${EventMethodName}EventName.add(_MethodEventArgs(param1, param2))
  ///
  Code buildBody() {
    var requiredParams = parameters.whereRequired().clone();
    var optionalParams = parameters.whereOptional().clone();

    if (requiredParams.isEmpty && optionalParams.isEmpty) {
      // Provide null if we don't have any parameters
      return _callStreamAddMethod(literalNull);
    }

    // Provide the first if it's just one required parameter
    if (optionalParams.isEmpty && requiredParams.length == 1) {
      return _callStreamAddMethod(refer(requiredParams.first.name));
    }

    // Provide the first if it's just one optional parameter
    if (requiredParams.isEmpty && optionalParams.length == 1) {
      return _callStreamAddMethod(refer(optionalParams.first.name));
    }

    return _callStreamAddMethod(recordInstanceWithParameters);
  }

  /// Example:
  /// _${methodName}Event.add()
  Code _callStreamAddMethod(Expression argument) =>
      refer('$eventFieldName.add').call([argument]).code;
}

extension _EventMethodNamedRecordArgument on MethodElement {
  /// Use named record as wrapper when the event's parameters are more than 1
  bool get isUsingRecord => parameters.length > 1;

  /// The type of record used to wrap the method parameters
  ///
  ///   Example:
  ///   `BehaviorSubject<({int x, int y})>()`
  String get recordType {
    assert(isUsingRecord);
    final entries = parameters.map((p) {
      return MapEntry(p.name, refer(p.getTypeDisplayName()));
    });
    final record = RecordType((b) => b..namedFieldTypes.addEntries(entries));
    return record.accept(_emitter).toString();
  }

  /// The record instance with parameter values
  /// passed to the stream's `add` method
  ///
  ///   Example:
  ///   `_$generatedSubject.add((x: x, y: y))`
  CodeExpression get recordInstanceWithParameters {
    assert(isUsingRecord);
    final pairs = parameters.map((p) => '${p.name}: ${p.name}').join(', ');
    return CodeExpression(Code('($pairs,)'));
  }

  String get recordTypeDefName => '_${name.capitalize()}EventArgs';
}

extension _ListParameterElementWhere on List<ParameterElement> {
  Iterable<ParameterElement> whereRequired() => where(
      (parameter) => !parameter.isNamed && !parameter.isOptionalPositional);

  Iterable<ParameterElement> whereOptional() =>
      where((parameter) => parameter.isOptionalPositional || parameter.isNamed);
}

extension _ListParameterElementClone on Iterable<ParameterElement> {
  List<Parameter> clone({bool toThis = false}) => map(
        (ParameterElement parameter) => Parameter(
          (b) => b
            ..toThis = toThis
            ..required = parameter.isRequiredNamed
            ..defaultTo = parameter.defaultValueCode != null
                ? Code(parameter.defaultValueCode ?? '')
                : null
            ..named = parameter.isNamed
            ..name = parameter.name
            ..type = toThis
                ? null // We don't need the type in the constructor
                : refer(parameter.getTypeDisplayName()),
        ),
      ).toList();
}

extension _ParameterElementToString on ParameterElement {
  String getTypeDisplayName() => type.getDisplayString(withNullability: true);
}
