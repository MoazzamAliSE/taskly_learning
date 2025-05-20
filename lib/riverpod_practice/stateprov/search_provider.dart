import 'package:flutter_riverpod/flutter_riverpod.dart';

// final searchProvider = StateNotifierProvider<SearchNotifer, String>((ref) {
//   return SearchNotifer();
// });

// class SearchNotifer extends StateNotifier<String> {
//   SearchNotifer() : super('');

//   void search(String query) {
//     state = query;
//   }
// }

final searchProvider = StateNotifierProvider<SearchNotifer, SearchState>((ref) {
  return SearchNotifer();
});

class SearchNotifer extends StateNotifier<SearchState> {
  SearchNotifer()
      : super(SearchState(search: "", isLoading: false, isEnabled: false));

  void search(String query) {
    state = state.copyWith(search: query);
  }

  void isLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void isEnabled(bool isEnabled) {
    state = state.copyWith(isEnabled: isEnabled);
  }
}

class SearchState {
  final String search;
  final bool isLoading;
  final bool isEnabled;
  SearchState(
      {required this.search, required this.isLoading, required this.isEnabled});

  SearchState copyWith({String? search, bool? isLoading, bool? isEnabled}) {
    return SearchState(
        search: search ?? this.search,
        isLoading: isLoading ?? this.isLoading,
        isEnabled: isEnabled ?? this.isEnabled);
  }
}
