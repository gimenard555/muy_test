class CompanyModel {
  String companyName;
  String address;
  List<Employee> employees;

  CompanyModel(
      {this.companyName,
      this.address,
      this.employees});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    this.companyName = json['company_name'];
    this.address = json['address'];
    if (json['employees'] != null) {
      this.employees = new List<Employee>();
      json['employees'].forEach((v) {
        employees.add(new Employee.fromJson(v));
      });
    }
  }
}

class Employee {

  int employeeId;
  String employeeName;
  String employeePosition;
  int employeeWage;
  List<Employee> employees;

  Employee({this.employeeId, this.employeeName, this.employeePosition, this.employeeWage, this.employees});

  Employee.fromJson(Map<String, dynamic> json) {
    this.employeeId = json['id'];
    this.employeeName = json['name'];
    this.employeePosition = json['position'];
    this.employeeWage = json['wage'];
    if (json['employees'] != null) {
      this.employees = new List<Employee>();
      json['employees'].forEach((v) {
        employees.add(new Employee.fromJson(v));
      });
    }
  }
}
 