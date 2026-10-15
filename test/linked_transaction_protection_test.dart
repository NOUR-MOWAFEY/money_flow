import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/view_models/transactions_cubit/transactions_cubit.dart';
import 'package:money_flow/features/transactions/views/widgets/custom_slidable.dart';
import 'package:money_flow/features/transactions/views/widgets/linked_transaction_dialog.dart';

class _FakeHiveService extends Fake implements HiveService {
  final List<TransactionModel> transactions = [];
  bool deleteCalled = false;
  bool editCalled = false;

  @override
  List<TransactionModel> getTransactions() => List.from(transactions);

  @override
  List<CategoryModel> getCategories() => [];

  @override
  Stream<BoxEvent> watchCategories() => const Stream.empty();

  @override
  Stream<BoxEvent> watchTransactions() => const Stream.empty();

  @override
  Future<void> deleteTransaction(TransactionModel transaction) async {
    deleteCalled = true;
    transactions.remove(transaction);
  }

  bool isEnvActive = true;

  @override
  bool isTransactionEnvironmentActive(TransactionModel transaction) =>
      isEnvActive && transaction.isEnvironmentLinked;

  @override
  Future<void> editTransaction(
    TransactionModel transaction, {
    String? title,
    double? amount,
    bool? isExpense,
    DateTime? date,
  }) async {
    editCalled = true;
  }
}

void main() {
  late Directory tempDir;

  setUpAll(() {
    HiveService.registerAdapters();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('linked_tx_test_');
    Hive.init(tempDir.path);
    await HiveService.openBoxes();
  });

  tearDown(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('TransactionModel isEnvironmentLinked', () {
    test('returns true when environmentId is set', () {
      final tx = TransactionModel(
        title: 'Custom Title',
        amount: 100,
        date: DateTime.now(),
        isExpense: true,
        environmentId: 'env_123',
      );
      expect(tx.isEnvironmentLinked, isTrue);
    });

    test(
      'returns true for legacy prefixed titles even without environmentId',
      () {
        final tx1 = TransactionModel(
          title: 'Environment: Vacation',
          amount: 500,
          date: DateTime.now(),
          isExpense: true,
        );
        final tx2 = TransactionModel(
          title: 'Top-up: Vacation',
          amount: 200,
          date: DateTime.now(),
          isExpense: true,
        );
        final tx3 = TransactionModel(
          title: 'Remaining from Vacation',
          amount: 150,
          date: DateTime.now(),
          isExpense: false,
        );

        expect(tx1.isEnvironmentLinked, isTrue);
        expect(tx2.isEnvironmentLinked, isTrue);
        expect(tx3.isEnvironmentLinked, isTrue);
      },
    );

    test('returns false for regular independent transactions', () {
      final tx = TransactionModel(
        title: 'Groceries',
        amount: 50,
        date: DateTime.now(),
        isExpense: true,
      );
      expect(tx.isEnvironmentLinked, isFalse);
    });
  });

  group('TransactionsCubit protection for linked transactions', () {
    late _FakeHiveService fakeService;
    late TransactionsCubit cubit;

    setUp(() {
      fakeService = _FakeHiveService();
      cubit = TransactionsCubit(fakeService);
    });

    tearDown(() {
      cubit.close();
    });

    test('deleteTransaction blocks deletion of linked transaction', () async {
      final linkedTx = TransactionModel(
        title: 'Environment: Trip',
        amount: 1000,
        date: DateTime.now(),
        isExpense: true,
        environmentId: 'env_trip',
      );

      await cubit.deleteTransaction(linkedTx);

      expect(cubit.state, isA<TransactionsFailure>());
      final failure = cubit.state as TransactionsFailure;
      expect(failure.message, contains('cannot be deleted directly'));
      expect(fakeService.deleteCalled, isFalse);
    });

    test('editTransaction blocks modification of linked transaction', () async {
      final linkedTx = TransactionModel(
        title: 'Environment: Trip',
        amount: 1000,
        date: DateTime.now(),
        isExpense: true,
        environmentId: 'env_trip',
      );

      await cubit.editTransaction(linkedTx, amount: 1200);

      expect(cubit.state, isA<TransactionsFailure>());
      final failure = cubit.state as TransactionsFailure;
      expect(failure.message, contains('cannot be modified directly'));
      expect(fakeService.editCalled, isFalse);
    });

    test(
      'deleteTransaction allows deletion if environment was deleted',
      () async {
        final orphanedTx = TransactionModel(
          title: 'Environment: Trip',
          amount: 1000,
          date: DateTime.now(),
          isExpense: true,
          environmentId: 'env_deleted',
        );

        fakeService.transactions.add(orphanedTx);
        fakeService.isEnvActive = false; // Environment is deleted

        await cubit.deleteTransaction(orphanedTx);

        expect(fakeService.deleteCalled, isTrue);
        expect(fakeService.transactions.contains(orphanedTx), isFalse);
        expect(cubit.state, isA<TransactionsSuccess>());
      },
    );

    test(
      'editTransaction allows modification if environment was deleted',
      () async {
        final orphanedTx = TransactionModel(
          title: 'Environment: Trip',
          amount: 1000,
          date: DateTime.now(),
          isExpense: true,
          environmentId: 'env_deleted',
        );

        fakeService.isEnvActive = false; // Environment is deleted

        await cubit.editTransaction(orphanedTx, title: 'Renamed Trip');

        expect(fakeService.editCalled, isTrue);
      },
    );
  });

  group('showLinkedTransactionDialog & CustomSlidable UI', () {
    testWidgets(
      'showLinkedTransactionDialog displays and closes on button tap',
      (tester) async {
        final linkedTx = TransactionModel(
          title: 'Environment: Renovation',
          amount: 2500,
          date: DateTime.now(),
          isExpense: true,
          environmentId: 'env_reno',
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () =>
                      showLinkedTransactionDialog(context, linkedTx),
                  child: const Text('Open Dialog'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        expect(find.text('Environment Transaction'), findsOneWidget);
        expect(find.textContaining('Environment: Renovation'), findsOneWidget);
        expect(find.text('Understood'), findsOneWidget);

        await tester.tap(find.text('Understood'));
        await tester.pumpAndSettle();

        expect(find.text('Environment Transaction'), findsNothing);
      },
    );

    testWidgets(
      'CustomSlidable for linked transaction triggers dialog on delete action',
      (tester) async {
        final env = EnvironmentModel(
          id: 'env_wedding',
          name: 'Wedding',
          initialAmount: 5000,
          currentBalance: 5000,
          createdAt: DateTime.now(),
        );
        await tester.runAsync(() async {
          await HiveService.instance.addEnvironment(env);
        });

        final linkedTx = TransactionModel(
          title: 'Environment: Wedding',
          amount: 5000,
          date: DateTime.now(),
          isExpense: true,
          environmentId: 'env_wedding',
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomSlidable(
                transactionModel: linkedTx,
                child: const ListTile(title: Text('Environment: Wedding')),
              ),
            ),
          ),
        );

        // Drag to reveal slidable actions
        await tester.drag(
          find.text('Environment: Wedding'),
          const Offset(200, 0),
        );
        await tester.pumpAndSettle();

        // Lock icon should be visible for linked transaction
        expect(find.byIcon(Icons.lock_outline_rounded), findsOneWidget);
      },
    );

    testWidgets(
      'CustomSlidable for deleted environment transaction allows delete action (unlocked)',
      (tester) async {
        final orphanedTx = TransactionModel(
          title: 'Environment: Former Project',
          amount: 500,
          date: DateTime.now(),
          isExpense: true,
          environmentId: 'env_former',
        );

        bool deleted = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomSlidable(
                transactionModel: orphanedTx,
                onDelete: () => deleted = true,
                child: const ListTile(title: Text('Environment: Former Project')),
              ),
            ),
          ),
        );

        // Drag to reveal slidable actions
        await tester.drag(
          find.text('Environment: Former Project'),
          const Offset(200, 0),
        );
        await tester.pumpAndSettle();

        // Lock icon should NOT be visible, regular delete icon SHOULD be visible
        expect(find.byIcon(Icons.lock_outline_rounded), findsNothing);
        expect(find.byIcon(Icons.delete), findsOneWidget);

        // Tap delete action
        await tester.tap(find.byIcon(Icons.delete));
        await tester.pump();

        expect(deleted, isTrue);
      },
    );
  });
}
