abstract class DashboardEvent {}

class CategoryItemClickEvent extends DashboardEvent {
  String name;
  CategoryItemClickEvent(this.name);
}
