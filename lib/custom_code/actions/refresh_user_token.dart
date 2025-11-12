// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom actions

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

/// This function refreshes the Firebase auth token for the current user.
///
/// It can be called periodically to ensure the token stays valid.
Future<String?> refreshUserToken() async {
  try {
    // Get current user
    final User? user = FirebaseAuth.instance.currentUser;

    // If no user is logged in, return null
    if (user == null) {
      developer.log('No user is currently logged in');
      return null;
    }

    // Force refresh the token
    String? token = await user.getIdToken(true);
    developer.log('Firebase token refreshed successfully');

    return token;
  } catch (e) {
    developer.log('Error refreshing Firebase token: $e');
    rethrow; // Re-throw the exception so the caller can handle it
  }
}
