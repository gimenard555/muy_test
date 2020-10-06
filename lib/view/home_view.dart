import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muy_test/controller/main_controller.dart';

class HomeView extends StatelessWidget {
  final MainController _mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            getListTitle(),
            SizedBox(
              height: 16,
            ),
            getFilterTextView(),
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
            margin: EdgeInsets.fromLTRB(5, 5, 5, 7),
            elevation: 10.0,
            child: ListTile(
              subtitle: Text(
                ' Id Empleado : ${_mainController.employeeListData[index].employeeId}',
              ),
              title: Text(
                  ' Nombre del Empleado : ${_mainController.employeeListData[index].employeeName}'),
            )));
  }

  Text getListTitle() {
    return Text(
      'EMPLEADOS EN ${_mainController.companyName.value.toUpperCase()}',
    );
  }

  TextFormField getFilterTextView() {
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
      //onChanged: _mainController.searchByFilter(),
    );
  }

  Row getFiltersIcon() {
    return Row(children: [
      IconButton(
          icon: Icon(
            Icons.filter_list_alt,
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
