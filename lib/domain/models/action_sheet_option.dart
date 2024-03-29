// TODO: Freeze
/// Object that holds option info for the ActionSheet.
class ActionSheetOption<T> {
  /// How the option is viewed in the modal.
  final String label;

  /// The value of the option.
  final T value;

  /// Display an arrow to show that there are nested options.
  final bool hasMore;

  /// Display as info or error type action.
  final bool isDestructive;

  ActionSheetOption({
    required this.label,
    required this.value,
    this.hasMore = false,
    this.isDestructive = false,
  });
}
