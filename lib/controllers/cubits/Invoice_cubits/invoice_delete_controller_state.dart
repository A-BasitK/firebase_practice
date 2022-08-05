part of 'invoice_delete_controller_cubit.dart';

abstract class InvoiceDeleteControllerState {}

class InvoiceDeleteControllerInitial extends InvoiceDeleteControllerState {}
class InvoiceDeleting extends InvoiceDeleteControllerState {}
class InvoiceDeleted extends InvoiceDeleteControllerState {}
class InvoiceDeletingException extends InvoiceDeleteControllerState {
  String err;
  InvoiceDeletingException({required this.err});
}

