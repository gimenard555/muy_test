import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muy_test/http/request.dart';
import 'package:muy_test/http/url.dart';
import 'package:muy_test/model/workers_list_data.dart';
import 'package:muy_test/view/employee_detail_view.dart';

class HomeController extends GetxController {
  ///Variable observables para la vista
  var employeeListData = List<Employee>().obs;
  var companyName = ''.obs;
  var filterInfo = 'Todos'.obs;
  var wageInfo = ''.obs;

  ///Variables que usa unicamente la clase
  var currentIndex = -1;
  var isOnlyNew = false;
  var highToLow = false;
  TextEditingController filterText;
  CompanyModel companyModel;

  @override
  void onInit() {
    this.filterText = TextEditingController();
    this.filterText.addListener(_searchByFilter);
    _apiGetEmployeeList();
    super.onInit();
  }

  ///Se obtiene listado de empleados desde el servicio
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

  /// Filtro para buscar por nombre de la persona a traves de la caja de texto
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

  ///Llamado al ordenamiento por salario
  orderByWage() {
    this.highToLow = !highToLow;
    if (this.highToLow) {
      this.wageInfo.value = 'Mayor - Menor';
      _bubbleSortHighLow();
    } else {
      this.wageInfo.value = 'Menor - Mayor';
      _bubbleSortLowHigh();
    }
  }

  ///Filtro para empleados que son nuevos sin funciones nativas y/o librerias
  getOnlyNewEmployee() {
    this.isOnlyNew = !this.isOnlyNew;
    if (this.isOnlyNew) {
      this.filterInfo.value = 'Empleados Nuevos';
      int tam = this.employeeListData.length;
      int index = 0;
      while (tam != 0) {
        if (!this.employeeListData[index].isNew) {
          this.employeeListData.remove(this.employeeListData[index]);
          tam--;
        } else {
          index++;
        }
        if (index == tam) {
          break;
        }
      }
    } else {
      this.filterInfo.value = 'Todos';
      _apiGetEmployeeList();
    }
  }

  ///Se abre el detalle del empleado seleccionado
  goToEmployeeDetail(int index) {
    this.currentIndex = index;
    Get.back();
    Get.to(EmployeeDetail());
  }

  /// Metodo para ordenar trabajadores por salario de menor a mayor con el
  /// metodo de la burbuja sin funciones nativas y/o librerias
  _bubbleSortLowHigh() {
    int lengthOfArray = this.employeeListData.length;
    for (int i = 0; i < lengthOfArray - 1; i++) {
      for (int j = 0; j < lengthOfArray - i - 1; j++) {
        if (this.employeeListData[j].employeeWage >
            this.employeeListData[j + 1].employeeWage) {
          Employee temp = this.employeeListData[j];
          this.employeeListData[j] = this.employeeListData[j + 1];
          this.employeeListData[j + 1] = temp;
        }
      }
    }
  }

  /// Metodo para ordenar trabajadores por salario de mayor a menor con el
  /// metodo de la burbuja sin funciones nativas y/o librerias
  _bubbleSortHighLow() {
    int lengthOfArray = this.employeeListData.length;
    for (int i = 0; i < lengthOfArray - 1; i++) {
      for (int j = 0; j < lengthOfArray - i - 1; j++) {
        if (this.employeeListData[j].employeeWage <
            this.employeeListData[j + 1].employeeWage) {
          Employee temp = this.employeeListData[j];
          this.employeeListData[j] = this.employeeListData[j + 1];
          this.employeeListData[j + 1] = temp;
        }
      }
    }
  }
}
