part of 'invoice_read_controller_cubit.dart';

@immutable
abstract class InvoiceReadControllerState {}

class InvoiceReadControllerInitial extends InvoiceReadControllerState {}
class InvoiceReadLoading extends InvoiceReadControllerState {}
class InvoiceReadLoaded extends InvoiceReadControllerState {
  List<InvoiceModel> data;
  InvoiceReadLoaded({required this.data});
}
class InvoiceReadException extends InvoiceReadControllerState {
  var err;
  InvoiceReadException({required this.err});
}


