import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/transactions_history/view_model/transactions_history_cubit/transactions_history_cubit.dart';

class TransactionsHistorySearchBar extends StatefulWidget {
  const TransactionsHistorySearchBar({super.key});

  @override
  State<TransactionsHistorySearchBar> createState() =>
      _TransactionsHistorySearchBarState();
}

class _TransactionsHistorySearchBarState
    extends State<TransactionsHistorySearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final currentQuery = context
        .read<TransactionsHistoryCubit>()
        .currentFilter
        .searchQuery;
    _controller = TextEditingController(text: currentQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionsHistoryCubit, TransactionsHistoryState>(
      listenWhen: (previous, current) {
        if (current is TransactionsHistorySuccess) {
          return current.filter.searchQuery != _controller.text;
        }
        return false;
      },
      listener: (context, state) {
        if (state is TransactionsHistorySuccess) {
          _controller.text = state.filter.searchQuery;
        }
      },
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: _controller,
        builder: (context, value, _) {
          return TextField(
            controller: _controller,
            cursorHeight: 20,
            onChanged: (text) {
              context.read<TransactionsHistoryCubit>().updateSearchQuery(text);
            },
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: 'Search by title or amount...',
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Icon(Icons.search, size: 22),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 0,
              ),
              suffixIcon: value.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        _controller.clear();
                        context
                            .read<TransactionsHistoryCubit>()
                            .updateSearchQuery('');
                      },
                    )
                  : null,
              filled: true,
              fillColor: AppColors.black1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
          );
        },
      ),
    );
  }
}
