import 'dart:io';

class Student {
  String id;
  String name;
  int age;
  String major;
  double gpa;

  // Constructor
  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.major,
    required this.gpa,
  });

  // Method hien thi thong tin sinh vien
  void displayInfo() {
    print('|____________________________________________');
    print('| ID: $id');
    print('| Ten: $name');
    print('| Tuoi: $age');
    print('| Nganh: $major');
    print('| GPA: ${gpa.toStringAsFixed(2)}');
    print('|____________________________________________');
  }

  // Method hien thi thong tin ngan gon
  String getShortInfo() {
    return '| $id | $name | $age tuoi | $major | GPA: ${gpa.toStringAsFixed(2)}';
  }

  // Phuong thuc cap nhat GPA
  void updateGPA(double newGPA) {
    if (newGPA >= 0 && newGPA <= 4.0) {
      gpa = newGPA;
      print('Cap nhat GPA thanh cong');
    } else {
      print('GPA phai nam trong khoang 0.0 - 4.0');
    }
  }

  // Phuong thuc xep loai hoc luc gioi
  String getClassification() {
    if (gpa >= 3.6) return 'Xuat sac';
    if (gpa >= 3.2) return 'Gioi';
    if (gpa >= 2.5) return 'Kha';
    if (gpa >= 2.0) return 'Trung binh';
    return 'Yeu';
  }
}

// Class StudentManager - Quan ly danh sach sinh vien
class StudentManager {
  List<Student> students = [];

  void addStudent(Student student) {
    // Kiem tra ID da ton tai chua?
    if (students.any((s) => s.id == student.id)) {
      print('Loi: ID sinh vien da ton tai!');
      return;
    }
    students.add(student);
    print('Da them sinh vien ${student.name} thanh cong!');
  }

  void displayAllStudents() {
    if (students.isEmpty) {
      print('\n Danh sach sinh vien trong!');
      return;
    }
    print('\n╔═════════════════════════════════════════════════════════════╗');
    print('║           📚 DANH SÁCH SINH VIÊN (${students.length} sinh viên)║');
    print('╚═════════════════════════════════════════════════════════════╝');

    for (int i = 0; i < students.length; i++) {
      print('${i + 1}. ${students[i].getShortInfo()}');
    }
    print('_________________________________________________________________');
  }

  // Read - tim kiem sinh vien theo ID
  Student? findStudentById(String id) {
    try {
      return students.firstWhere((student) => student.id == id);
    } catch (e) {
      return null;
    }
  }

  // Read - Tim kiem sinh vien theo ten
  List<Student> searchStudentByName(String name) {
    return students
        .where(
          (student) => student.name.toLowerCase().contains(name.toLowerCase()),
        )
        .toList();
  }

  // Update
  void updateStudent(String id) {
    Student? student = findStudentById(id);
    if (student == null) {
      print('Khong tim thay sinh vien voi ID: $id');
      return;
    }
    print('\n Cap nhat thong tin cho sinh vien: ${student.name}');
    print('(Nhan Enter de giu nguyen gia tri hien tai)');

    // Cap nhat ten
    print('\n Ten hien tai: ${student.name}');
    print('Ten moi: ');
    String? newName = stdin.readLineSync();
    if (newName != null && newName.isNotEmpty) {
      student.name = newName;
    }
    // Cap nhat tuoi
    print('\n Tuoi hien tai: ${student.age}');
    print('Tuoi moi: ');
    String? ageInput = stdin.readLineSync();
    if (ageInput != null && ageInput.isNotEmpty) {
      student.age = int.tryParse(ageInput) ?? student.age;
    }

    // Cap nhat nganh
    print('\nNganh hien tai: ${student.major}');
    print('Nganh moi: ');
    String? newMajor = stdin.readLineSync();
    if (newMajor != null && newMajor.isNotEmpty) {
      student.major = newMajor;
    }

    // Cap nhat GPA
    print('\nGPA hien tai: ${student.gpa}');
    print('GPA moi (0.0 - 4.0)');
    String? gpaInput = stdin.readLineSync();
    if (gpaInput != null && gpaInput.isNotEmpty) {
      double? newGPA = double.tryParse(gpaInput);
      if (newGPA != null) {
        student.updateGPA(newGPA);
      }
    }
    print('\n Cap nhat thong tin thanh cong');
  }

  // DELETE - xoa sinh vien
  void deleteStudent(String id) {
    Student? student = findStudentById(id);

    if (student == null) {
      print('Khong tim thay sinh vien voi ID: $id');
      return;
    }

    print('\n Ban co chac muon xoa sinh vien "${student.name}"? (y/n)');
    String? confirm = stdin.readLineSync();
    if (confirm?.toLowerCase() == 'y') {
      students.remove(student);
      print('Da xoa sinh vien ${student.name} thanh cong!');
    } else {
      print('Huy thao tac xoa');
    }
  }

  // Thong ke sinh vien theo xep loai
  void displayStatistics() {
    if (students.isEmpty) {
      print('\n Chua co du lieu de thong ke');
      return;
    }
    Map<String, int> classifications = {
      'Xuat sac': 0,
      'Gioi': 0,
      'Kha': 0,
      'Trung binh': 0,
      'Yeu': 0,
    };

    for (var student in students) {
      String classification = student.getClassification();
      classifications[classification] =
          (classifications[classification] ?? 0) + 1;
    }

    double averageGPA =
        students.map((s) => s.gpa).reduce((a, b) => a + b) / students.length;
    print('\n╔═════════════════════════════════════╗');
    print('║       📊 THỐNG KÊ SINH VIÊN        ║');
    print('╚═════════════════════════════════════╝');
    print('Tổng số sinh viên: ${students.length}');
    print('GPA trung bình: ${averageGPA.toStringAsFixed(2)}');
    print('\n📈 Phân loại học lực:');

    classifications.forEach((key, value) {
      if (value > 0) {
        print('$key: $value sinh vien');
      }
    });
  }

  // Sap xep sinh vien theo GPA giam dan
  void sortByGPA() {
    students.sort((a, b) => b.gpa.compareTo(a.gpa));
    print('Da sap xep sinh vien theo GPA giam dan');
    displayAllStudents();
  }

  // Tim top sinh vien co GPA cao nhat
  void displayTopStudents(int count) {
    if (students.isEmpty) {
      print('\n Danh sach sinh vien trong!');
      return;
    }
    List<Student> sortedStudents = List.from(students);
    sortedStudents.sort((a, b) => b.gpa.compareTo(a.gpa));

    int displayCount = count > sortedStudents.length
        ? sortedStudents.length
        : count;

    print('\n ===========================');
    print('TOP $displayCount SINH VIEN XUAT SAC');
    print('\n ===========================');

    for (int i = 0; i < displayCount; i++) {
      print('\n Hang ${i + 1}:');
      sortedStudents[i].displayInfo();
    }
  }
}

void main() {
  StudentManager manager = StudentManager();
  bool running = true;

  // Them du lieu mau
  addSampleData(manager);
  print('╔═══════════════════════════════════════════════════╗');
  print('║  🎓 HỆ THỐNG QUẢN LÝ SINH VIÊN - DART CONSOLE  ║');
  print('╚═══════════════════════════════════════════════════╝\n');

  while (running) {
    displayMenu();
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addNewStudent(manager);
        break;
      case '2':
        manager.displayAllStudents();
        break;
      case '3':
        searchStudent(manager);
        break;
      case '4':
        updateStudentInfo(manager);
        break;
      case '5':
        deleteStudentById(manager);
        break;
      case '6':
        manager.displayStatistics();
        break;
      case '7':
        manager.sortByGPA();
        break;
      case '8':
        print('\nNhập số lượng sinh viên muốn hiển thị: ');
        int count = int.tryParse(stdin.readLineSync() ?? '5') ?? 5;
        manager.displayTopStudents(count);
        break;
      case '0':
        print('\n👋 Cảm ơn bạn đã sử dụng hệ thống!');
        running = false;
        break;
      default:
        print('❌ Lựa chọn không hợp lệ!');
    }
    if (running) {
      print('\nNhấn Enter để tiếp tục...');
      stdin.readLineSync();
      print('\n' * 2); // Clear screen effect
    }
  }
}

void displayMenu() {
  print('┌─────────────────────────────────────┐');
  print('│           📋 MENU CHÍNH            │');
  print('├─────────────────────────────────────┤');
  print('│ 1. ➕ Thêm sinh viên mới           │');
  print('│ 2. 📜 Hiển thị tất cả sinh viên    │');
  print('│ 3. 🔍 Tìm kiếm sinh viên           │');
  print('│ 4. ✏️  Cập nhật thông tin           │');
  print('│ 5. 🗑️  Xóa sinh viên                │');
  print('│ 6. 📊 Thống kê                      │');
  print('│ 7. 📈 Sắp xếp theo GPA             │');
  print('│ 8. 🏆 Top sinh viên xuất sắc       │');
  print('│ 0. 🚪 Thoát                         │');
  print('└─────────────────────────────────────┘');
  print('Lựa chọn của bạn: ');
}

void addNewStudent(StudentManager manager) {
  print('\n Them sinh vien moi\n');
  print('Nhap ID sinh vien: ');
  String? id = stdin.readLineSync();
  if (id == null || id.isEmpty) {
    print('ID khong duoc de trong');
    return;
  }

  print('Nhap ten sinh vien: ');
  String? name = stdin.readLineSync();
  if (name == null || name.isEmpty) {
    print('Ten khong duoc de trong');
    return;
  }

  print('Nhap tuoi');
  int? age = int.tryParse(stdin.readLineSync() ?? '');
  if (age == null) {
    print('Tuoi khong hop le!');
    return;
  }

  print('Nhập ngành học: ');
  String? major = stdin.readLineSync();
  if (major == null || major.isEmpty) {
    print('❌ Ngành học không được để trống!');
    return;
  }

  print('Nhập GPA (0.0 - 4.0): ');
  double? gpa = double.tryParse(stdin.readLineSync() ?? '');
  if (gpa == null || gpa < 0 || gpa > 4.0) {
    print('❌ GPA không hợp lệ! (Phải từ 0.0 - 4.0)');
    return;
  }

  Student newStudent = Student(
    id: id,
    name: name,
    age: age,
    major: major,
    gpa: gpa,
  );
  manager.addStudent(newStudent);
}

// Ham tim kiem sinh vien
void searchStudent(StudentManager manager) {
  print('\n🔍 TÌM KIẾM SINH VIÊN\n');
  print('1. Tìm theo ID');
  print('2. Tìm theo tên');
  print('Lựa chọn: ');

  String? choice = stdin.readLineSync();

  if (choice == '1') {
    print('\nNhập ID cần tìm: ');
    String? id = stdin.readLineSync();
    if (id != null && id.isNotEmpty) {
      Student? student = manager.findStudentById(id);
      if (student != null) {
        print('tim thay sinh vien');
        student.displayInfo();
        print('Xep loai: ${student.getClassification()}');
      } else {
        print('Khong tim thay sinh vien voi ID: $id');
      }
    }
  } else if (choice == '2') {
    print('\nNhap ten can tim: ');
    String? name = stdin.readLineSync();
    if (name != null && name.isNotEmpty) {
      List<Student> results = manager.searchStudentByName(name);
      if (results.isEmpty) {
        print('Khong tim thay sinh vien voi ten: $name');
      } else {
        print('\nTim thay ${results.length} sinh vien:');
        for (var student in results) {
          student.displayInfo();
        }
      }
    }
  } else {
    print('Lua chon khong hop le');
  }
}

// Ham cap nhat thong tin sinh vien
void updateStudentInfo(StudentManager manager) {
  print('\n Cap nhat thong tin sinh vien');
  print('Nhap ID sinh vien can cap nhat:');
  String? id = stdin.readLineSync();

  if (id != null && id.isNotEmpty) {
    manager.updateStudent(id);
  } else {
    print('ID khong duoc de trong');
  }
}

// Ham xoa sinh vien
void deleteStudentById(StudentManager manager) {
  print('\n Xoa sinh vien');
  print('Nhap ID sinh vien can xoa:');
  String? id = stdin.readLineSync();

  if (id != null && id.isNotEmpty) {
    manager.deleteStudent(id);
  } else {
    print('ID khong duoc de trong');
  }
}

// Ham them du lieu mau
void addSampleData(StudentManager manager) {
  manager.addStudent(
    Student(
      id: 'SV001',
      name: 'Nguyen Van A',
      age: 20,
      major: 'CNTT',
      gpa: 3.8,
    ),
  );
  manager.addStudent(
    Student(
      id: 'SV002',
      name: 'Tran Thi B',
      age: 22,
      major: 'Kinh Te',
      gpa: 3.4,
    ),
  );
  manager.addStudent(
    Student(id: 'SV003', name: 'Le Van C', age: 21, major: 'Dien Tu', gpa: 2.9),
  );
  manager.addStudent(
    Student(
      id: 'SV004',
      name: 'Pham Thi D',
      age: 23,
      major: 'Co Khi',
      gpa: 3.1,
    ),
  );
  print('Da them du lieu mau thanh cong!');
}
