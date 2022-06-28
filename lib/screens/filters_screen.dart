import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    Key? key,
    required this.saveFilters,
    required this.currentFilters,
  }) : super(key: key);

  final void Function(Map<String, bool>) saveFilters;
  final Map<String, bool> currentFilters;

  static const String routeName = '/filters';

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    super.initState();

    _glutenFree = widget.currentFilters['gluten']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    _lactoseFree = widget.currentFilters['lactose']!;
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    void Function(bool newValue) updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              Map<String, bool> _selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters.call(_selectedFilters);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten free meals',
                  _glutenFree,
                  (bool newValue) => setState(() {
                    _glutenFree = newValue;
                  }),
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose free meals',
                  _lactoseFree,
                  (bool newValue) => setState(() {
                    _lactoseFree = newValue;
                  }),
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals',
                  _vegetarian,
                  (bool newValue) => setState(() {
                    _vegetarian = newValue;
                  }),
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals',
                  _vegan,
                  (bool newValue) => setState(() {
                    _vegan = newValue;
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
