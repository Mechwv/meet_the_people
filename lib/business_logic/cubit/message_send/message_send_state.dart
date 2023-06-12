
import 'package:flutter/material.dart';

@immutable
abstract class MessageSendState {}

class MessageSendInitial extends MessageSendState {}
class MessageSendSuccess extends MessageSendState {}
