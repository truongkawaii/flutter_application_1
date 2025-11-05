import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/app_colors.dart';
import 'package:flutter_application_1/utils/calculator_logic.dart';
import 'package:flutter_application_1/widgets/calculator_button.dart';
import 'package:flutter_application_1/widgets/calculator_display.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  State<StatefulWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final CalculatorLogic _logic = CalculatorLogic();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Calculator Title
            _buildTitle(),
            const SizedBox(height: 16),

            // Display
            CalculatorDisplay(displayText: _logic.displayText),

            // Buttons Grid
            _buildButtonsGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Icon(Icons.calculate_rounded, color: AppColors.primaryLight, size: 28),
        const SizedBox(width: 8),
        Text(
          'Mini Calculator',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
          ),
        ),
      ],
    );
  }

  Widget _buildButtonsGrid() {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        // Row 1: C, %, /, ×
        _createButton('C', AppColors.clearButtonBg, AppColors.clearButtonText),
        _createButton(
          '%',
          AppColors.functionButtonBg,
          AppColors.functionButtonText,
        ),
        _createButton(
          '/',
          AppColors.operatorButtonBg,
          AppColors.operatorButtonText,
        ),
        _createButton(
          '×',
          AppColors.operatorButtonBg,
          AppColors.operatorButtonText,
        ),

        // Row 2: 7, 8, 9, -
        _createButton(
          '7',
          AppColors.numberButtonBg,
          AppColors.numberButtonText,
        ),
        _createButton(
          '8',
          AppColors.numberButtonBg,
          AppColors.numberButtonText,
        ),
        _createButton(
          '9',
          AppColors.numberButtonBg,
          AppColors.numberButtonText,
        ),
        _createButton(
          '-',
          AppColors.operatorButtonBg,
          AppColors.operatorButtonText,
        ),

        // Row 3: 4, 5, 6, +
        _createButton(
          '4',
          AppColors.numberButtonBg,
          AppColors.numberButtonText,
        ),
        _createButton(
          '5',
          AppColors.numberButtonBg,
          AppColors.numberButtonText,
        ),
        _createButton(
          '6',
          AppColors.numberButtonBg,
          AppColors.numberButtonText,
        ),
        _createButton(
          '+',
          AppColors.operatorButtonBg,
          AppColors.operatorButtonText,
        ),

        // Row 4: 1, 2, 3, =
        _createButton(
          '1',
          AppColors.numberButtonBg,
          AppColors.numberButtonText,
        ),
        _createButton(
          '2',
          AppColors.numberButtonBg,
          AppColors.numberButtonText,
        ),
        _createButton(
          '3',
          AppColors.numberButtonBg,
          AppColors.numberButtonText,
        ),
        _createButton(
          '=',
          AppColors.equalsButtonBg,
          AppColors.equalsButtonText,
        ),

        // Row 5: 0, ., ⌫
        _createButton(
          '0',
          AppColors.numberButtonBg,
          AppColors.numberButtonText,
        ),
        _createButton(
          '.',
          AppColors.numberButtonBg,
          AppColors.numberButtonText,
        ),
        _createButton(
          '⌫',
          AppColors.functionButtonBg,
          AppColors.functionButtonText,
        ),
        // Empty cell for layout
        const SizedBox.shrink(),
      ],
    );
  }

  Widget _createButton(String text, Color bgColor, Color textColor) {
    return CalculatorButton(
      text: text,
      backgroundColor: bgColor,
      textColor: textColor,
      onTap: () {
        setState(() {
          _logic.handleButtonPress(text);
        });
      },
    );
  }
}
