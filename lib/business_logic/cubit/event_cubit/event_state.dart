

import 'package:flutter/material.dart';

@immutable
abstract class EventState {}

class EventInitial extends EventState {}

class EventLoadingState extends EventState {}

class EventLoadSuccess extends EventState {}