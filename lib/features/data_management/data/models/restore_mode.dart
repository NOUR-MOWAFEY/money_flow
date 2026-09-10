enum RestoreMode {
  merge,
  replace,
}

extension RestoreModeExtension on RestoreMode {
  String get title {
    switch (this) {
      case RestoreMode.merge:
        return 'Merge with Existing Data';
      case RestoreMode.replace:
        return 'Replace Existing Data';
    }
  }

  String get description {
    switch (this) {
      case RestoreMode.merge:
        return 'Keep your current data and add records from the backup file.';
      case RestoreMode.replace:
        return 'Erase current data for the selected types and replace with backup records.';
    }
  }
}
