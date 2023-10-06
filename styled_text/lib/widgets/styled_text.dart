import 'dart:ui' as ui show TextHeightBehavior, BoxHeightStyle, BoxWidthStyle;

import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:styled_text/builders/custom_selectable_text.dart'
    as customSelectable;
import 'package:styled_text/tags/styled_text_tag_base.dart';

import '../builders/custom_selectable_text.dart';
import 'custom_styled_text.dart';

///
/// Text widget with formatting via tags.
///
/// Formatting is specified as xml tags. For each tag, you can specify a style, icon, etc. in the [tags] parameter.
///
/// Consider using the [CustomStyledText] instead if you need more customisation.
///
/// Example:
/// ```dart
/// StyledText(
///   text: '&lt;red&gt;Red&lt;/red&gt; text.',
///   tags: [
///     'red': StyledTextTag(style: TextStyle(color: Colors.red)),
///   ],
/// )
/// ```
/// See also:
///
/// * [TextStyle], which discusses how to style text.
///
class StyledText extends StatefulWidget {
  /// The text to display in this widget. The text must be valid xml.
  ///
  /// Tag attributes must be enclosed in double quotes.
  /// You need to escape specific XML characters in text:
  ///
  /// ```
  /// Original character  Escaped character
  /// ------------------  -----------------
  /// "                   &quot;
  /// '                   &apos;
  /// &                   &amp;
  /// <                   &lt;
  /// >                   &gt;
  /// <space>             &space;
  /// ```
  ///
  final String text;

  /// Treat newlines as line breaks.
  final bool newLineAsBreaks;

  /// Is text selectable?
  final bool selectable;

  /// Is text editable?
  final bool editable;

  final Function(String value)? onChange;

  /// Default text style.
  final TextStyle? style;

  /// Map of tag assignments to text style classes and tag handlers.
  ///
  /// Example:
  /// ```dart
  /// StyledText(
  ///   text: '&lt;red&gt;Red&lt;/red&gt; text.',
  ///   tags: [
  ///     'red': StyledTextTag(style: TextStyle(color: Colors.red)),
  ///   ],
  /// )
  /// ```
  final Map<String, StyledTextTagBase> tags;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  final double? textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  final int? maxLines;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  /// {@macro flutter.dart:ui.textHeightBehavior}
  final ui.TextHeightBehavior? textHeightBehavior;

  /// Create a text widget with formatting via tags.
  ///
  StyledText({
    Key? key,
    required this.text,
    this.newLineAsBreaks = true,
    this.style,
    Map<String, StyledTextTagBase>? tags,
    this.textAlign,
    this.textDirection,
    this.softWrap = true,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis,
    this.textHeightBehavior,
  })  : this.tags = tags ?? const {},
        this.selectable = false,
        this.editable = false,
        this._focusNode = null,
        this._showCursor = false,
        this._autofocus = false,
        this._toolbarOptions = null,
        this._contextMenuBuilder = null,
        this._selectionControls = null,
        this._selectionHeightStyle = null,
        this._selectionWidthStyle = null,
        this._onSelectionChanged = null,
        this._magnifierConfiguration = null,
        this._cursorWidth = null,
        this._cursorHeight = null,
        this._cursorRadius = null,
        this._cursorColor = null,
        this._dragStartBehavior = DragStartBehavior.start,
        this._enableInteractiveSelection = false,
        this._onTap = null,
        this._scrollPhysics = null,
        this._semanticsLabel = null,
        this.onChange = null,
        super(key: key);

  /// Create a selectable text widget with formatting via tags.
  ///
  /// See [SelectableText.rich] for more options.
  StyledText.selectable({
    Key? key,
    required this.text,
    this.newLineAsBreaks = false,
    this.style,
    Map<String, StyledTextTagBase>? tags,
    this.textAlign,
    this.textDirection,
    this.textScaleFactor,
    this.maxLines,
    this.strutStyle,
    this.textWidthBasis,
    this.textHeightBehavior,
    FocusNode? focusNode,
    bool showCursor = false,
    bool autofocus = false,
    @Deprecated(
      'Use `contextMenuBuilder` instead. '
      'This feature was deprecated after Flutter v3.3.0-0.5.pre.',
    )
    // ignore: deprecated_member_use
    ToolbarOptions? toolbarOptions,
    EditableTextContextMenuBuilder contextMenuBuilder =
        _defaultContextMenuBuilder,
    TextSelectionControls? selectionControls,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    SelectionChangedCallback? onSelectionChanged,
    TextMagnifierConfiguration? magnifierConfiguration,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool enableInteractiveSelection = true,
    GestureTapCallback? onTap,
    ScrollPhysics? scrollPhysics,
    String? semanticsLabel,
  })  : this.tags = tags ?? const {},
        this.selectable = true,
        this.editable = false,
        this.softWrap = true,
        this.overflow = TextOverflow.clip,
        this.locale = null,
        this._focusNode = focusNode,
        this._showCursor = showCursor,
        this._autofocus = autofocus,
        this._toolbarOptions = toolbarOptions ??
            // ignore: deprecated_member_use
            const ToolbarOptions(
              selectAll: true,
              copy: true,
            ),
        this._contextMenuBuilder = contextMenuBuilder,
        this._selectionHeightStyle = selectionHeightStyle,
        this._selectionWidthStyle = selectionWidthStyle,
        this._selectionControls = selectionControls,
        this._onSelectionChanged = onSelectionChanged,
        this._magnifierConfiguration = magnifierConfiguration,
        this._cursorWidth = cursorWidth,
        this._cursorHeight = cursorHeight,
        this._cursorRadius = cursorRadius,
        this._cursorColor = cursorColor,
        this._dragStartBehavior = dragStartBehavior,
        this._enableInteractiveSelection = enableInteractiveSelection,
        this._onTap = onTap,
        this._scrollPhysics = scrollPhysics,
        this._semanticsLabel = semanticsLabel,
        this.onChange = null,
        super(key: key);

  /// Create an editable text widget with formatting via tags.
  ///
  /// See [EditableText] for more options.
  StyledText.editable({
    Key? key,
    required this.text,
    this.newLineAsBreaks = false,
    this.style,
    Map<String, StyledTextTagBase>? tags,
    this.textAlign,
    this.textDirection,
    this.textScaleFactor,
    this.maxLines,
    this.strutStyle,
    this.textWidthBasis,
    this.textHeightBehavior,
    FocusNode? focusNode,
    bool showCursor = false,
    bool autofocus = false,
    @Deprecated(
      'Use `contextMenuBuilder` instead. '
      'This feature was deprecated after Flutter v3.3.0-0.5.pre.',
    )
    // ignore: deprecated_member_use
    ToolbarOptions? toolbarOptions,
    EditableTextContextMenuBuilder contextMenuBuilder =
        _defaultContextMenuBuilder,
    TextSelectionControls? selectionControls,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    SelectionChangedCallback? onSelectionChanged,
    TextMagnifierConfiguration? magnifierConfiguration,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool enableInteractiveSelection = true,
    GestureTapCallback? onTap,
    ScrollPhysics? scrollPhysics,
    String? semanticsLabel,
    required this.onChange,
  })  : this.tags = tags ?? const {},
        this.selectable = false,
        this.editable = true,
        this.softWrap = true,
        this.overflow = TextOverflow.clip,
        this.locale = null,
        this._focusNode = focusNode,
        this._showCursor = showCursor,
        this._autofocus = autofocus,
        this._toolbarOptions = toolbarOptions ??
            // ignore: deprecated_member_use
            const ToolbarOptions(
              selectAll: true,
              copy: true,
            ),
        this._contextMenuBuilder = contextMenuBuilder,
        this._selectionHeightStyle = selectionHeightStyle,
        this._selectionWidthStyle = selectionWidthStyle,
        this._selectionControls = selectionControls,
        this._onSelectionChanged = onSelectionChanged,
        this._magnifierConfiguration = magnifierConfiguration,
        this._cursorWidth = cursorWidth,
        this._cursorHeight = cursorHeight,
        this._cursorRadius = cursorRadius,
        this._cursorColor = cursorColor,
        this._dragStartBehavior = dragStartBehavior,
        this._enableInteractiveSelection = enableInteractiveSelection,
        this._onTap = onTap,
        this._scrollPhysics = scrollPhysics,
        this._semanticsLabel = semanticsLabel,
        super(key: key);

  final FocusNode? _focusNode;
  final bool _showCursor;
  final bool _autofocus;

  // ignore: deprecated_member_use
  final ToolbarOptions? _toolbarOptions;
  final EditableTextContextMenuBuilder? _contextMenuBuilder;
  final TextSelectionControls? _selectionControls;
  final ui.BoxHeightStyle? _selectionHeightStyle;
  final ui.BoxWidthStyle? _selectionWidthStyle;
  final SelectionChangedCallback? _onSelectionChanged;
  final TextMagnifierConfiguration? _magnifierConfiguration;
  final double? _cursorWidth;
  final double? _cursorHeight;
  final Radius? _cursorRadius;
  final Color? _cursorColor;
  final DragStartBehavior _dragStartBehavior;
  final bool _enableInteractiveSelection;
  final GestureTapCallback? _onTap;
  final ScrollPhysics? _scrollPhysics;
  final String? _semanticsLabel;

  static Widget _defaultContextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  @override
  State<StyledText> createState() => _StyledTextState();
}

class _StyledTextState extends State<StyledText> {
  TextSpanEditingController? _controller;
  String? originalText;
  late String originalTextWithTags = widget.text;

  Widget _buildText(BuildContext context, TextSpan textSpan) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    final registrar = SelectionContainer.maybeOf(context);

    Widget result = RichText(
      textAlign:
          widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: widget.textDirection,
      softWrap: widget.softWrap ?? defaultTextStyle.softWrap,
      overflow: widget.overflow ??
          textSpan.style?.overflow ??
          defaultTextStyle.overflow,
      textScaleFactor:
          widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context),
      maxLines: widget.maxLines ?? defaultTextStyle.maxLines,
      locale: widget.locale,
      strutStyle: widget.strutStyle,
      textWidthBasis: widget.textWidthBasis ?? defaultTextStyle.textWidthBasis,
      textHeightBehavior: widget.textHeightBehavior ??
          defaultTextStyle.textHeightBehavior ??
          DefaultTextHeightBehavior.maybeOf(context),
      text: textSpan,
      selectionRegistrar: registrar,
      selectionColor: DefaultSelectionStyle.of(context).selectionColor,
    );

    if (registrar != null) {
      result = MouseRegion(
        cursor: SystemMouseCursors.text,
        child: result,
      );
    }

    return result;
  }

  Widget _buildSelectableText(BuildContext context, TextSpan textSpan) {
    final defaultTextStyle = DefaultTextStyle.of(context);

    return SelectableText.rich(
      textSpan,
      focusNode: widget._focusNode,
      showCursor: widget._showCursor,
      autofocus: widget._autofocus,
      // ignore: deprecated_member_use
      toolbarOptions: widget._toolbarOptions,
      contextMenuBuilder: widget._contextMenuBuilder,
      selectionControls: widget._selectionControls,
      selectionHeightStyle: widget._selectionHeightStyle!,
      selectionWidthStyle: widget._selectionWidthStyle!,
      onSelectionChanged: widget._onSelectionChanged,
      magnifierConfiguration: widget._magnifierConfiguration,
      cursorWidth: widget._cursorWidth!,
      cursorHeight: widget._cursorHeight,
      cursorRadius: widget._cursorRadius,
      cursorColor: widget._cursorColor,
      dragStartBehavior: widget._dragStartBehavior,
      enableInteractiveSelection: widget._enableInteractiveSelection,
      onTap: widget._onTap,
      scrollPhysics: widget._scrollPhysics,
      textWidthBasis: widget.textWidthBasis ?? defaultTextStyle.textWidthBasis,
      textHeightBehavior: widget.textHeightBehavior ??
          defaultTextStyle.textHeightBehavior ??
          DefaultTextHeightBehavior.maybeOf(context),
      textAlign:
          widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: widget.textDirection,
      // softWrap
      // overflow
      textScaleFactor:
          widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context),
      maxLines: widget.maxLines ?? defaultTextStyle.maxLines,
      // locale
      strutStyle: widget.strutStyle,
      semanticsLabel: widget._semanticsLabel,
    );
  }

  /// Obtains the last children of a text span.
  List<TextSpan> getLastChildren(TextSpan parent) {
    List<TextSpan> results = [];
    final children = parent.children;
    if (children == null || children.isEmpty) {
      return [parent];
    }

    for (var child in children) {
      results.addAll(getLastChildren(child as TextSpan));
    }

    List<TextSpan> newResults = [];

    for (var result in results) {
      newResults.add(TextSpan(
        children: result.children,
        text: result.text,
        style: (parent.style ?? TextStyle()).copyWith(
          color: result.style?.color,
          backgroundColor: result.style?.backgroundColor,
          decoration: result.style?.decoration,
          decorationColor: result.style?.decorationColor,
          decorationStyle: result.style?.decorationStyle,
          decorationThickness: result.style?.decorationThickness,
          fontFamily: result.style?.fontFamily,
          fontFamilyFallback: result.style?.fontFamilyFallback,
          fontSize: result.style?.fontSize,
          fontStyle: result.style?.fontStyle,
          fontWeight: result.style?.fontWeight,
          fontFeatures: result.style?.fontFeatures,
          letterSpacing: result.style?.letterSpacing,
          wordSpacing: result.style?.wordSpacing,
          textBaseline: result.style?.textBaseline,
          height: result.style?.height,
          locale: result.style?.locale,
          foreground: result.style?.foreground,
          background: result.style?.background,
          shadows: result.style?.shadows,
          leadingDistribution: result.style?.leadingDistribution,
          debugLabel: result.style?.debugLabel,
        ),
      ));
    }

    return newResults;
  }

  int mapIndex(int index, String text, String textWithTags) {
    int i = 0; // Index for text
    int j = 0; // Index for textWithTags

    while (i < index && j < textWithTags.length) {
      if (textWithTags[j] == '<') {
        // Skip tag
        while (j < textWithTags.length && textWithTags[j] != '>') {
          j++;
        }
      } else if (i < text.length && text[i] == textWithTags[j]) {
        // Match character
        i++;
      } else {
        return text.length - 1;
        // Handle error: characters do not match
        throw FormatException(
            'Text does not match at index $i: ${text[i]} vs ${textWithTags[j]}');
      }
      j++;
    }

    if (i < index) {
      return text.length - 1;

      // Handle error: index out of range
      throw RangeError(
          'Index out of range: $index (length of text is ${text.length})');
    }

    return j;
  }

  (String, String) stringDifference(String s1, String s2) {
    final dmp = DiffMatchPatch();
    final diffs = dmp.diff(s1, s2);
    dmp.diffCleanupSemantic(diffs);

    final StringBuffer resultAdd = StringBuffer();
    final StringBuffer resultMinus = StringBuffer();
    for (final diff in diffs) {
      if (diff.operation == 1) {
        resultAdd.write(diff.text);
      } else if (diff.operation == -1) {
        resultMinus.write(diff.text);
      }
    }
    return (resultAdd.toString(), resultMinus.toString());
  }

  String insertCharAtPosition(
      String original, String charToInsert, int position) {
    if (position < 0 || position > original.length) {
      throw ArgumentError('Position is out of bounds');
    }

    return original.substring(0, position) +
        charToInsert +
        original.substring(position);
  }

  String deleteCharsAtPosition(String original, int position, int count) {
    if (position < 0 ||
        position >= original.length ||
        count < 0 ||
        position + count > original.length) {
      throw ArgumentError('Invalid position or count');
    }
    return original.substring(0, position) +
        original.substring(position + count);
  }

  String buildBackToString(List<TextSpan> spans) {
    String result = '';
    for (var span in spans) {
      result += span.text ?? '';
    }
    return result + widget.text;
  }

  Widget _buildEditableText(BuildContext context, TextSpan textSpan) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    var children = getLastChildren(textSpan);

    if (_controller == null) {
      _controller =
          TextSpanEditingController(textSpan: TextSpan(children: children));
      originalText = _controller!.text;

      _controller!.addListener(() {
        var newStringIndex = _controller!.selection.extentOffset;
        var originalIndex =
            mapIndex(newStringIndex, originalText!, originalTextWithTags);
        // var selection = _controller!.selection;
        // var base = mapIndex(
        //     selection.baseOffset, _controller!.text, originalTextWithTags);
        // var extent = mapIndex(
        //     selection.extentOffset, _controller!.text, originalTextWithTags);

        var diff = stringDifference(originalText!, _controller!.text);
        var originalAddStringModified = diff.$1;
        var originalMinusStringModified = diff.$2;

        // var selectedText = originalTextWithTags.substring(base, extent);

      
        if (originalAddStringModified.isNotEmpty) {
          originalTextWithTags = insertCharAtPosition(originalTextWithTags,
              originalAddStringModified, originalIndex - 1);
          originalText = insertCharAtPosition(
              originalText!, originalAddStringModified, newStringIndex - 1);
        }

        if (originalMinusStringModified.isNotEmpty) {
          originalTextWithTags = deleteCharsAtPosition(originalTextWithTags,
              originalIndex, originalMinusStringModified.length);
          originalText = deleteCharsAtPosition(originalText!, newStringIndex,
              originalMinusStringModified.length);
        }

        if ((originalAddStringModified.isNotEmpty ||
                originalMinusStringModified.isNotEmpty) &&
            widget.onChange != null) {
          widget.onChange!(originalTextWithTags);
        }
      });
    }

    // newController!.textSpan = (((textSpan.children!.first as TextSpan).children!.first as TextSpan).children);
    return customSelectable.EditableSelectableText.rich(
      _controller!.textSpan,
      focusNode: widget._focusNode,
      showCursor: widget._showCursor,
      autofocus: widget._autofocus,
      controller: _controller!,
      // ignore: deprecated_member_use
      contextMenuBuilder: widget._contextMenuBuilder,
      selectionControls: widget._selectionControls,
      selectionHeightStyle: widget._selectionHeightStyle!,
      selectionWidthStyle: widget._selectionWidthStyle!,
      onSelectionChanged: widget._onSelectionChanged,
      magnifierConfiguration: widget._magnifierConfiguration,
      cursorWidth: widget._cursorWidth!,
      cursorHeight: widget._cursorHeight,
      cursorRadius: widget._cursorRadius,
      cursorColor: widget._cursorColor,
      dragStartBehavior: widget._dragStartBehavior,
      enableInteractiveSelection: widget._enableInteractiveSelection,
      onTap: widget._onTap,
      scrollPhysics: widget._scrollPhysics,
      textWidthBasis: widget.textWidthBasis ?? defaultTextStyle.textWidthBasis,
      textHeightBehavior: widget.textHeightBehavior ??
          defaultTextStyle.textHeightBehavior ??
          DefaultTextHeightBehavior.maybeOf(context),
      textAlign:
          widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: widget.textDirection,
      // softWrap
      // overflow
      textScaleFactor:
          widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context),
      maxLines: widget.maxLines ?? defaultTextStyle.maxLines,
      // locale
      strutStyle: widget.strutStyle,
      semanticsLabel: widget._semanticsLabel,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStyledText(
      style: widget.style,
      newLineAsBreaks: widget.newLineAsBreaks,
      text: widget.text,
      tags: widget.tags,
      builder: widget.selectable
          ? _buildSelectableText
          : ((widget.editable) ? _buildEditableText : _buildText),
    );
  }
}
