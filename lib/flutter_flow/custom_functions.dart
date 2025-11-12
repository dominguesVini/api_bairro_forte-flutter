import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

String? pegarSemanaRelatorioStart(
  int year,
  int month,
  int weekIndex,
) {
  // Validação básica para o mês e o índice da semana.
  if (month < 1 || month > 12 || weekIndex < 0) {
    return null; // Retorna nulo se os valores forem inválidos.
  }

  // Calcula o primeiro dia da semana desejada.
  // Semana 0 começa no dia 1, semana 1 no dia 8, e assim por diante.
  final int startDay = (weekIndex * 7) + 1;

  // Descobre o último dia do mês informado.
  final int daysInMonth = DateTime(year, month + 1, 0).day;

  // Se o dia de início calculado já for maior que o total de dias no mês,
  // significa que a semana não existe nesse mês.
  if (startDay > daysInMonth) {
    return null;
  }

  // Cria o objeto DateTime para a data de início.
  final DateTime startDate = DateTime(year, month, startDay);

  // Calcula o dia final da semana (sábado, 5 dias após a segunda-feira).
  final int endDay = startDay + 5;

  // Garante que a data final não ultrapasse o último dia do mês.
  // Usa o menor valor entre o dia final calculado e o último dia do mês.
  final int actualEndDay = math.min(endDay, daysInMonth);

  // Cria o objeto DateTime para a data final.
  final DateTime endDate = DateTime(year, month, actualEndDay);

  // Formata as datas para o padrão 'yyyy-MM-dd'.
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formattedStartDate = formatter.format(startDate);
  final String formattedEndDate = formatter.format(endDate);

  // Retorna a string no formato "start YYYY-MM-DD e end YYYY-MM-DD".
  return '$formattedStartDate';
}

String? pegarSemanaRelatorioEnd(
  int year,
  int month,
  int weekIndex,
) {
// Validação básica para o mês e o índice da semana.
  if (month < 1 || month > 12 || weekIndex < 0) {
    return null; // Retorna nulo se os valores forem inválidos.
  }

  // Calcula o primeiro dia da semana desejada.
  // Semana 0 começa no dia 1, semana 1 no dia 8, e assim por diante.
  final int startDay = (weekIndex * 7) + 1;

  // Descobre o último dia do mês informado.
  final int daysInMonth = DateTime(year, month + 1, 0).day;

  // Se o dia de início calculado já for maior que o total de dias no mês,
  // significa que a semana não existe nesse mês.
  if (startDay > daysInMonth) {
    return null;
  }

  // Calcula o dia final da semana (sábado, 5 dias após a segunda-feira).
  final int endDay = startDay + 5;

  // Garante que a data final não ultrapasse o último dia do mês.
  // Usa o menor valor entre o dia final calculado e o último dia do mês.
  final int actualEndDay = math.min(endDay, daysInMonth);

  // Cria o objeto DateTime para a data final.
  final DateTime endDate = DateTime(year, month, actualEndDay);

  // Formata as datas para o padrão 'yyyy-MM-dd'.
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formattedEndDate = formatter.format(endDate);

  // Retorna a string no formato "start YYYY-MM-DD e end YYYY-MM-DD".
  return '$formattedEndDate';
}

String removerCaracteresTelefone(String telefone) {
  return telefone
      .replaceAll('(', '')
      .replaceAll(')', '')
      .replaceAll('-', '')
      .trim();
}
