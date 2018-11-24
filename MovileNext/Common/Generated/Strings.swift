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
  /// Camera
  internal static let camera = Localization.tr("Localizable", "camera")
  /// Cancel
  internal static let cancelEditingCategory = Localization.tr("Localizable", "cancelEditingCategory")
  /// Cancel
  internal static let cancelSelectingPoster = Localization.tr("Localizable", "cancelSelectingPoster")
  /// Category
  internal static let category = Localization.tr("Localizable", "category")
  /// Categories
  internal static let categoryDefault = Localization.tr("Localizable", "categoryDefault")
  /// Category name
  internal static let categoryName = Localization.tr("Localizable", "categoryName")
  /// Delete
  internal static let deleteCategory = Localization.tr("Localizable", "deleteCategory")
  /// Edit
  internal static let editCategory = Localization.tr("Localizable", "editCategory")
  /// Error to delete category!
  internal static let errorDeletingCategory = Localization.tr("Localizable", "errorDeletingCategory")
  /// Error to delete movie!
  internal static let errorDeletingMovie = Localization.tr("Localizable", "errorDeletingMovie")
  /// Please fill all the data!
  internal static let errorFillAllMovieData = Localization.tr("Localizable", "errorFillAllMovieData")
  /// Error to load categories!
  internal static let errorLoadingCategories = Localization.tr("Localizable", "errorLoadingCategories")
  /// Error to load movies!
  internal static let errorLoadingMovie = Localization.tr("Localizable", "errorLoadingMovie")
  /// Error to save category!
  internal static let errorSavingCategory = Localization.tr("Localizable", "errorSavingCategory")
  /// Error while saving the movie!
  internal static let errorSavingMovie = Localization.tr("Localizable", "errorSavingMovie")
  /// Films
  internal static let homeTitle = Localization.tr("Localizable", "homeTitle")
  /// This movie was already added before!
  internal static let movieAlreadyExists = Localization.tr("Localizable", "movieAlreadyExists")
  /// Photo Album
  internal static let photoAlbum = Localization.tr("Localizable", "photoAlbum")
  /// Photo Library
  internal static let photoLibrary = Localization.tr("Localizable", "photoLibrary")
  /// Category name
  internal static let placeholderCategory = Localization.tr("Localizable", "placeholderCategory")
  /// Select poster
  internal static let selectPoster = Localization.tr("Localizable", "selectPoster")
  /// From where do you want to select the poster?
  internal static let selectPosterFrom = Localization.tr("Localizable", "selectPosterFrom")
  /// Update
  internal static let updateCategory = Localization.tr("Localizable", "updateCategory")
  /// Update
  internal static let updateMovieBtnTitle = Localization.tr("Localizable", "updateMovieBtnTitle")
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
