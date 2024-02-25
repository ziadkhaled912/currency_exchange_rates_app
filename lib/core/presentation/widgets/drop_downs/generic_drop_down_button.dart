import 'package:currency_exchange/core/extenstions/context.dart';
import 'package:currency_exchange/core/extenstions/screen_util.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/core/presentation/widgets/drop_downs/drop_down_item.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GenericDropDownButton<T> extends StatefulWidget {
  const GenericDropDownButton({
    super.key,
    this.labelText,
    this.onChanged,
    required this.hintText,
    this.selectedItem,
    this.validator,
    required this.items,
    this.focusNode,
    this.isLoading = false,
  });

  final String? labelText;
  final List<GenericDropdownMenuItem<T>> items;
  final String hintText;
  final T? selectedItem;
  final FocusNode? focusNode;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool isLoading;

  @override
  State<GenericDropDownButton<T>> createState() => _GenericDropDownButtonState<T>();
}

class _GenericDropDownButtonState<T> extends State<GenericDropDownButton<T>> {
  T? selectedItem;

  @override
  void initState() {
    selectedItem = widget.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              widget.labelText!,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.mainText,
                height: 24 / 14,
              ),
            ),
          ),
        Stack(
          children: [
            Opacity(
              opacity: widget.isLoading ? 0.0 : 1.0,
              child: DropdownButtonFormField<T>(
                borderRadius: BorderRadius.circular(4),
                hint: Text(widget.hintText, style: context.textTheme.labelSmall?.copyWith(
                  color: AppColors.secondText,
                  fontSize: 12.toFont,
                )),
                value: selectedItem,
                validator: (value) => value == null
                    ? "This field is required" : null,
                focusNode: widget.focusNode,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 24,
                  color: AppColors.secondText,
                ),
                onChanged: widget.onChanged != null ? (value) {
                  setState(() {
                    selectedItem = value;
                    widget.onChanged!(value);
                  });
                } : null,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.mainText,
                  fontSize: 14.toFont,
                ),
                decoration: InputDecoration(
                  enabled: true,
                  contentPadding: const EdgeInsetsDirectional.only(start: 16, top: 12, bottom: 12, end: 8),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(width: 1, color: AppColors.brownishGrey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(width: 1, color: AppColors.brownishGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(width: 1, color: AppColors.primary),
                  ),
                ),
                items: widget.items
                    .map((e) => DropdownMenuItem<T>(
                          value: e.value,
                          enabled: e.isEnabled,
                          child: Text(e.title),
                        ))
                    .toList(),
              ),
            ),
            if(widget.isLoading)
            Positioned.fill(
              child: Opacity(
                opacity: widget.isLoading ? 1.0 : 0.0,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabled: true,
                      contentPadding: const EdgeInsetsDirectional.only(start: 16, top: 12, bottom: 12, end: 8),
                      filled: true,
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(width: 1, color: AppColors.brownishGrey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(width: 1, color: AppColors.brownishGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(width: 1, color: AppColors.primary),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: '',
                        child: Text(''),
                      ),
                    ],
                    onChanged: null,
                    hint: Container(
                      width: context.screenWidth * 0.35,
                      height: 15.toHeight,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
