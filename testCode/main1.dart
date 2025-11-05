
import 'dart:io';


void main() {
  print('=================================');
  print('🧮 MÁY TÍNH ĐON GIẢN');
  print('=================================\n');
  
  bool continueCalculating = true;
  
  while(continueCalculating){
    //show menu
    displayMenu();
    // nhan lua chon cua user
    String? choice = stdin.readLineSync();
    
    if(choice == '0'){
      print('\n Cam on ban da su dung may tinh');
      continueCalculating = false;
      break;
    }
    // Nhap so thu nhat
    print('\nNhap so thu nhat: ');
    double? num1 = getNumberInput();
    if(num1 == null) continue;
    
    // Nhap so thu hai
     print('\nNhap so thu hai: ');
    double? num2 = getNumberInput();
    if(num2 == null) continue;
    
    // Thuc hien phep tinh
    performCalculation(choice,num1,num2);
    
    print('\n--------------------------\n');
    
  }
}

void displayMenu(){
  print('Chon phep tinh:');
  print('1. Cong (+)');
  print('2. Tru (-)');
  print('3. Nhan (x)');
  print('4. Chia (÷)');
  print('5. Chia lay du (%)');
  print('6. Luy thua (^)');
  print('0. Thoat');
  print('-----------------');
  print('Lua chon cua ban');
}

// Ham nhan input so tu nguoi dung
double? getNumberInput(){
  String? input = stdin.readLineSync();
  
  try{
    return double.parse(input!);
  }catch (e){
    print('Loi: Vui long nhap 1 so hop le');
    return null;
  }
  
}

// Ham thuc hien phep tinh
void performCalculation(String? choice, double num1, double num2){
  double result;
  String operation;
  
  switch (choice){
    case '1':
      result = add(num1,num2);
      operation = '+';
      break;
    case '2':
      result = subtract(num1,num2);
      operation = '-';
      break;
    case '3':
      result = multiply(num1, num2);
      operation = 'x';
      break;
    case '4':
        if(num2 == 0){
          print(' Loi: Khong the chia cho 0');
          return;
        }
      result = divide(num1, num2);
      operation = '÷';
      break;
    case '5':
      if(num2 == 0){
        print('Loi : Khong the chia cho 0');
        return;
      }
      result = modulus(num1, num2);
      operation = '%';
      break;
    case '6':
      result = power(num1, num2);
      operation = '^';
      break;
    default:
      print('Lua chon khong hop le');
      return;
      
  }
  // Hien thi ket qua
  displayResult(num1, num2, operation, result);
  
}

// Ham hien thi ket qua
void displayResult(double num1, double num2, String operation, double result){
  print('\n Ket qua:');
  print('$num1 $operation $num2 = $result');
}

// Cac ham tinh toan
double add(double a, double b) => a + b;

double subtract(double a, double b) => a - b;

double multiply(double a, double b) => a * b;

double divide(double a, double b) => a / b;

double modulus(double a, double b) => a % b;

double power(double base, double exponent){
  double result = 1;
  for (int i = 0; i < exponent; i++){
    result *= base;
  }
  return result;
}
