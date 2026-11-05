import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/utils/functions/arabic_ordinal_function.dart';
import 'package:islami/core/shared/widgets/content_view/layout_card.dart';

class ContantLayout<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) getContent;
  final void Function(T) onItemTap;
  final String prefixText;

  const ContantLayout({
    super.key,
    required this.items,
    required this.getContent,
    required this.onItemTap,
    required this.prefixText,
  });

  @override
  State<ContantLayout<T>> createState() => _ContantLayoutState<T>();
}

class _ContantLayoutState<T> extends State<ContantLayout<T>> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.82, initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.items.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final item = widget.items[index];

              final titleText =
                  '${widget.prefixText} ${ArabicOrdinalFunction.getOrdinal(index + 1)}';

              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.15)).clamp(0.85, 1.0);
                  }
                  return Center(
                    child: SizedBox(
                      height:
                          Curves.easeOut.transform(value) *
                          MediaQuery.of(context).size.height *
                          0.68,
                      child: child,
                    ),
                  );
                },
                child: LayoutCard(
                  title: titleText,
                  content: widget.getContent(item),
                  onTap: () {
                    widget.onItemTap(item);
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
