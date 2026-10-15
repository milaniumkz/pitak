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
import '/auth/firebase_auth/auth_util.dart';

bool? isEmptyImage(String photoUser) {
  return photoUser.isEmpty;
}

bool? isVideo(String? str) {
  final List<String?> video = str!.split('?');
  final List<String?> vide = video[0]!.split('/');
  final List<String?> vid = vide.last!.split('.');
  if (vid.last == 'mp4' || vid.last == 'mov' || vid.last == 'AVI') {
    return true;
  } else {
    return false;
  }
}

bool? ifStatus(int? status) {
  if (status == 2) {
    return true;
  } else {
    return false;
  }
}
