// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'package:flutter/services.dart'
    show TextInputType, TextInputAction, TextCapitalization;

export 'package:flutter/services.dart'
    show TextEditingValue, TextSelection, TextInputType;
export 'package:flutter/rendering.dart' show SelectionChangedCause;

/// Signature for the callback that reports when the user changes the selection
/// (including the cursor location).
typedef void SelectionChangedCallback(
    TextSelection selection, SelectionChangedCause cause);

const Duration _kCursorBlinkHalfPeriod = Duration(milliseconds: 500);

// Number of cursor ticks during which the most recently entered character
// is shown in an obscured text field.
const int _kObscureShowLatestCharCursorTicks = 3;

/// A basic text input field.
///
/// This widget interacts with the [TextInput] service to let the user edit the
/// text it contains. It also provides scrolling, selection, and cursor
/// movement. This widget does not provide any focus management (e.g.,
/// tap-to-focus).
///
/// ## Input Actions
///
/// A [TextInputAction] can be provided to customize the appearance of the
/// action button on the soft keyboard for Android and iOS. The default action
/// is [TextInputAction.done].
///
/// Many [TextInputAction]s are common between Android and iOS. However, if an
/// [inputAction] is provided that is not supported by the current
/// platform in debug mode, an error will be thrown when the corresponding
/// EditableText receives focus. For example, providing iOS's "emergencyCall"
/// action when running on an Android device will result in an error when in
/// debug mode. In release mode, incompatible [TextInputAction]s are replaced
/// either with "unspecified" on Android, or "default" on iOS. Appropriate
/// [inputAction]s can be chosen by checking the current platform and then
/// selecting the appropriate action.
///
/// ## Lifecycle
///
/// Upon completion of editing, like pressing the "done" button on the keyboard,
/// two actions take place:
///
///   1st: Editing is finalized. The default behavior of this step includes
///   an invocation of [onChanged]. That default behavior can be overridden.
///   See [onEditingComplete] for details.
///
///   2nd: [onSubmitted] is invoked with the user's input value.
///
/// [onSubmitted] can be used to manually move focus to another input widget
/// when a user finishes with the currently focused input widget.
///
/// Rather than using this widget directly, consider using [TextField], which
/// is a full-featured, material-design text input field with placeholder text,
/// labels, and [Form] integration.
///
/// See also:
///
///  * [TextField], which is a full-featured, material-design text input field
///    with placeholder text, labels, and [Form] integration.
class SelectableText extends StatefulWidget {
  /// Creates a basic text input control.
  ///
  /// The [maxLines] property can be set to null to remove the restriction on
  /// the number of lines. By default, it is one, meaning this is a single-line
  /// text field. [maxLines] must be null or greater than zero.
  ///
  /// If [keyboardType] is not set or is null, it will default to
  /// [TextInputType.text] unless [maxLines] is greater than one, when it will
  /// default to [TextInputType.multiline].
  ///
  /// The [controller], [focusNode], [style], [cursorColor], [textAlign],
  /// and [rendererIgnoresPointer], arguments must not be null.
  SelectableText({
    Key key,
    @required this.controller,
    @required this.focusNode,
    this.obscureText = false,
    this.autocorrect = true,
    @required this.style,
    @required this.cursorColor,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.maxLines = 1,
    this.autofocus = false,
    this.selectionColor,
    this.selectionControls,
    TextInputType keyboardType,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onSelectionChanged,
    List<TextInputFormatter> inputFormatters,
    this.rendererIgnoresPointer = false,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.keyboardAppearance = Brightness.light,
  })  : assert(controller != null),
        assert(focusNode != null),
        assert(obscureText != null),
        assert(autocorrect != null),
        assert(style != null),
        assert(cursorColor != null),
        assert(textAlign != null),
        assert(maxLines == null || maxLines > 0),
        assert(autofocus != null),
        assert(rendererIgnoresPointer != null),
        assert(scrollPadding != null),
        keyboardType = keyboardType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        inputFormatters = maxLines == 1
            ? (<TextInputFormatter>[
                BlacklistingTextInputFormatter.singleLineFormatter
              ]..addAll(
                inputFormatters ?? const Iterable<TextInputFormatter>.empty()))
            : inputFormatters,
        super(key: key);

  /// Controls the text being edited.
  final TextEditingController controller;

  /// Controls whether this widget has keyboard focus.
  final FocusNode focusNode;

  /// Whether to hide the text being edited (e.g., for passwords).
  ///
  /// Defaults to false.
  final bool obscureText;

  /// Whether to enable autocorrection.
  ///
  /// Defaults to true.
  final bool autocorrect;

  /// The text style to use for the editable text.
  final TextStyle style;

  /// How the text should be aligned horizontally.
  ///
  /// Defaults to [TextAlign.start].
  final TextAlign textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the text is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection textDirection;

  /// Configures how the platform keyboard will select an uppercase or
  /// lowercase keyboard.
  ///
  /// Only supports text keyboards, other keyboard types will ignore this
  /// configuration. Capitalization is locale-aware.
  ///
  /// Defaults to [TextCapitalization.none]. Must not be null.
  ///
  /// See also:
  ///
  ///   * [TextCapitalization], for a description of each capitalization behavior.
  final TextCapitalization textCapitalization;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderEditable.locale] for more information.
  final Locale locale;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  ///
  /// Defaults to the [MediaQueryData.textScaleFactor] obtained from the ambient
  /// [MediaQuery], or 1.0 if there is no [MediaQuery] in scope.
  final double textScaleFactor;

  /// The color to use when painting the cursor.
  final Color cursorColor;

  /// The maximum number of lines for the text to span, wrapping if necessary.
  ///
  /// If this is 1 (the default), the text will not wrap, but will scroll
  /// horizontally instead.
  ///
  /// If this is null, there is no limit to the number of lines. If it is not
  /// null, the value must be greater than zero.
  final int maxLines;

  /// Whether this input field should focus itself if nothing else is already focused.
  /// If true, the keyboard will open as soon as this input obtains focus. Otherwise,
  /// the keyboard is only shown after the user taps the text field.
  ///
  /// Defaults to false.
  final bool autofocus;

  /// The color to use when painting the selection.
  final Color selectionColor;

  /// Optional delegate for building the text selection handles and toolbar.
  final TextSelectionControls selectionControls;

  /// The type of keyboard to use for editing the text.
  final TextInputType keyboardType;

  /// The type of action button to use with the soft keyboard.
  final TextInputAction textInputAction;

  /// Called when the text being edited changes.
  final ValueChanged<String> onChanged;

  /// Called when the user submits editable content (e.g., user presses the "done"
  /// button on the keyboard).
  ///
  /// The default implementation of [onEditingComplete] executes 2 different
  /// behaviors based on the situation:
  ///
  ///  - When a completion action is pressed, such as "done", "go", "send", or
  ///    "search", the user's content is submitted to the [controller] and then
  ///    focus is given up.
  ///
  ///  - When a non-completion action is pressed, such as "next" or "previous",
  ///    the user's content is submitted to the [controller], but focus is not
  ///    given up because developers may want to immediately move focus to
  ///    another input widget within [onSubmitted].
  ///
  /// Providing [onEditingComplete] prevents the aforementioned default behavior.
  final VoidCallback onEditingComplete;

  /// Called when the user indicates that they are done editing the text in the field.
  final ValueChanged<String> onSubmitted;

  /// Called when the user changes the selection of text (including the cursor
  /// location).
  final SelectionChangedCallback onSelectionChanged;

  /// Optional input validation and formatting overrides. Formatters are run
  /// in the provided order when the text input changes.
  final List<TextInputFormatter> inputFormatters;

  /// If true, the [RenderEditable] created by this widget will not handle
  /// pointer events, see [renderEditable] and [RenderEditable.ignorePointer].
  ///
  /// This property is false by default.
  final bool rendererIgnoresPointer;

  /// How thick the cursor will be.
  ///
  /// Defaults to 2.0
  final double cursorWidth;

  /// How rounded the corners of the cursor should be.
  ///
  /// By default, the cursor has a Radius of zero.
  final Radius cursorRadius;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// Defaults to [Brightness.light].
  final Brightness keyboardAppearance;

  /// Configures padding to edges surrounding a [Scrollable] when the Textfield scrolls into view.
  ///
  /// When this widget receives focus and is not completely visible (for example scrolled partially
  /// off the screen or overlapped by the keyboard)
  /// then it will attempt to make itself visible by scrolling a surrounding [Scrollable], if one is present.
  /// This value controls how far from the edges of a [Scrollable] the TextField will be positioned after the scroll.
  ///
  /// Defaults to EdgeInserts.all(20.0).
  final EdgeInsets scrollPadding;

  /// Setting this property to true makes the cursor stop blinking and stay visible on the screen continually.
  /// This property is most useful for testing purposes.
  ///
  /// Defaults to false, resulting in a typical blinking cursor.
  static bool debugDeterministicCursor = false;

  @override
  SelectableTextState createState() => new SelectableTextState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(new DiagnosticsProperty<TextEditingController>(
        'controller', controller));
    properties.add(new DiagnosticsProperty<FocusNode>('focusNode', focusNode));
    properties.add(new DiagnosticsProperty<bool>('obscureText', obscureText,
        defaultValue: false));
    properties.add(new DiagnosticsProperty<bool>('autocorrect', autocorrect,
        defaultValue: true));
    style?.debugFillProperties(properties);
    properties.add(new EnumProperty<TextAlign>('textAlign', textAlign,
        defaultValue: null));
    properties.add(new EnumProperty<TextDirection>(
        'textDirection', textDirection,
        defaultValue: null));
    properties.add(
        new DiagnosticsProperty<Locale>('locale', locale, defaultValue: null));
    properties.add(new DoubleProperty('textScaleFactor', textScaleFactor,
        defaultValue: null));
    properties.add(new IntProperty('maxLines', maxLines, defaultValue: 1));
    properties.add(new DiagnosticsProperty<bool>('autofocus', autofocus,
        defaultValue: false));
    properties.add(new DiagnosticsProperty<TextInputType>(
        'keyboardType', keyboardType,
        defaultValue: null));
  }
}

/// State for a [EditableText].
class SelectableTextState extends State<SelectableText>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver
    implements TextInputClient, TextSelectionDelegate {
  Timer _cursorTimer;
  final ValueNotifier<bool> _showCursor = new ValueNotifier<bool>(false);
  final GlobalKey _selectableKey = new GlobalKey();

  // TextInputConnection _textInputConnection;
  TextSelectionOverlay _selectionOverlay;

  final ScrollController _scrollController = new ScrollController();
  final LayerLink _layerLink = new LayerLink();
  bool _didAutoFocus = false;

  @override
  bool get wantKeepAlive => widget.focusNode.hasFocus;

  // State lifecycle:

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_didChangeTextEditingValue);
    widget.focusNode.addListener(_handleFocusChanged);
    _scrollController.addListener(() {
      _selectionOverlay?.updateForScroll();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didAutoFocus && widget.autofocus) {
      FocusScope.of(context).autofocus(widget.focusNode);
      _didAutoFocus = true;
    }
  }

  @override
  void didUpdateWidget(SelectableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_didChangeTextEditingValue);
      widget.controller.addListener(_didChangeTextEditingValue);
      _updateRemoteEditingValueIfNeeded();
    }
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode.removeListener(_handleFocusChanged);
      widget.focusNode.addListener(_handleFocusChanged);
      updateKeepAlive();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_didChangeTextEditingValue);
    // _closeInputConnectionIfNeeded();
    // assert(!_hasInputConnection);
    _stopCursorTimer();
    assert(_cursorTimer == null);
    _selectionOverlay?.dispose();
    _selectionOverlay = null;
    widget.focusNode.removeListener(_handleFocusChanged);
    super.dispose();
  }

  // TextInputClient implementation:

  TextEditingValue _lastKnownRemoteTextEditingValue;

  @override
  void updateEditingValue(TextEditingValue value) {
    if (value.text != _value.text) {
      _hideSelectionOverlayIfNeeded();
      _showCaretOnScreen();
      if (widget.obscureText && value.text.length == _value.text.length + 1) {
        _obscureShowCharTicksPending = _kObscureShowLatestCharCursorTicks;
        _obscureLatestCharIndex = _value.selection.baseOffset;
      }
    }
    _lastKnownRemoteTextEditingValue = value;
    _formatAndSetValue(value);
  }

  @override
  void performAction(TextInputAction action) {
    switch (action) {
      case TextInputAction.newline:
        // Do nothing for a "newline" action: the newline is already inserted.
        break;
      case TextInputAction.done:
      case TextInputAction.go:
      case TextInputAction.send:
      case TextInputAction.search:
        // Take any actions necessary now that the user has completed editing.
        if (widget.onEditingComplete != null) {
          widget.onEditingComplete();
        } else {
          // Default behavior if the developer did not provide an
          // onEditingComplete callback: Finalize editing and remove focus.
          widget.controller.clearComposing();
          widget.focusNode.unfocus();
        }

        // Invoke optional callback with the user's submitted content.
        if (widget.onSubmitted != null) widget.onSubmitted(_value.text);
        break;
      default:
        if (widget.onEditingComplete != null) {
          widget.onEditingComplete();
        } else {
          // Default behavior if the developer did not provide an
          // onEditingComplete callback: Finalize editing, but don't give up
          // focus because this keyboard action does not imply the user is done
          // inputting information.
          widget.controller.clearComposing();
        }

        // Invoke optional callback with the user's submitted content.
        if (widget.onSubmitted != null) widget.onSubmitted(_value.text);
        break;
    }
  }

  void _updateRemoteEditingValueIfNeeded() {
    // if (!_hasInputConnection)
    //   return;
    final TextEditingValue localValue = _value;
    if (localValue == _lastKnownRemoteTextEditingValue) return;
    _lastKnownRemoteTextEditingValue = localValue;
    // _textInputConnection.setEditingState(localValue);
  }

  TextEditingValue get _value => widget.controller.value;
  set _value(TextEditingValue value) {
    widget.controller.value = value;
  }

  bool get _hasFocus => widget.focusNode.hasFocus;
  bool get _isMultiline => widget.maxLines != 1;

  // Calculate the new scroll offset so the cursor remains visible.
  double _getScrollOffsetForCaret(Rect caretRect) {
    final double caretStart = _isMultiline ? caretRect.top : caretRect.left;
    final double caretEnd = _isMultiline ? caretRect.bottom : caretRect.right;
    double scrollOffset = _scrollController.offset;
    final double viewportExtent = _scrollController.position.viewportDimension;
    if (caretStart < 0.0) // cursor before start of bounds
      scrollOffset += caretStart;
    else if (caretEnd >= viewportExtent) // cursor after end of bounds
      scrollOffset += caretEnd - viewportExtent;
    return scrollOffset;
  }

  // Calculates where the `caretRect` would be if `_scrollController.offset` is set to `scrollOffset`.
  Rect _getCaretRectAtScrollOffset(Rect caretRect, double scrollOffset) {
    final double offsetDiff = _scrollController.offset - scrollOffset;
    return _isMultiline
        ? caretRect.translate(0.0, offsetDiff)
        : caretRect.translate(offsetDiff, 0.0);
  }

  // bool get _hasInputConnection => _textInputConnection != null && _textInputConnection.attached;

  // void _openInputConnection() {
  //   if (!_hasInputConnection) {
  //     final TextEditingValue localValue = _value;
  //     _lastKnownRemoteTextEditingValue = localValue;
  //     _textInputConnection = TextInput.attach(this,
  //         new TextInputConfiguration(
  //             inputType: widget.keyboardType,
  //             obscureText: widget.obscureText,
  //             autocorrect: widget.autocorrect,
  //             inputAction: widget.keyboardType == TextInputType.multiline
  //                 ? TextInputAction.newline
  //                 : widget.textInputAction,
  //             textCapitalization: widget.textCapitalization,
  //         )
  //     )..setEditingState(localValue);
  //   }
  //   _textInputConnection.show();
  // }

  // void _closeInputConnectionIfNeeded() {
  //   if (_hasInputConnection) {
  //     _textInputConnection.close();
  //     _textInputConnection = null;
  //     _lastKnownRemoteTextEditingValue = null;
  //   }
  // }

  void _openOrCloseInputConnectionIfNeeded() {
    /*if (_hasFocus && widget.focusNode.consumeKeyboardToken()) {
      _openInputConnection();
    } else */
    if (!_hasFocus) {
      // _closeInputConnectionIfNeeded();
      widget.controller.clearComposing();
    }
  }

  /// Express interest in interacting with the keyboard.
  ///
  /// If this control is already attached to the keyboard, this function will
  /// request that the keyboard become visible. Otherwise, this function will
  /// ask the focus system that it become focused. If successful in acquiring
  /// focus, the control will then attach to the keyboard and request that the
  /// keyboard become visible.
  void requestKeyboard() {
    // if (_hasFocus)
    //   _openInputConnection();
    // else
    if (!_hasFocus) FocusScope.of(context).requestFocus(widget.focusNode);
  }

  void _hideSelectionOverlayIfNeeded() {
    _selectionOverlay?.hide();
    _selectionOverlay = null;
  }

  void _updateOrDisposeSelectionOverlayIfNeeded() {
    if (_selectionOverlay != null) {
      if (_hasFocus) {
        _selectionOverlay.update(_value);
      } else {
        _selectionOverlay.dispose();
        _selectionOverlay = null;
      }
    }
  }

  void _handleSelectionChanged(TextSelection selection,
      RenderEditable renderObject, SelectionChangedCause cause) {
    widget.controller.selection = selection;

    // This will show the keyboard for all selection changes on the
    // EditableWidget, not just changes triggered by user gestures.
    requestKeyboard();

    _hideSelectionOverlayIfNeeded();

    if (widget.selectionControls != null) {
      _selectionOverlay = new TextSelectionOverlay(
        context: context,
        value: _value,
        debugRequiredFor: widget,
        layerLink: _layerLink,
        renderObject: renderObject,
        selectionControls: widget.selectionControls,
        selectionDelegate: this,
      );
      final bool longPress = cause == SelectionChangedCause.longPress;
      if (cause != SelectionChangedCause.keyboard &&
          (_value.text.isNotEmpty || longPress))
        _selectionOverlay.showHandles();
      if (longPress) _selectionOverlay.showToolbar();
      if (widget.onSelectionChanged != null)
        widget.onSelectionChanged(selection, cause);
    }
  }

  bool _textChangedSinceLastCaretUpdate = false;
  Rect _currentCaretRect;

  void _handleCaretChanged(Rect caretRect) {
    _currentCaretRect = caretRect;
    // If the caret location has changed due to an update to the text or
    // selection, then scroll the caret into view.
    if (_textChangedSinceLastCaretUpdate) {
      _textChangedSinceLastCaretUpdate = false;
      _showCaretOnScreen();
    }
  }

  // Animation configuration for scrolling the caret back on screen.
  static const Duration _caretAnimationDuration = Duration(milliseconds: 100);
  static const Curve _caretAnimationCurve = Curves.fastOutSlowIn;

  bool _showCaretOnScreenScheduled = false;

  void _showCaretOnScreen() {
    if (_showCaretOnScreenScheduled) {
      return;
    }
    _showCaretOnScreenScheduled = true;
    SchedulerBinding.instance.addPostFrameCallback((Duration _) {
      _showCaretOnScreenScheduled = false;
      if (_currentCaretRect == null || !_scrollController.hasClients) {
        return;
      }
      final double scrollOffsetForCaret =
          _getScrollOffsetForCaret(_currentCaretRect);
      _scrollController.animateTo(
        scrollOffsetForCaret,
        duration: _caretAnimationDuration,
        curve: _caretAnimationCurve,
      );
      final Rect newCaretRect =
          _getCaretRectAtScrollOffset(_currentCaretRect, scrollOffsetForCaret);
      // Enlarge newCaretRect by scrollPadding to ensure that caret is not positioned directly at the edge after scrolling.
      final Rect inflatedRect = Rect.fromLTRB(
          newCaretRect.left - widget.scrollPadding.left,
          newCaretRect.top - widget.scrollPadding.top,
          newCaretRect.right + widget.scrollPadding.right,
          newCaretRect.bottom + widget.scrollPadding.bottom);
      _selectableKey.currentContext.findRenderObject().showOnScreen(
            rect: inflatedRect,
            duration: _caretAnimationDuration,
            curve: _caretAnimationCurve,
          );
    });
  }

  double _lastBottomViewInset;

  @override
  void didChangeMetrics() {
    if (_lastBottomViewInset < ui.window.viewInsets.bottom) {
      _showCaretOnScreen();
    }
    _lastBottomViewInset = ui.window.viewInsets.bottom;
  }

  void _formatAndSetValue(TextEditingValue value) {
    final bool textChanged = _value?.text != value?.text;
    if (widget.inputFormatters != null && widget.inputFormatters.isNotEmpty) {
      for (TextInputFormatter formatter in widget.inputFormatters)
        value = formatter.formatEditUpdate(_value, value);
      _value = value;
      _updateRemoteEditingValueIfNeeded();
    } else {
      _value = value;
    }
    if (textChanged && widget.onChanged != null) widget.onChanged(value.text);
  }

  /// Whether the blinking cursor is actually visible at this precise moment
  /// (it's hidden half the time, since it blinks).
  @visibleForTesting
  bool get cursorCurrentlyVisible => _showCursor.value;

  /// The cursor blink interval (the amount of time the cursor is in the "on"
  /// state or the "off" state). A complete cursor blink period is twice this
  /// value (half on, half off).
  @visibleForTesting
  Duration get cursorBlinkInterval => _kCursorBlinkHalfPeriod;

  /// The current status of the text selection handles.
  @visibleForTesting
  TextSelectionOverlay get selectionOverlay => _selectionOverlay;

  int _obscureShowCharTicksPending = 0;
  int _obscureLatestCharIndex;

  void _cursorTick(Timer timer) {
    _showCursor.value = !_showCursor.value;
    if (_obscureShowCharTicksPending > 0) {
      setState(() {
        _obscureShowCharTicksPending--;
      });
    }
  }

  void _startCursorTimer() {
    _showCursor.value = true;
    _cursorTimer = new Timer.periodic(_kCursorBlinkHalfPeriod, _cursorTick);
  }

  void _stopCursorTimer() {
    _cursorTimer?.cancel();
    _cursorTimer = null;
    _showCursor.value = false;
    _obscureShowCharTicksPending = 0;
  }

  void _startOrStopCursorTimerIfNeeded() {
    if (_cursorTimer == null && _hasFocus && _value.selection.isCollapsed)
      _startCursorTimer();
    else if (_cursorTimer != null &&
        (!_hasFocus || !_value.selection.isCollapsed)) _stopCursorTimer();
  }

  void _didChangeTextEditingValue() {
    _updateRemoteEditingValueIfNeeded();
    _startOrStopCursorTimerIfNeeded();
    _updateOrDisposeSelectionOverlayIfNeeded();
    _textChangedSinceLastCaretUpdate = true;
    // TODO(abarth): Teach RenderEditable about ValueNotifier<TextEditingValue>
    // to avoid this setState().
    setState(() {/* We use widget.controller.value in build(). */});
  }

  void _handleFocusChanged() {
    _openOrCloseInputConnectionIfNeeded();
    _startOrStopCursorTimerIfNeeded();
    _updateOrDisposeSelectionOverlayIfNeeded();
    if (_hasFocus) {
      // Listen for changing viewInsets, which indicates keyboard showing up.
      WidgetsBinding.instance.addObserver(this);
      _lastBottomViewInset = ui.window.viewInsets.bottom;
      _showCaretOnScreen();
      if (!_value.selection.isValid) {
        // Place cursor at the end if the selection is invalid when we receive focus.
        widget.controller.selection =
            new TextSelection.collapsed(offset: _value.text.length);
      }
    } else {
      WidgetsBinding.instance.removeObserver(this);
      // Clear the selection and composition state if this widget lost focus.
      _value = new TextEditingValue(text: _value.text);
    }
    updateKeepAlive();
  }

  TextDirection get _textDirection {
    final TextDirection result =
        widget.textDirection ?? Directionality.of(context);
    assert(result != null,
        '$runtimeType created without a textDirection and with no ambient Directionality.');
    return result;
  }

  /// The renderer for this widget's [Editable] descendant.
  ///
  /// This property is typically used to notify the renderer of input gestures
  /// when [ignorePointer] is true. See [RenderEditable.ignorePointer].
  RenderEditable get renderEditable =>
      _selectableKey.currentContext.findRenderObject();

  @override
  TextEditingValue get textEditingValue => _value;

  @override
  set textEditingValue(TextEditingValue value) {
    _selectionOverlay?.update(value);
    _formatAndSetValue(value);
  }

  @override
  void bringIntoView(TextPosition position) {
    _scrollController.jumpTo(_getScrollOffsetForCaret(
        renderEditable.getLocalRectForCaret(position)));
  }

  @override
  void hideToolbar() {
    _selectionOverlay?.hide();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).reparentIfNeeded(widget.focusNode);
    super.build(context); // See AutomaticKeepAliveClientMixin.
    final TextSelectionControls controls = widget.selectionControls;

    return new Scrollable(
      excludeFromSemantics: true,
      axisDirection: _isMultiline ? AxisDirection.down : AxisDirection.right,
      controller: _scrollController,
      physics: const ClampingScrollPhysics(),
      viewportBuilder: (BuildContext context, ViewportOffset offset) {
        return new CompositedTransformTarget(
          link: _layerLink,
          child: new Semantics(
            onCopy: _hasFocus && controls?.canCopy(this) == true
                ? () => controls.handleCopy(this)
                : null,
            onCut: _hasFocus && controls?.canCut(this) == true
                ? () => controls.handleCut(this)
                : null,
            onPaste: _hasFocus && controls?.canPaste(this) == true
                ? () => controls.handlePaste(this)
                : null,
            child: new _Editable(
              key: _selectableKey,
              textSpan: buildTextSpan(),
              value: _value,
              cursorColor: widget.cursorColor,
              showCursor: EditableText.debugDeterministicCursor
                  ? ValueNotifier<bool>(true)
                  : _showCursor,
              hasFocus: _hasFocus,
              maxLines: widget.maxLines,
              selectionColor: widget.selectionColor,
              textScaleFactor: widget.textScaleFactor ??
                  MediaQuery.textScaleFactorOf(context),
              textAlign: widget.textAlign,
              textDirection: _textDirection,
              locale: widget.locale,
              obscureText: widget.obscureText,
              autocorrect: widget.autocorrect,
              offset: offset,
              onSelectionChanged: _handleSelectionChanged,
              onCaretChanged: _handleCaretChanged,
              rendererIgnoresPointer: widget.rendererIgnoresPointer,
              cursorWidth: widget.cursorWidth,
              cursorRadius: widget.cursorRadius,
              textSelectionDelegate: this,
            ),
          ),
        );
      },
    );
  }

  /// Builds [TextSpan] from current editing value.
  ///
  /// By default makes text in composing range appear as underlined.
  /// Descendants can override this method to customize appearance of text.
  TextSpan buildTextSpan() {
    if (!widget.obscureText && _value.composing.isValid) {
      final TextStyle composingStyle = widget.style.merge(
        const TextStyle(decoration: TextDecoration.underline),
      );

      return new TextSpan(style: widget.style, children: <TextSpan>[
        new TextSpan(text: _value.composing.textBefore(_value.text)),
        new TextSpan(
          style: composingStyle,
          text: _value.composing.textInside(_value.text),
        ),
        new TextSpan(text: _value.composing.textAfter(_value.text)),
      ]);
    }

    String text = _value.text;
    if (widget.obscureText) {
      text = RenderEditable.obscuringCharacter * text.length;
      final int o =
          _obscureShowCharTicksPending > 0 ? _obscureLatestCharIndex : null;
      if (o != null && o >= 0 && o < text.length)
        text = text.replaceRange(o, o + 1, _value.text.substring(o, o + 1));
    }
    return new TextSpan(style: widget.style, text: text);
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {
    // TODO: implement updateFloatingCursor
  }
}

class _Editable extends LeafRenderObjectWidget {
  const _Editable({
    Key key,
    this.textSpan,
    this.value,
    this.cursorColor,
    this.showCursor,
    this.hasFocus,
    this.maxLines,
    this.selectionColor,
    this.textScaleFactor,
    this.textAlign,
    @required this.textDirection,
    this.locale,
    this.obscureText,
    this.autocorrect,
    this.offset,
    this.onSelectionChanged,
    this.onCaretChanged,
    this.rendererIgnoresPointer = false,
    this.cursorWidth,
    this.cursorRadius,
    this.textSelectionDelegate,
  })  : assert(textDirection != null),
        assert(rendererIgnoresPointer != null),
        super(key: key);

  final TextSpan textSpan;
  final TextEditingValue value;
  final Color cursorColor;
  final ValueNotifier<bool> showCursor;
  final bool hasFocus;
  final int maxLines;
  final Color selectionColor;
  final double textScaleFactor;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final bool obscureText;
  final bool autocorrect;
  final ViewportOffset offset;
  final SelectionChangedHandler onSelectionChanged;
  final CaretChangedHandler onCaretChanged;
  final bool rendererIgnoresPointer;
  final double cursorWidth;
  final Radius cursorRadius;
  final TextSelectionDelegate textSelectionDelegate;

  @override
  RenderEditable createRenderObject(BuildContext context) {
    return new RenderEditable(
      text: textSpan,
      cursorColor: cursorColor,
      showCursor: showCursor,
      hasFocus: hasFocus,
      maxLines: maxLines,
      selectionColor: selectionColor,
      textScaleFactor: textScaleFactor,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale ?? Localizations.localeOf(context, nullOk: true),
      selection: value.selection,
      offset: offset,
      onSelectionChanged: onSelectionChanged,
      onCaretChanged: onCaretChanged,
      ignorePointer: rendererIgnoresPointer,
      obscureText: obscureText,
      cursorWidth: cursorWidth,
      cursorRadius: cursorRadius,
      textSelectionDelegate: textSelectionDelegate,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderEditable renderObject) {
    renderObject
      ..text = textSpan
      ..cursorColor = cursorColor
      ..showCursor = showCursor
      ..hasFocus = hasFocus
      ..maxLines = maxLines
      ..selectionColor = selectionColor
      ..textScaleFactor = textScaleFactor
      ..textAlign = textAlign
      ..textDirection = textDirection
      ..locale = locale ?? Localizations.localeOf(context, nullOk: true)
      ..selection = value.selection
      ..offset = offset
      ..onSelectionChanged = onSelectionChanged
      ..onCaretChanged = onCaretChanged
      ..ignorePointer = rendererIgnoresPointer
      ..obscureText = obscureText
      ..cursorWidth = cursorWidth
      ..cursorRadius = cursorRadius
      ..textSelectionDelegate = textSelectionDelegate;
  }
}

/// A material design text field.
///
/// A text field lets the user enter text, either with hardware keyboard or with
/// an onscreen keyboard.
///
/// The text field calls the [onChanged] callback whenever the user changes the
/// text in the field. If the user indicates that they are done typing in the
/// field (e.g., by pressing a button on the soft keyboard), the text field
/// calls the [onSubmitted] callback.
///
/// To control the text that is displayed in the text field, use the
/// [controller]. For example, to set the initial value of the text field, use
/// a [controller] that already contains some text. The [controller] can also
/// control the selection and composing region (and to observe changes to the
/// text, selection, and composing region).
///
/// By default, a text field has a [decoration] that draws a divider below the
/// text field. You can use the [decoration] property to control the decoration,
/// for example by adding a label or an icon. If you set the [decoration]
/// property to null, the decoration will be removed entirely, including the
/// extra padding introduced by the decoration to save space for the labels.
///
/// If [decoration] is non-null (which is the default), the text field requires
/// one of its ancestors to be a [Material] widget. When the [SelectableField] is
/// tapped an ink splash that paints on the material is triggered, see
/// [ThemeData.splashFactory].
///
/// To integrate the [SelectableField] into a [Form] with other [FormField] widgets,
/// consider using [TextFormField].
///
/// See also:
///
///  * <https://material.google.com/components/text-fields.html>
///  * [TextFormField], which integrates with the [Form] widget.
///  * [InputDecorator], which shows the labels and other visual elements that
///    surround the actual text editing widget.
///  * [SelectableText], which is the raw text editing control at the heart of a
///    [SelectableField]. (The [SelectableText] widget is rarely used directly unless
///    you are implementing an entirely different design language, such as
///    Cupertino.)
class SelectableField extends StatefulWidget {
  /// Creates a Material Design text field.
  ///
  /// If [decoration] is non-null (which is the default), the text field requires
  /// one of its ancestors to be a [Material] widget.
  ///
  /// To remove the decoration entirely (including the extra padding introduced
  /// by the decoration to save space for the labels), set the [decoration] to
  /// null.
  ///
  /// The [maxLines] property can be set to null to remove the restriction on
  /// the number of lines. By default, it is one, meaning this is a single-line
  /// text field. [maxLines] must not be zero. If [maxLines] is not one, then
  /// [keyboardType] is ignored, and the [TextInputType.multiline] keyboard
  /// type is used.
  ///
  /// The [maxLength] property is set to null by default, which means the
  /// number of characters allowed in the text field is not restricted. If
  /// [maxLength] is set, a character counter will be displayed below the
  /// field, showing how many characters have been entered and how many are
  /// allowed. After [maxLength] characters have been input, additional input
  /// is ignored, unless [maxLengthEnforced] is set to false. The SelectableField
  /// enforces the length with a [LengthLimitingTextInputFormatter], which is
  /// evaluated after the supplied [inputFormatters], if any. The [maxLength]
  /// value must be either null or greater than zero.
  ///
  /// If [maxLengthEnforced] is set to false, then more than [maxLength]
  /// characters may be entered, and the error counter and divider will
  /// switch to the [decoration.errorStyle] when the limit is exceeded.
  ///
  /// The [keyboardType], [textAlign], [autofocus], [obscureText], and
  /// [autocorrect] arguments must not be null.
  ///
  /// See also:
  ///
  ///  * [maxLength], which discusses the precise meaning of "number of
  ///    characters" and how it may differ from the intuitive meaning.
  const SelectableField({
    Key key,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    TextInputType keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
  })  : assert(keyboardType != null),
        assert(textInputAction != null),
        assert(textAlign != null),
        assert(autofocus != null),
        assert(obscureText != null),
        assert(autocorrect != null),
        assert(maxLengthEnforced != null),
        assert(scrollPadding != null),
        assert(maxLines == null || maxLines > 0),
        assert(maxLength == null || maxLength > 0),
        keyboardType = maxLines == 1 ? keyboardType : TextInputType.multiline,
        super(key: key);

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController controller;

  /// Controls whether this widget has keyboard focus.
  ///
  /// If null, this widget will create its own [FocusNode].
  final FocusNode focusNode;

  /// The decoration to show around the text field.
  ///
  /// By default, draws a horizontal line under the text field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  /// The type of keyboard to use for editing the text.
  ///
  /// Defaults to [TextInputType.text]. Must not be null. If
  /// [maxLines] is not one, then [keyboardType] is ignored, and the
  /// [TextInputType.multiline] keyboard type is used.
  final TextInputType keyboardType;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.done]. Must not be null.
  final TextInputAction textInputAction;

  /// Configures how the platform keyboard will select an uppercase or
  /// lowercase keyboard.
  ///
  /// Only supports text keyboards, other keyboard types will ignore this
  /// configuration. Capitalization is locale-aware.
  ///
  /// Defaults to [TextCapitalization.none]. Must not be null.
  ///
  /// See also:
  ///
  ///   * [TextCapitalization], for a description of each capitalization behavior.
  final TextCapitalization textCapitalization;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subhead` text style from the current [Theme].
  final TextStyle style;

  /// How the text being edited should be aligned horizontally.
  ///
  /// Defaults to [TextAlign.start].
  final TextAlign textAlign;

  /// Whether this text field should focus itself if nothing else is already
  /// focused.
  ///
  /// If true, the keyboard will open as soon as this text field obtains focus.
  /// Otherwise, the keyboard is only shown after the user taps the text field.
  ///
  /// Defaults to false. Cannot be null.
  // See https://github.com/flutter/flutter/issues/7035 for the rationale for this
  // keyboard behavior.
  final bool autofocus;

  /// Whether to hide the text being edited (e.g., for passwords).
  ///
  /// When this is set to true, all the characters in the text field are
  /// replaced by U+2022 BULLET characters (•).
  ///
  /// Defaults to false. Cannot be null.
  final bool obscureText;

  /// Whether to enable autocorrection.
  ///
  /// Defaults to true. Cannot be null.
  final bool autocorrect;

  /// The maximum number of lines for the text to span, wrapping if necessary.
  ///
  /// If this is 1 (the default), the text will not wrap, but will scroll
  /// horizontally instead.
  ///
  /// If this is null, there is no limit to the number of lines. If it is not
  /// null, the value must be greater than zero.
  final int maxLines;

  /// The maximum number of characters (Unicode scalar values) to allow in the
  /// text field.
  ///
  /// If set, a character counter will be displayed below the
  /// field, showing how many characters have been entered and how many are
  /// allowed. After [maxLength] characters have been input, additional input
  /// is ignored, unless [maxLengthEnforced] is set to false. The SelectableField
  /// enforces the length with a [LengthLimitingTextInputFormatter], which is
  /// evaluated after the supplied [inputFormatters], if any.
  ///
  /// This value must be either null or greater than zero. If set to null
  /// (the default), there is no limit to the number of characters allowed.
  ///
  /// Whitespace characters (e.g. newline, space, tab) are included in the
  /// character count.
  ///
  /// If [maxLengthEnforced] is set to false, then more than [maxLength]
  /// characters may be entered, but the error counter and divider will
  /// switch to the [decoration.errorStyle] when the limit is exceeded.
  ///
  /// ## Limitations
  ///
  /// The SelectableField does not currently count Unicode grapheme clusters (i.e.
  /// characters visible to the user), it counts Unicode scalar values, which
  /// leaves out a number of useful possible characters (like many emoji and
  /// composed characters), so this will be inaccurate in the presence of those
  /// characters. If you expect to encounter these kinds of characters, be
  /// generous in the maxLength used.
  ///
  /// For instance, the character "ö" can be represented as '\u{006F}\u{0308}',
  /// which is the letter "o" followed by a composed diaeresis "¨", or it can
  /// be represented as '\u{00F6}', which is the Unicode scalar value "LATIN
  /// SMALL LETTER O WITH DIAERESIS". In the first case, the text field will
  /// count two characters, and the second case will be counted as one
  /// character, even though the user can see no difference in the input.
  ///
  /// Similarly, some emoji are represented by multiple scalar values. The
  /// Unicode "THUMBS UP SIGN + MEDIUM SKIN TONE MODIFIER", "👍🏽", should be
  /// counted as a single character, but because it is a combination of two
  /// Unicode scalar values, '\u{1F44D}\u{1F3FD}', it is counted as two
  /// characters.
  ///
  /// See also:
  ///
  ///  * [LengthLimitingTextInputFormatter] for more information on how it
  ///    counts characters, and how it may differ from the intuitive meaning.
  final int maxLength;

  /// If true, prevents the field from allowing more than [maxLength]
  /// characters.
  ///
  /// If [maxLength] is set, [maxLengthEnforced] indicates whether or not to
  /// enforce the limit, or merely provide a character counter and warning when
  /// [maxLength] is exceeded.
  final bool maxLengthEnforced;

  /// Called when the text being edited changes.
  final ValueChanged<String> onChanged;

  /// Called when the user submits editable content (e.g., user presses the "done"
  /// button on the keyboard).
  ///
  /// The default implementation of [onEditingComplete] executes 2 different
  /// behaviors based on the situation:
  ///
  ///  - When a completion action is pressed, such as "done", "go", "send", or
  ///    "search", the user's content is submitted to the [controller] and then
  ///    focus is given up.
  ///
  ///  - When a non-completion action is pressed, such as "next" or "previous",
  ///    the user's content is submitted to the [controller], but focus is not
  ///    given up because developers may want to immediately move focus to
  ///    another input widget within [onSubmitted].
  ///
  /// Providing [onEditingComplete] prevents the aforementioned default behavior.
  final VoidCallback onEditingComplete;

  /// Called when the user indicates that they are done editing the text in the
  /// field.
  final ValueChanged<String> onSubmitted;

  /// Optional input validation and formatting overrides.
  ///
  /// Formatters are run in the provided order when the text input changes.
  final List<TextInputFormatter> inputFormatters;

  /// If false the textfield is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [Decoration.enabled] property.
  final bool enabled;

  /// How thick the cursor will be.
  ///
  /// Defaults to 2.0.
  final double cursorWidth;

  /// How rounded the corners of the cursor should be.
  /// By default, the cursor has a null Radius
  final Radius cursorRadius;

  /// The color to use when painting the cursor.
  final Color cursorColor;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to the brightness of [ThemeData.primaryColorBrightness].
  final Brightness keyboardAppearance;

  /// Configures padding to edges surrounding a [Scrollable] when the Textfield scrolls into view.
  ///
  /// When this widget receives focus and is not completely visible (for example scrolled partially
  /// off the screen or overlapped by the keyboard)
  /// then it will attempt to make itself visible by scrolling a surrounding [Scrollable], if one is present.
  /// This value controls how far from the edges of a [Scrollable] the SelectableField will be positioned after the scroll.
  ///
  /// Defaults to EdgeInserts.all(20.0).
  final EdgeInsets scrollPadding;

  @override
  _SelectableFieldState createState() => new _SelectableFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(new DiagnosticsProperty<TextEditingController>(
        'controller', controller,
        defaultValue: null));
    properties.add(new DiagnosticsProperty<FocusNode>('focusNode', focusNode,
        defaultValue: null));
    properties.add(
        new DiagnosticsProperty<InputDecoration>('decoration', decoration));
    properties.add(new DiagnosticsProperty<TextInputType>(
        'keyboardType', keyboardType,
        defaultValue: TextInputType.text));
    properties.add(
        new DiagnosticsProperty<TextStyle>('style', style, defaultValue: null));
    properties.add(new DiagnosticsProperty<bool>('autofocus', autofocus,
        defaultValue: false));
    properties.add(new DiagnosticsProperty<bool>('obscureText', obscureText,
        defaultValue: false));
    properties.add(new DiagnosticsProperty<bool>('autocorrect', autocorrect,
        defaultValue: false));
    properties.add(new IntProperty('maxLines', maxLines, defaultValue: 1));
    properties.add(new IntProperty('maxLength', maxLength, defaultValue: null));
    properties.add(new FlagProperty('maxLengthEnforced',
        value: maxLengthEnforced, ifTrue: 'max length enforced'));
  }
}

class _SelectableFieldState extends State<SelectableField>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<SelectableTextState> _selectableTextKey =
      new GlobalKey<SelectableTextState>();

  Set<InteractiveInkFeature> _splashes;
  InteractiveInkFeature _currentSplash;

  TextEditingController _controller;
  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  FocusNode _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= new FocusNode());

  bool get needsCounter =>
      widget.maxLength != null &&
      widget.decoration != null &&
      widget.decoration.counterText == null;

  InputDecoration _getEffectiveDecoration() {
    final InputDecoration effectiveDecoration =
        (widget.decoration ?? const InputDecoration())
            .applyDefaults(Theme.of(context).inputDecorationTheme)
            .copyWith(
              enabled: widget.enabled,
            );

    if (!needsCounter) return effectiveDecoration;

    final String counterText =
        '${_effectiveController.value.text.runes.length}/${widget.maxLength}';
    if (_effectiveController.value.text.runes.length > widget.maxLength) {
      final ThemeData themeData = Theme.of(context);
      return effectiveDecoration.copyWith(
        errorText: effectiveDecoration.errorText ?? '',
        counterStyle: effectiveDecoration.errorStyle ??
            themeData.textTheme.caption.copyWith(color: themeData.errorColor),
        counterText: counterText,
      );
    }
    return effectiveDecoration.copyWith(counterText: counterText);
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) _controller = new TextEditingController();
  }

  @override
  void didUpdateWidget(SelectableField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null)
      _controller =
          new TextEditingController.fromValue(oldWidget.controller.value);
    else if (widget.controller != null && oldWidget.controller == null)
      _controller = null;
    final bool isEnabled = widget.enabled ?? widget.decoration?.enabled ?? true;
    final bool wasEnabled =
        oldWidget.enabled ?? oldWidget.decoration?.enabled ?? true;
    if (wasEnabled && !isEnabled) {
      _effectiveFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  void _requestKeyboard() {
    _selectableTextKey.currentState?.requestKeyboard();
  }

  void _handleSelectionChanged(
      TextSelection selection, SelectionChangedCause cause) {
    if (cause == SelectionChangedCause.longPress)
      Feedback.forLongPress(context);
  }

  InteractiveInkFeature _createInkFeature(TapDownDetails details) {
    final MaterialInkController inkController = Material.of(context);
    final BuildContext selectableContext = _selectableTextKey.currentContext;
    final RenderBox referenceBox =
        InputDecorator.containerOf(selectableContext) ??
            selectableContext.findRenderObject();
    final Offset position = referenceBox.globalToLocal(details.globalPosition);
    final Color color = Theme.of(context).splashColor;

    InteractiveInkFeature splash;
    void handleRemoved() {
      if (_splashes != null) {
        assert(_splashes.contains(splash));
        _splashes.remove(splash);
        if (_currentSplash == splash) _currentSplash = null;
        updateKeepAlive();
      } // else we're probably in deactivate()
    }

    splash = Theme.of(context).splashFactory.create(
          controller: inkController,
          referenceBox: referenceBox,
          position: position,
          color: color,
          containedInkWell: true,
          // TODO(hansmuller): splash clip borderRadius should match the input decorator's border.
          borderRadius: BorderRadius.zero,
          onRemoved: handleRemoved,
          textDirection: Directionality.of(context),
        );

    return splash;
  }

  RenderEditable get _renderEditable =>
      _selectableTextKey.currentState.renderEditable;

  void _handleTapDown(TapDownDetails details) {
    _renderEditable.handleTapDown(details);
    _startSplash(details);
  }

  void _handleTap() {
    _renderEditable.handleTap();
    _requestKeyboard();
    _confirmCurrentSplash();
  }

  void _handleTapCancel() {
    _cancelCurrentSplash();
  }

  void _handleLongPress() {
    _renderEditable.handleLongPress();
    _confirmCurrentSplash();
  }

  void _startSplash(TapDownDetails details) {
    if (_effectiveFocusNode.hasFocus) return;
    final InteractiveInkFeature splash = _createInkFeature(details);
    _splashes ??= new HashSet<InteractiveInkFeature>();
    _splashes.add(splash);
    _currentSplash = splash;
    updateKeepAlive();
  }

  void _confirmCurrentSplash() {
    _currentSplash?.confirm();
    _currentSplash = null;
  }

  void _cancelCurrentSplash() {
    _currentSplash?.cancel();
  }

  @override
  bool get wantKeepAlive => _splashes != null && _splashes.isNotEmpty;

  @override
  void deactivate() {
    if (_splashes != null) {
      final Set<InteractiveInkFeature> splashes = _splashes;
      _splashes = null;
      for (InteractiveInkFeature splash in splashes) splash.dispose();
      _currentSplash = null;
    }
    assert(_currentSplash == null);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    assert(debugCheckHasMaterial(context));
    final ThemeData themeData = Theme.of(context);
    final TextStyle style = widget.style ?? themeData.textTheme.subhead;
    final Brightness keyboardAppearance =
        widget.keyboardAppearance ?? themeData.primaryColorBrightness;
    final TextEditingController controller = _effectiveController;
    final FocusNode focusNode = _effectiveFocusNode;
    final List<TextInputFormatter> formatters =
        widget.inputFormatters ?? <TextInputFormatter>[];
    if (widget.maxLength != null && widget.maxLengthEnforced)
      formatters.add(new LengthLimitingTextInputFormatter(widget.maxLength));

    Widget child = new RepaintBoundary(
      child: new SelectableText(
        key: _selectableTextKey,
        controller: controller,
        focusNode: focusNode,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        style: style,
        textAlign: widget.textAlign,
        autofocus: widget.autofocus,
        obscureText: widget.obscureText,
        autocorrect: widget.autocorrect,
        maxLines: widget.maxLines,
        selectionColor: themeData.textSelectionColor,
        selectionControls: themeData.platform == TargetPlatform.iOS
            ? cupertinoTextSelectionControls
            : materialTextSelectionControls,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        onSubmitted: widget.onSubmitted,
        onSelectionChanged: _handleSelectionChanged,
        inputFormatters: formatters,
        rendererIgnoresPointer: true,
        cursorWidth: widget.cursorWidth,
        cursorRadius: widget.cursorRadius,
        cursorColor: widget.cursorColor ?? Theme.of(context).cursorColor,
        scrollPadding: widget.scrollPadding,
        keyboardAppearance: keyboardAppearance,
      ),
    );

    if (widget.decoration != null) {
      child = new AnimatedBuilder(
        animation: new Listenable.merge(<Listenable>[focusNode, controller]),
        builder: (BuildContext context, Widget child) {
          return new InputDecorator(
            decoration: _getEffectiveDecoration(),
            baseStyle: widget.style,
            textAlign: widget.textAlign,
            isFocused: focusNode.hasFocus,
            isEmpty: controller.value.text.isEmpty,
            child: child,
          );
        },
        child: child,
      );
    }

    return new Semantics(
      onTap: () {
        if (!_effectiveController.selection.isValid)
          _effectiveController.selection = new TextSelection.collapsed(
              offset: _effectiveController.text.length);
        _requestKeyboard();
      },
      child: new IgnorePointer(
        ignoring: !(widget.enabled ?? widget.decoration?.enabled ?? true),
        child: new GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: _handleTapDown,
          onTap: _handleTap,
          onTapCancel: _handleTapCancel,
          onLongPress: _handleLongPress,
          excludeFromSemantics: true,
          child: child,
        ),
      ),
    );
  }
}
