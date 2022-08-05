part of 'invoice_controller_cubit.dart';

@immutable
abstract class InvoiceControllerState {}

class InvoiceControllerInitial extends InvoiceControllerState {}
class InvoiceLoading extends InvoiceControllerState {}
class InvoiceGeneratedSuccessful extends InvoiceControllerState {}
class InvoiceException extends InvoiceControllerState {
  var err;
  InvoiceException({required this.err});
}
