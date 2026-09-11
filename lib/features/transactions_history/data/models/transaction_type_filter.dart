enum TransactionTypeFilter {
  all('All'),
  expenses('Expenses'),
  income('Income');

  const TransactionTypeFilter(this.label);

  final String label;

  bool get isAll => this == TransactionTypeFilter.all;
  bool get isExpenses => this == TransactionTypeFilter.expenses;
  bool get isIncome => this == TransactionTypeFilter.income;
}
