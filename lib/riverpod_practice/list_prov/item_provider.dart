import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemProvider = StateNotifierProvider<ItemProvider, List<Item>>((ref) {
  return ItemProvider();
});

class ItemProvider extends StateNotifier<List<Item>> {
  ItemProvider() : super([]);

  void addItem(Item item) {
    state.add(item);
    state = state.toList();
  }

  void deleteItem(String id) {
    state.removeWhere((item) => item.id == id);
    state = state.toList();
  }

  void updateItem(String id, String name) {
    final index = state.indexWhere((item) => item.id == id);
    state[index] = state[index].copyWith(name: name);
    state = state.toList();
  }
}

class Item {
  final String name;
  final String id;

  Item({required this.name, required this.id});

  Item copyWith({String? name, String? id}) {
    return Item(name: name ?? this.name, id: id ?? this.id);
  }
}
