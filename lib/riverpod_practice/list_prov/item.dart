import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly_learnig/riverpod_practice/list_prov/item_provider.dart';

class Items extends ConsumerWidget {
  const Items({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        ref
            .read(itemProvider.notifier)
            .addItem(Item(name: "Abc", id: DateTime.now().toString()));
      }),
      body: Consumer(
        builder: (context, ref, child) {
          final items = ref.watch(itemProvider);

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        ref
                            .read(itemProvider.notifier)
                            .updateItem(item.id, "Updated");
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(itemProvider.notifier).deleteItem(item.id);
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
