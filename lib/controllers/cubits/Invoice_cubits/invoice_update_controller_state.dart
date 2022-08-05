part of 'invoice_update_controller_cubit.dart';

@immutable
abstract class InvoiceUpdateControllerState {}

class InvoiceUpdateControllerInitial extends InvoiceUpdateControllerState {}
class InvoiceUpdateLoading extends InvoiceUpdateControllerState {}
class InvoiceUpdateLoaded extends InvoiceUpdateControllerState {}
class InvoiceUpdateException extends InvoiceUpdateControllerState {
  var err;
  InvoiceUpdateException({required this.err});
}
