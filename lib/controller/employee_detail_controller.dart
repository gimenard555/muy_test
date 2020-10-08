import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muy_test/model/workers_list_data.dart';

class EmployeeDetailController extends GetxController {
  Employee currentEmployee;
  var isNewColor = Colors.white.obs;
  var isNewStyle = GoogleFonts.roboto(
          fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold)
      .obs;

  @override
  void onInit() {
    this.currentEmployee = Employee();
    _getNewState();
    super.onInit();
  }

  ///Titulo para listado de empleados (Jerarquia)
  String subEmployeesTitle(Employee employee) {
    this.currentEmployee = employee;
    if (this.currentEmployee.employees.isEmpty) {
      return 'Ningun empleado le reporta a ${this.currentEmployee.employeeName} ';
    } else {
      return 'Empleados que le reportan a ${this.currentEmployee.employeeName}';
    }
  }

  ///Se cambia interfaz de boton teniendo en cuenta la seleccion si es nuevo o no
  _getNewState() {
    if (this.currentEmployee.isNew) {
      this.isNewColor.value = Colors.teal;
      this.isNewStyle.value = GoogleFonts.roboto(
          fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold);
    } else {
      this.isNewColor.value = Colors.white;
      this.isNewStyle.value = GoogleFonts.roboto(
          fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold);
    }
  }

  ///Se actualiza el estado del empleado seleccionado
  updateIsNewState() {
    this.currentEmployee.isNew = !this.currentEmployee.isNew;
    _getNewState();
  }

  goBack() {
    Get.back();
  }
}
