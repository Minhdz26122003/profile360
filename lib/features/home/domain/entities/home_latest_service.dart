class HomeLatestService {
  const HomeLatestService({
    required this.date,
    required this.services,
    required this.status,
    required this.actionChips,
  });

  final String date;
  final List<String> services;
  final String status;
  final List<String> actionChips;
}
