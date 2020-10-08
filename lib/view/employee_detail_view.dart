import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muy_test/controller/employee_detail_controller.dart';
import 'package:muy_test/controller/main_controller.dart';
import 'package:muy_test/model/workers_list_data.dart';

class EmployeeDetail extends StatelessWidget {
  final HomeController _mainController = Get.find();
  final EmployeeDetailController _employeeController =
      Get.put(EmployeeDetailController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: getEmployeePosition(),
        leading: BackButton(
            color: Colors.white, onPressed: () => _employeeController.goBack()),
      ),
      backgroundColor: Colors.white,
      body: Card(
        margin: EdgeInsets.all(15),
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: getEmployeeName(),
              ),
              SizedBox(height: 16),
              Container(
                alignment: Alignment.centerRight,
                child: getEmployeeWage(),
              ),
              SizedBox(height: 16),
              Container(
                alignment: Alignment.center,
                child: getCustomImage(),
              ),
              SizedBox(height: 16),
              Container(
                width: 300,
                alignment: Alignment.topRight,
                child: Obx(
                  () => getIsNew(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                _employeeController.subEmployeesTitle(_mainController
                    .employeeListData[_mainController.currentIndex]),
                style: GoogleFonts.roboto(
                    fontSize: 17,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: getCarrusel(),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Text getEmployeeName() {
    return Text(
      '${_mainController.employeeListData[_mainController.currentIndex].employeeName}',
      style: GoogleFonts.roboto(
          fontSize: 30, color: Colors.teal, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Text getEmployeePosition() {
    return Text(
        '${_mainController.employeeListData[_mainController.currentIndex].employeePosition}');
  }

  Text getEmployeeWage() {
    return Text(
      'SALARIO: ${_mainController.employeeListData[_mainController.currentIndex].employeeWage}',
      style: GoogleFonts.roboto(
          fontSize: 17, color: Colors.black45, fontWeight: FontWeight.bold),
      textAlign: TextAlign.end,
    );
  }

  Card getSubEmployeeList(Employee employee) {
    return Card(
        elevation: 1.0,
        child: ListTile(
            onTap: () => {
                  /* _mainController.goToEmployeeDetail(
                      _mainController.employeeListData.indexOf(employee))*/
                },
            title: Column(children: [
              Text(
                ' ${employee.employeeName}',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${employee.employeeId}',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ])));
  }

  Image getCustomImage() {
    return Image.network(
      'https://pbs.twimg.com/media/Ejra-ppXkAMMPcB?format=jpg&name=medium',
      height: 200,
    );
  }

  ListTile getIsNew() {
    return ListTile(
        onTap: () => {
              _employeeController.updateIsNewState(),
              _mainController
                      .employeeListData[_mainController.currentIndex].isNew =
                  !_mainController
                      .employeeListData[_mainController.currentIndex].isNew
            },
        title: Card(
          elevation: 2.0,
          color: _employeeController.isNewColor.value,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Es Empleado Nuevo',
              textAlign: TextAlign.center,
              style: _employeeController.isNewStyle.value,
            ),
          ),
        ));
  }

  CarouselSlider getCarrusel() {
    List<Employee> currentList = _mainController
        .employeeListData[_mainController.currentIndex].employees;
    return CarouselSlider(
      items: currentList.map((e) => getSubEmployeeList(e)).toList(),
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 2.0,
        initialPage: 2,
      ),
    );
  }
}
