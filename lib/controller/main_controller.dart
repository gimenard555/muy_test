import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muy_test/http/request.dart';
import 'package:muy_test/http/url.dart';
import 'package:muy_test/model/workers_list_data.dart';

class MainController extends GetxController {
  var employeeListData = List<Employee>().obs;
  var companyName = ''.obs;
  TextEditingController filterText;
  CompanyModel companyModel;

  @override
  void onInit() {
    this.filterText = TextEditingController();
    this.filterText.addListener(_searchByFilter);
    _apiGetEmployeeList();
    super.onInit();
  }

  void _apiGetEmployeeList() async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    Request request = Request(url: urlWorkersList, body: null);
    request.get().then((value) {
      this.companyModel = CompanyModel.fromJson(json.decode(value.body));
      this.companyName.value = companyModel.companyName;
      this.employeeListData.value = companyModel.employees;
      Get.back();
    }).catchError((onError) {
      print(onError);
    });
  }

  _searchByFilter() {
    if (filterText.text.isNotEmpty) {
      this.employeeListData.value = this
          .employeeListData
          .where((employee) => employee.employeeName
              .toLowerCase()
              .contains(filterText.text.toLowerCase()))
          .toList();
    } else {
      this.employeeListData.value = companyModel.employees;
    }
  }

  orderByWage() {
    this.employeeListData.sort(
        (Employee a, Employee b) => a.employeeWage.compareTo(b.employeeWage));
  }

  getOnlyNewEmployee() {}
}
