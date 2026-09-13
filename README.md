<div align="center">

<img src="screenshots/logo.png" width="130" alt="Money Flow Logo" style="border-radius: 24px;" />

# 💸 Money Flow

**Smart, Offline-First Personal Finance & Expense Tracker for Mobile**

[![Flutter Version](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![State Management](https://img.shields.io/badge/State-BLoC%20%2F%20Cubit-blueviolet)](https://bloclibrary.dev)
[![Storage](https://img.shields.io/badge/Database-Hive%20NoSQL-FFA000)](https://pub.dev/packages/hive)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-brightgreen)](#)

A modern, privacy-first personal finance app built with Flutter. Track daily income and expenses, set category budgets, automate recurring bills, and gain deep visual insights into your cash flow—with 100% of your data stored securely offline on your device.

</div>

---

## 📱 App Previews & Screenshots

### 🏠 1. Dashboard, Analytics & Budgets
| Home Dashboard | Analytics: Overview | Analytics: Trends | Category Budgets | Transaction History |
| :---: | :---: | :---: | :---: | :---: |
| <img src="screenshots/home.png" width="175" /> | <img src="screenshots/charts.png" width="175" /> | <img src="screenshots/charts2.png" width="175" /> | <img src="screenshots/budget.png" width="175" /> | <img src="screenshots/all_transactions.png" width="175" /> |

---

### 💸 2. Transactions, Categories & Recurring Flows
| Add Transaction | Manage Categories | Add Custom Category | Recurring Bills |
| :---: | :---: | :---: | :---: |
| <img src="screenshots/add_transaction.png" width="220" /> | <img src="screenshots/manage_categories.png" width="220" /> | <img src="screenshots/add_category.png" width="220" /> | <img src="screenshots/recurring_transactions.png" width="220" /> |

---

### 🔒 3. Security, Privacy & Data Management
| App Lock Screen | Security Settings | Backup Data | Restore Data |
| :---: | :---: | :---: | :---: |
| <img src="screenshots/app_lock.png" width="220" /> | <img src="screenshots/app_lock_settings.png" width="220" /> | <img src="screenshots/backup.png" width="220" /> | <img src="screenshots/restore.png" width="220" /> |

---

### 🚀 4. Onboarding Walkthrough
| Step 1: Track Pennies | Step 2: Smart Budgets | Step 3: Visual Insights | Step 4: Quick Setup |
| :---: | :---: | :---: | :---: |
| <img src="screenshots/onboarding1.png" width="220" /> | <img src="screenshots/onboarding2.png" width="220" /> | <img src="screenshots/onboarding3.png" width="220" /> | <img src="screenshots/onboarding4.png" width="220" /> |

---

### ⚙️ 5. Settings, Preferences & Profile
| Settings View | Multi-Currency Selector | User Profile | Reset Data |
| :---: | :---: | :---: | :---: |
| <img src="screenshots/settings.png" width="220" /> | <img src="screenshots/currency.png" width="220" /> | <img src="screenshots/profile.png" width="220" /> | <img src="screenshots/reset.png" width="220" /> |

---

## 🌟 Key Features

### 🏠 Cash Flow Dashboard
- **Live Net Balance Calculation:** Computes total cash flow ($\text{Income} - \text{Expenses}$) in real time.
- **Privacy Mask (`••••••`):** Toggle balance visibility on and off for privacy in public spaces.
- **Embedded Trend Charts:** Interactive Line and Bar charts directly on the dashboard reflecting recent money movement.
- **Recent Transactions Feed:** Color-coded feed showing latest entries with custom category icons and timestamps.

### 💸 Frictionless Transaction Tracking
- **Income & Expense Flows:** Distinct workflows with amount, category, date, and custom notes.
- **Swipe-to-Action:** Gesture-driven list items powered by `flutter_slidable` to quickly edit or delete transactions.
- **Searchable Ledger:** Filter and audit past records by type, category, or timeframe.

### 🎯 Smart Category Budgets
- **Category Spending Caps:** Set weekly or monthly allowances on individual categories.
- **Visual Progress Bars:** Track consumed vs. remaining funds dynamically.
- **Over-Budget Alerts:** Proactive warnings when approaching or exceeding limits.

### 📊 Deep Visual Reports & Analytics
- **Interactive Pie Charts:** Visual category breakdown powered by `fl_chart` to spot spending leaks.
- **Comparative Bar Charts:** Side-by-side earnings vs. expenses over customizable intervals.
- **Budget Performance Summary:** Clear overview of budget health across all active categories.

### 🔁 Automated Recurring Transactions
- **Bill & Subscription Engine:** Set up rent, salaries, gym memberships, and streaming subscriptions.
- **Flexible Intervals:** Supports Daily, Weekly, Monthly, and Yearly frequencies.
- **Background Processor:** Automatically evaluates due transactions on app start and posts them into the ledger.

### 🔒 Biometric Security & App Lock Gate
- **AppLockGate:** Restricts access whenever the app is launched or resumed from the background.
- **Biometric Authentication:** Support for Fingerprint, Touch ID, and Face ID via `local_auth`.
- **Encrypted PIN:** Hardware-backed numeric security passcode stored securely using `flutter_secure_storage`.
- **Auto-Lock Timer:** Configurable timeout intervals.

### 💾 100% Offline Data & Backup / Restore
- **Privacy First:** Zero cloud tracking; all records are stored locally using Hive NoSQL.
- **Export / Import:** One-click backup and restore of all transactions, budgets, categories, and settings.
- **Factory Reset:** Safe, complete local database wipe tool.

---

## 🏛 Architecture & Project Structure

Money Flow is built with a **Feature-First Clean Architecture** using **BLoC / Cubit** for reactive state management.

```
lib/
├── core/                        # Global & cross-cutting components
│   ├── constants/               # Colors, themes, typography, dimensions
│   ├── services/                # Hive database, recurring background processor
│   ├── utils/                   # Formatters, helpers, toast notifications
│   └── widgets/                 # Atomic UI components (custom text, buttons, dividers)
│
├── features/                    # Feature-First Modules
│   ├── home/                    # Dashboard, balance visibility cubit & widgets
│   ├── transactions/            # Add, edit, delete transactions & ledger cubit
│   ├── transactions_history/    # Searchable chronological history & filters
│   ├── budget/                  # Category spending caps, cycle calculators & cubit
│   ├── reports/                 # fl_chart analytics, pie charts & breakdown widgets
│   ├── security/                # Biometrics, PIN service, AppLock gate & cubit
│   ├── onboarding/              # First-run walkthrough, currency & profile setup
│   ├── calculator/              # Embedded finance arithmetic calculator
│   ├── categories/              # Category models, color pickers, icon selectors
│   ├── profile/                 # User avatar, display name, and profile management
│   ├── settings/                # Currency switcher, preferences, recurring views
│   └── data_management/         # Backup, JSON serialization, restore & reset services
│
└── main.dart                    # App entry point, MultiBlocProvider, Hive initialization
```

---

## 🛠 Tech Stack

| Category | Technology | Description |
|---|---|---|
| **Framework** | [Flutter](https://flutter.dev) (Dart 3.x) | Cross-platform native UI toolkit |
| **State Management** | [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) | Predictable, reactive BLoC / Cubit state management |
| **Local Database** | [`hive`](https://pub.dev/packages/hive) & [`hive_flutter`](https://pub.dev/packages/hive_flutter) | Ultra-fast lightweight NoSQL local key-value database |
| **Encrypted Storage** | [`flutter_secure_storage`](https://pub.dev/packages/flutter_secure_storage) | Hardware-backed keystore/keychain for security PIN |
| **Biometrics** | [`local_auth`](https://pub.dev/packages/local_auth) | Fingerprint, Touch ID, and Face ID authentication |
| **Visual Charts** | [`fl_chart`](https://pub.dev/packages/fl_chart) | Interactive and animated financial charts |
| **Navigation** | [`persistent_bottom_nav_bar_v2`](https://pub.dev/packages/persistent_bottom_nav_bar_v2) | Custom styled bottom tab navigation bar |
| **Gestures** | [`flutter_slidable`](https://pub.dev/packages/flutter_slidable) | Swipeable list items for quick edit/delete |
| **In-App Alerts** | [`toastification`](https://pub.dev/packages/toastification) | Modern animated toast notification system |
| **Iconography** | [`font_awesome_flutter`](https://pub.dev/packages/font_awesome_flutter) | Comprehensive vector icon set |

