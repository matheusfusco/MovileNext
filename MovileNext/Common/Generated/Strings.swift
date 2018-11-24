// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum Localization {
  /// Add
  internal static let addCategory = Localization.tr("Localizable", "addCategory")
  /// Cancel
  internal static let cancelEditingCategory = Localization.tr("Localizable", "cancelEditingCategory")
  /// Delete
  internal static let deleteCategory = Localization.tr("Localizable", "deleteCategory")
  /// Edit
  internal static let editCategory = Localization.tr("Localizable", "editCategory")
  /// Error to delete category!
  internal static let errorDeletingCategory = Localization.tr("Localizable", "errorDeletingCategory")
  /// Error to load categories!
  internal static let errorLoadingCategories = Localization.tr("Localizable", "errorLoadingCategories")
  /// Error to save category!
  internal static let errorSavingCategory = Localization.tr("Localizable", "errorSavingCategory")
  /// Category name
  internal static let placeholderCategory = Localization.tr("Localizable", "placeholderCategory")
  /// Update
  internal static let updateCategory = Localization.tr("Localizable", "updateCategory")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
