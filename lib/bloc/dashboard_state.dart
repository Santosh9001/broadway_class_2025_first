import 'package:boroadwy_2025_session1/models/products.dart';

abstract class DashboardState {}

class DasboardInitial extends DashboardState {}

class ProductFetchedState extends DashboardState {
  List<Products> productLists;
  ProductFetchedState(this.productLists);
}

class ErrorState extends DashboardState {}
