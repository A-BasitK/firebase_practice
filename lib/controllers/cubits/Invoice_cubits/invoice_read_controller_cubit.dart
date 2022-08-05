import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/models/invoice_model.dart';
import 'package:meta/meta.dart';

part 'invoice_read_controller_state.dart';

class InvoiceReadControllerCubit extends Cubit<InvoiceReadControllerState> {
  InvoiceReadControllerCubit() : super(InvoiceReadControllerInitial()){
    readInvoiceData();
  }
  readInvoiceData() {
    try{
      emit(InvoiceReadLoading());
      print("loading");
      List<InvoiceModel> invoices=[];
      String id=FirebaseAuth.instance.currentUser!.uid;
      print(id);
      var ref=FirebaseFirestore.instance.collection("invoices").doc(id).collection("myInvoices").snapshots();
      print("fetching");
      ref.listen((event) {
        invoices.clear();
        for(var d in event.docs){
          String id= d.id;
          InvoiceData data=InvoiceData.fromMap(d.data());
          var model= InvoiceModel(invoiceData: data, id: id);
          invoices.add(model);
        }
        print(invoices.length);
        emit(InvoiceReadLoaded(data: invoices));
      });
    }catch(e){
      emit(InvoiceReadException(err: e));

    }



  }
}
