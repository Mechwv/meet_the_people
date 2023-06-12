

import 'package:flutter/material.dart';

@immutable
abstract class PeopleState {}

class PeopleInitial extends PeopleState {}

class PeopleLoadingState extends PeopleState {}

class PeopleLoadSuccess extends PeopleState {}