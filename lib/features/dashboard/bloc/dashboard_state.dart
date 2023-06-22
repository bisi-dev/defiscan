part of 'dashboard_cubit.dart';

@immutable
class DashboardState extends Equatable {
  final int currentIndex;

  const DashboardState(this.currentIndex);

  @override
  List<Object?> get props => [currentIndex];
}
