class CalculatorLogic {
  String displayText = '0';
  String operand1 = '';
  String operand2 = '';
  String operator = '';
  bool shouldResetDisplay = false;

  // Reset all
  void clear() {
    displayText = '0';
    operand1 = '';
    operand2 = '';
    operator = '';
    shouldResetDisplay = false;
  }

  // Xoá kí tự cuối cùng
  void backspace() {
    if (displayText.length > 1) {
      displayText = displayText.substring(0, displayText.length - 1);
    } else {
      displayText = '0';
    }
  }

  void addDigit(String digit) {
    if (shouldResetDisplay) {
      displayText = digit;
      shouldResetDisplay = false;
    } else {
      if (displayText == '0') {
        displayText = digit;
      } else {
        displayText += digit;
      }
    }
  }

  // Thêm chữ số vào display
  void addDecimalPoint() {
    if (shouldResetDisplay) {
      displayText = '0.';
      shouldResetDisplay = false;
    } else if (!displayText.contains('.')) {
      displayText += '.';
    }
  }

  // Set toán tử (+, -, x, /, %)
  void setOperator(String op) {
    if (operand1.isEmpty) {
      operand1 = displayText;
    } else if (operand2.isEmpty) {
      operand2 = displayText;
      calculate();
      operand1 = displayText;
    }
    operator = op;
    shouldResetDisplay = true;
  }

  // Thuc hien phep tinh
  void calculate() {
    if (operand1.isEmpty || operator.isEmpty) return;
    operand2 = displayText;

    double num1 = double.tryParse(operand1) ?? 0;
    double num2 = double.tryParse(operand2) ?? 0;
    double result = 0;

    switch (operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case 'x':
        result = num1 * num2;
        break;
      case '/':
        if (num2 != 0) {
          result = num1 / num2;
        } else {
          displayText = 'Error';
          clear();
          return;
        }
        break;
      case '%':
        result = num1 % num2;
        break;
    }
    // Format kết quả
    if (result == result.toInt()) {
      displayText = result.toInt().toString();
    } else {
      displayText = result.toStringAsFixed(2);
    }

    operand1 = displayText;
    operand2 = '';
    operator = '';
    shouldResetDisplay = true;
  }

  /// Xử lý khi nhấn button
  void handleButtonPress(String buttonText) {
    switch (buttonText) {
      case 'C':
        clear();
        break;
      case '⌫':
        backspace();
        break;
      case '=':
        calculate();
        break;
      case '+':
      case '-':
      case 'x':
      case '/':
      case '%':
        setOperator(buttonText);
        break;
      case '.':
        addDecimalPoint();
        break;
      default:
        addDigit(buttonText);
    }
  }
}
