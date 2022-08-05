import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/models/invoice_model.dart';
import 'package:meta/meta.dart';

part 'invoice_delete_controller_state.dart';

class InvoiceDeleteControllerCubit extends Cubit<InvoiceDeleteControllerState> {
  InvoiceDeleteControllerCubit() : super(InvoiceDeleteControllerInitial());
  deleteData(InvoiceModel invoiceModel) async{
    emit(InvoiceDeleting());
    try{
      String id = FirebaseAuth.instance.currentUser!.uid;
     await FirebaseFirestore.instance.collection("invoices")
          .doc(id)
          .collection("myInvoices")
          .doc(invoiceModel.id).delete();
     emit(InvoiceDeleted());
    }catch(e){
      emit(InvoiceDeletingException(err: e.toString()));
    }
  }
}
