import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly_learnig/riverpod_practice/stateprov/search_provider.dart';

class HomeProvider extends ConsumerWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              if (value.isNotEmpty) {
                ref.read(searchProvider.notifier).search(value);
              }
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final search = ref.watch(searchProvider.select(
                (value) => value.search,
              ));
              return Text(search);
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final search = ref.watch((searchProvider));
              return Switch(
                  value: search.isLoading,
                  onChanged: (isLoading) {
                    ref.read(searchProvider.notifier).isLoading(isLoading);
                  });
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final isEnabled = ref.watch((searchProvider).select(
                (value) => value.isEnabled,
              ));
              return Switch(
                  value: isEnabled,
                  onChanged: (isEnabled) {
                    ref.read(searchProvider.notifier).isEnabled(isEnabled);
                  });
            },
          ),
        ],
      ),
    );
  }
}
