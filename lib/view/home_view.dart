import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muy_test/controller/main_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController _mainController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(
          () => getListTitle(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            getFilterEditText(),
            Obx(() => getFiltersIcon()),
            Expanded(
              child: Obx(
                () => getHolder(),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  ListView getHolder() {
    return ListView.builder(
        itemCount: _mainController.employeeListData.length,
        itemBuilder: (context, index) => Card(
            elevation: 2.0,
            child: ListTile(
              title: Text(
                ' ${_mainController.employeeListData[index].employeeId} - Nombre: ${_mainController.employeeListData[index].employeeName}',
                style: GoogleFonts.roboto(
                    fontSize: 17,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal),
              ),
              trailing: Text(
                'Salario : ${_mainController.employeeListData[index].employeeWage}',
                textAlign: TextAlign.end,
                style: GoogleFonts.roboto(
                    fontSize: 17,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => _mainController.goToEmployeeDetail(index),
            )));
  }

  Text getListTitle() {
    return Text(
      'EMPLEADOS EN ${_mainController.companyName.value.toUpperCase()}',
      style: TextStyle(fontSize: 15),
    );
  }

  TextFormField getFilterEditText() {
    return TextFormField(
      controller: _mainController.filterText,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        hintText: 'Buscar Trabajador',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
      ),
    );
  }

  Row getFiltersIcon() {
    return Row(children: [
      IconButton(
          icon: Icon(
            Icons.filter_list,
            color: Colors.grey,
          ),
          onPressed: () {
            _mainController.getOnlyNewEmployee();
          }),
      Text(
        '${_mainController.filterInfo}',
        style: GoogleFonts.roboto(
            fontSize: 17, color: Colors.black, fontWeight: FontWeight.normal),
      ),
      Spacer(),
      IconButton(
          icon: Icon(
            Icons.monetization_on,
            color: Colors.grey,
          ),
          onPressed: () {
            _mainController.orderByWage();
          }),
      Text(
        '${_mainController.wageInfo}',
        style: GoogleFonts.roboto(
            fontSize: 17, color: Colors.black, fontWeight: FontWeight.normal),
      ),
    ]);
  }
}
