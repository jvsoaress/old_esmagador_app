import 'dart:io';

import 'package:flutter/material.dart';

import './android/app.dart';
import './ios/app.dart';

void main() => Platform.isIOS ? runApp(IOSApp()) : runApp(AndroidApp());
