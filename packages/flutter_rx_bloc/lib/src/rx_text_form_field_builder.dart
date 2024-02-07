part of 'rx_form_field_builder.dart';

///the builder function
typedef RxTextFormFieldBuilderFunction<B extends RxBlocTypeBase> = Widget
    Function(RxTextFormFieldBuilderState<B> fieldState);

///the behaviour for when the text is changed by the reactive stream
enum RxTextFormFieldCursorBehaviour {
  ///when the text is changed by the stream,
  ///the cursor would jump to the start
  start,

  ///when the text is changed by the stream,
  ///the cursor would keep it's previous position
  preserve,

  ///when the text is changed by the stream,
  ///the cursor would jump to the end
  end,
}

///   [RxTextFormFieldBuilder] is a [RxFormFieldBuilder] which specializes
/// in building text form fields with reactive streams, it handles the most
/// important parts of managing a text field's state.
///
///   It requires a [state] callback, which returns a [Stream] of values,
/// and can emmit errors which have to be of type [RxFieldException].
///   - If the value [Stream] emits a value, that value is loaded into
///     the [controller].
///
///   - If the value [Stream] emits an error of type [RxFieldException]
///     the value from the exception is loaded into the controller,
///     and the error string is loaded into the decoration which is later
///     provided to the builder function trough the field state
///
///   It requires a [showErrorState] callback, which returns a [Stream] of
/// boolean values which determine when it is time to show any potential errors.
///   !The stream provided by [showErrorState] must never emmit an error.
///
///   A [builder] function is required, this is a function which gives you
/// access to the current field state, and must return a [Widget].
///
///   A [onChanged] callback is required, this function is called every time
/// the [controller] receives a change from the generated text form field,
/// to which the controller should be provided. It provides a bloc instance and
/// the current value from the [state] stream.
///
///   An optional [decorationData] of type [RxInputDecorationData]
/// can be provided, if it isn't a default one is used.
///
///   An optional [controller] can be provided, if it isn't
/// an internal one is created and managed.
///
///   The optional [obscureText] field is a boolean value which determines
/// whether or not the text field should be obscured. If it is set
/// the text field starts off as obscured, and the generated decoration provided
/// to the [builder] gets filled in with a trailing icon from
/// [RxInputDecorationData], after that obscureText changes are automatically
/// managed in response to taps on the trailing icon.
///
///   You can optionally provide an [RxBloc] to the [bloc] field, if you do
/// the provided bloc would be used, otherwise [RxTextFormFieldBuilder]
/// automatically searches for and uses the closest instance up the widget tree
/// of [RxBloc] of type [B].
///
///  This example shows general use.
///
///  ```dart
///  Widget build(BuildContext context) =>
///      RxTextFormFieldBuilder<EditProfileBlocType>(
///        state: (bloc) => bloc.states.name,
///        showErrorState: (bloc) => bloc.states.showErrors,
///        onChanged: (bloc, value) => bloc.events.setName(value),
///        builder: (fieldState) => TextFormField(
///          //use the controller from the fieldState
///          controller: fieldState.controller,
///          //copy the decoration generated by the builder widget, which
///          //contains stuff like when to show errors, with additional
///          //decoration
///          decoration: fieldState.decoration
///              .copyWithDecoration(InputStyles.textFieldDecoration),
///        ),
///      );
///  ```
///
///  This example shows how to create a password field.
///
///  ```dart
///  Widget build(BuildContext context) =>
///      RxTextFormFieldBuilder<LoginBlocType>(
///        state: (bloc) => bloc.states.password,
///        showErrorState: (bloc) => bloc.states.showErrors,
///        onChanged: (bloc, value) => bloc.events.setPassword(value),
///        decorationData: InputStyles.passwordFieldDecorationData, //extra decoration for the field
///        obscureText: true, //tell the password field that it should be obscured
///        builder: (fieldState) => TextFormField(
///          //use the controller from the fieldState
///          controller: fieldState.controller,
///          //use the isTextObscured field from fieldState to determine
///          //when the text should be obscured. The isTextObscured field
///          //automatically changes in response to taps on the suffix icon.
///          //how the suffix icon looks is determined by the iconVisibility
///          //and iconVisibilityOff properties of the decorationData.
///          obscureText: fieldState.isTextObscured,
///          //copy the decoration generated by the builder widget, which
///          //contains stuff like when to show errors, with additional
///          //decoration
///          decoration: fieldState.decoration
///              .copyWithDecoration(InputStyles.passwordFieldDecoration),
///        ),
///      );
///  ```
class RxTextFormFieldBuilder<B extends RxBlocTypeBase>
    extends RxFormFieldBuilder<B, String> {
  ///The default constructor
  RxTextFormFieldBuilder({
    required RxFormFieldState<B, String> state,
    required RxFormFieldShowError<B> showErrorState,
    required RxTextFormFieldBuilderFunction<B> builder,
    required this.onChanged,
    this.decorationData = const RxInputDecorationData(),
    this.controller,
    this.obscureText = false,
    this.cursorBehaviour = RxTextFormFieldCursorBehaviour.start,
    B? bloc,
    Key? key,
  })  : textFormBuilder = builder,
        super(
          key: key,
          state: state,
          showErrorState: showErrorState,
          builder: (_) => Container(),
          bloc: bloc,
        );

  ///   A [onChanged] callback is required, this function is called every time
  /// the [controller] receives a change from the generated text form field,
  /// to which the controller should be provided. It provides a bloc instance
  /// and the current value from the [state] stream.
  final RxFormFieldOnChanged<B, String> onChanged;

  ///   A [builder] function is required, this is a function which gives you
  /// access to the current field state, and must return a [Widget].
  final RxTextFormFieldBuilderFunction<B> textFormBuilder;

  ///   An optional [controller] can be provided, if it isn't
  /// an internal one is created and managed.
  final TextEditingController? controller;

  ///   the cursor behaviour for when the text is changed by the [state] stream
  final RxTextFormFieldCursorBehaviour cursorBehaviour;

  ///   The optional [obscureText] field is a boolean value which determines
  /// whether or not the text field should be obscured. If it is set
  /// the text field starts off as obscured, and the generated decoration
  /// provided to the [builder] gets filled in with a trailing icon from
  /// [RxInputDecorationData], after that obscureText changes are automatically
  /// managed in response to taps on the trailing icon.
  final bool obscureText;

  ///   An optional [decorationData] of type [RxInputDecorationData]
  /// can be provided, if it isn't a default one is used.
  final RxInputDecorationData decorationData;

  @override
  RxTextFormFieldBuilderState createState() => RxTextFormFieldBuilderState<B>();
}

/// [RxTextFormFieldBuilderState] is the state provided to the widget's
/// builder function. It provides the same fields as [RxFormFieldBuilderState],
/// as well as some additional ones for managing text field states.
class RxTextFormFieldBuilderState<B extends RxBlocTypeBase>
    extends RxFormFieldBuilderState<B, String, RxTextFormFieldBuilder<B>> {
  late final bool _shouldDisposeController = widget.controller == null;

  late bool _isTextObscured = widget.obscureText;

  late InputDecoration _decoration;

  final _controllerValueStream = BehaviorSubject<String>();

  ///   [controller] is the [TextEditingController] which should be used by the
  /// text field created in the builder function.
  late final TextEditingController controller =
      widget.controller ?? TextEditingController();

  ///   [isTextObscured] determines weather or not the text in the text field
  /// should be obscured at any given moment, if obscureText is set in the
  /// widget constructor, this value changes depending on user interaction
  /// with the trailing icon of the generated [decoration] which is provided
  /// to the builder.
  bool get isTextObscured => _isTextObscured;

  ///   [decoration] is a decoration which gets generated based on the state of
  /// this widget. It should be used to decorate the generated text field,
  /// use [InputDecoration.copyWith] or the copyWithDecoration extension, to
  /// add additional decoration.
  ///
  ///   - If [showError] is set and there is a non null [error], the
  ///   [InputDecoration.errorText] field would be set to that error.
  ///
  ///   - If [RxTextFormFieldBuilder.obscureText] is set, then the
  ///   [InputDecoration.suffixIcon] would be either set to
  ///   [RxInputDecorationData.iconVisibility] or
  ///   [RxInputDecorationData.iconVisibilityOff] depending on the state of
  ///   [isTextObscured]
  InputDecoration get decoration => _decoration;

  @override
  void initState() {
    super.initState();

    assert(
      _blocState.isBroadcast,
      'state passed to [RxTextFormFieldBuilder], '
      'should be a broadcast stream',
    );

    controller.addListener(() {
      _controllerValueStream.add(controller.text);
    });

    _controllerValueStream
        .distinct()
        .listen((event) => widget.onChanged(bloc, event))
        .addTo(_compositeSubscription);

    (_blocState as Stream<String>)
        .where((event) => event != controller.text)
        .listen(
          _onBlocStateEvent,
          onError: (exception) {},
        )
        .addTo(_compositeSubscription);
  }

  void _onBlocStateEvent(String newValue) {
    switch (widget.cursorBehaviour) {
      case RxTextFormFieldCursorBehaviour.start:
        controller.text = newValue;
        break;
      case RxTextFormFieldCursorBehaviour.preserve:
        controller.value = TextEditingValue(
          text: newValue,
          selection: newValue.length < controller.value.selection.end
              ? TextSelection.collapsed(offset: newValue.length)
              : controller.value.selection,
          composing: TextRange.empty,
        );
        break;
      case RxTextFormFieldCursorBehaviour.end:
        controller.value = TextEditingValue(
          text: newValue,
          selection: TextSelection.collapsed(offset: newValue.length),
          composing: TextRange.empty,
        );
        break;
    }
  }

  @override
  void dispose() {
    if (_shouldDisposeController) controller.dispose();
    _controllerValueStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _decoration = _makeDecoration(showError, error);
    return widget.textFormBuilder(this);
  }

  InputDecoration _makeDecoration(bool showError, String? error) =>
      InputDecoration(
        labelStyle: !showError
            ? widget.decorationData.labelStyle
            : widget.decorationData.labelStyleError,
        suffixIcon: widget.obscureText
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _isTextObscured = !_isTextObscured;
                  });
                },
                child: _isTextObscured
                    ? widget.decorationData.iconVisibility
                    : widget.decorationData.iconVisibilityOff,
              )
            : null,
        errorText: showError ? error : null,
      );
}
