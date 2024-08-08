import 'package:flutter/material.dart';

class SideBarView extends StatefulWidget {
  final double _sidebarWidth;
  final List<SideBarItem> _tabs;
  final List<Widget> _tabsView;
  final double _gap;
  final EdgeInsets _padding;
  final CrossAxisAlignment _alignment;

  final Color? _selectedTabColor;

  const SideBarView({
    super.key,
    required List<SideBarItem> tabs,
    required List<Widget> tabsView,
    double sidebarWidth = 300,
    double gap = 5,
    EdgeInsets padding = const EdgeInsets.all(10),
    Color? selectedTabColor,
    CrossAxisAlignment alignment = CrossAxisAlignment.start,
  })  : _sidebarWidth = sidebarWidth,
        _tabs = tabs,
        _gap = gap,
        _padding = padding,
        _tabsView = tabsView,
        _alignment = alignment,
        _selectedTabColor = selectedTabColor;

  @override
  State<SideBarView> createState() => _SideBarViewState();
}

class _SideBarViewState extends State<SideBarView> {
  late ValueNotifier<int> _selectedIndex;

  @override
  void initState() {
    _selectedIndex = ValueNotifier<int>(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: widget._sidebarWidth,
            height: MediaQuery.sizeOf(context).height,
            child: Padding(
              padding: widget._padding,
              child: Column(
                crossAxisAlignment: widget._alignment,
                children: [
                  const Text(
                    "Logo.",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder(
                      valueListenable: _selectedIndex,
                      builder: (context, value, child) {
                        return Column(
                          children: List.generate(
                            widget._tabs.length,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: widget._gap),
                                child: ListTile(
                                  onTap: () {
                                    _selectedIndex.value = index;
                                  },
                                  selected: value == index,
                                  selectedTileColor: widget._selectedTabColor ??
                                      Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.1),
                                  leading: widget._tabs[index].icon,
                                  title: Text(
                                    widget._tabs[index].label,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width - widget._sidebarWidth,
            child: ValueListenableBuilder(
                valueListenable: _selectedIndex,
                builder: (context, index, child) {
                  return IndexedStack(
                    index: index,
                    children: widget._tabsView,
                  );
                }),
          )
        ],
      ),
    );
  }
}

class SideBarItem {
  final Widget icon;
  final String label;

  const SideBarItem({
    required this.icon,
    required this.label,
  });
}
