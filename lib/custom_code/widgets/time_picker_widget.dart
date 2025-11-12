// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';

import 'index.dart';

import 'package:flutter/cupertino.dart';

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({
    super.key,
    this.width,
    this.height,
    required this.onTimeSelected,
    this.initialTime,
    this.title = 'Selecionar Horário',
    this.primaryColor = const Color(0xFF6C63FF),
    this.backgroundColor = const Color(0xFF1A1A1A),
    this.textColor = Colors.white,
    this.is24HourFormat = true,
  });

  final double? width;
  final double? height;
  final Function(TimeOfDay) onTimeSelected;
  final TimeOfDay? initialTime;
  final String title;
  final Color primaryColor;
  final Color backgroundColor;
  final Color textColor;
  final bool is24HourFormat;

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  late TimeOfDay selectedTime;
  bool isPickerVisible = false;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime ?? TimeOfDay.now();
  }

  String _formatTime(TimeOfDay time) {
    if (widget.is24HourFormat) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      final hour =
          time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
      final period = time.hour >= 12 ? 'PM' : 'AM';
      return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
    }
  }

  void _showTimePicker() async {
    setState(() {
      isPickerVisible = true;
    });

    // Usando o seletor de hora nativo do Material que evita problemas de overflow
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: widget.primaryColor,
              secondary: widget.primaryColor,
              surface: widget.backgroundColor,
            ),
            dialogBackgroundColor: widget.backgroundColor,
            timePickerTheme: TimePickerThemeData(
              backgroundColor: widget.backgroundColor,
              hourMinuteTextColor: widget.textColor,
              hourMinuteColor: widget.primaryColor.withOpacity(0.2),
              dayPeriodTextColor: widget.textColor,
              dayPeriodColor: widget.primaryColor.withOpacity(0.3),
              dialHandColor: widget.primaryColor,
              dialBackgroundColor: widget.backgroundColor,
              dialTextColor: widget.textColor,
              entryModeIconColor: widget.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    // Só atualiza o estado se o usuário selecionar um horário
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        widget.onTimeSelected(selectedTime);
      });
    }

    setState(() {
      isPickerVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showTimePicker,
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? 60,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isPickerVisible ? widget.primaryColor : Colors.grey.shade300,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: widget.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.access_time_rounded,
                color: widget.primaryColor,
                size: 16,
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Seleciona",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    _formatTime(selectedTime),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
