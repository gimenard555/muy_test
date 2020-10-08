import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muy_test/controller/main_controller.dart';

class HomeView extends StatelessWidget {
  final MainController _mainController = Get.put(MainController());

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
            getFiltersIcon(),
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
              subtitle: Text(
                ' Id Empleado : ${_mainController.employeeListData[index].employeeId}',
                style: GoogleFonts.roboto(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal),
              ),
              title: Text(
                ' Nombre del Empleado : ${_mainController.employeeListData[index].employeeName}',
                style: GoogleFonts.roboto(
                    fontSize: 17,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal),
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
      Spacer(),
      IconButton(
          icon: Icon(
            Icons.monetization_on,
            color: Colors.grey,
          ),
          onPressed: () {
            _mainController.orderByWage();
          }),
    ]);
  }
}
