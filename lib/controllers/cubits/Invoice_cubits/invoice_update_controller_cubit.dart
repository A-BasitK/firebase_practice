import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../models/invoice_model.dart';

part 'invoice_update_controller_state.dart';

class InvoiceUpdateControllerCubit extends Cubit<InvoiceUpdateControllerState> {
  InvoiceUpdateControllerCubit() : super(InvoiceUpdateControllerInitial());

  updateData(InvoiceModel invoiceModel) async {
    emit(InvoiceUpdateLoading());
    try {
      String id = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection("invoices")
          .doc(id)
          .collection("myInvoices")
          .doc(invoiceModel.id)
          .update(
            invoiceModel.invoiceData.toMap(),
          );
      emit(InvoiceUpdateLoaded());
    } catch (e) {
      emit(InvoiceUpdateException(err: e.toString()));
    }
  }
}
