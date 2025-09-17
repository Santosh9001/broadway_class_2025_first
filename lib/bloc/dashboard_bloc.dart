import 'package:boroadwy_2025_session1/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/local/local_database.dart';
import '../services/local/local_storage.dart';
import 'dashboard_event.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final localStorage = LocalStorage();
  final database = LocalDatabase();
  DashboardBloc() : super(DasboardInitial()) {
    on<CategoryItemClickEvent>((event, emit) async {
      var productList = await database.retrieveProductsByCategory(event.name);
      if (productList.isEmpty) {
        emit(ErrorState());
      } else {
        emit(ProductFetchedState(productList));
      }
    });
  }
}
