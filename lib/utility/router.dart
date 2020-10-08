import 'package:get/get.dart';
import 'package:muy_test/view/employee_detail_view.dart';
import 'package:muy_test/view/home_view.dart';

class CustomRouter {
  static final route = [
    GetPage(name: '/homeView', page: () => HomeView()),
    GetPage(name: '/employeeDetail', page: () => EmployeeDetail())
  ];
}
