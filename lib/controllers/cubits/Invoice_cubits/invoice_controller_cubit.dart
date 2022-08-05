import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'invoice_controller_state.dart';

class InvoiceControllerCubit extends Cubit<InvoiceControllerState> {
  InvoiceControllerCubit() : super(InvoiceControllerInitial());
  addInvoiceData(var name, var item, var price) async{
    emit(InvoiceLoading());
    try{
      String id=FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection("invoices").doc(id).collection("myInvoices").add({
        "Name": name,
        "Price": price,
        "Item": item
      });
      emit(InvoiceGeneratedSuccessful());
    }catch(e){
      InvoiceException(err: e.toString());
      print(e);
    }


  }

}
