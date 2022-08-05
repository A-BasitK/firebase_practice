import 'package:firebase_practice/controllers/cubits/Invoice_cubits/invoice_controller_cubit.dart';
import 'package:firebase_practice/controllers/cubits/Invoice_cubits/invoice_delete_controller_cubit.dart';
import 'package:firebase_practice/controllers/cubits/Invoice_cubits/invoice_read_controller_cubit.dart';
import 'package:firebase_practice/controllers/cubits/Invoice_cubits/invoice_update_controller_cubit.dart';
import 'package:firebase_practice/models/invoice_model.dart';
import 'package:firebase_practice/views/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final inputNameController = TextEditingController();
  final inputPriceController = TextEditingController();
  final inputItemController = TextEditingController();
  final updateNameController = TextEditingController();
  final updatePriceController = TextEditingController();
  final updateItemController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Homepage"),
        actions: [
          InkWell(
              child: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.notifications_none,
                  size: 30,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: BlocConsumer<InvoiceReadControllerCubit,
            InvoiceReadControllerState>(
          listener: (context, state) {
            if (state is InvoiceReadLoading) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Loading")));
            }
            if (state is InvoiceReadLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Invoice Read Sucessfully")));
            }
            if (state is InvoiceReadException) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.err)));
            }
          },
          builder: (context, state) {
            if (state is InvoiceReadLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is InvoiceReadLoaded) {
              return ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.teal.shade100,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                blurStyle: BlurStyle.normal)
                          ]),
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: Center(
                          child: Column(
                            children: [
                              Expanded(
                                  child: Row(
                                children: [
                                  const Expanded(
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Name: ",
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                  Expanded(
                                      child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      state.data[index].invoiceData.name,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                                ],
                              )),
                              Expanded(
                                  child: Row(
                                children: [
                                  const Expanded(
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Price: ",
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                  Expanded(
                                      child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "\$${state.data[index].invoiceData.price}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                                ],
                              )),
                              Expanded(
                                  child: Row(
                                children: [
                                  const Expanded(
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Item: ",
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                  Expanded(
                                      child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      state.data[index].invoiceData.item,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                                ],
                              )),
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 90),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: InkWell(
                                            child: const Icon(
                                              Icons.published_with_changes,
                                              color: Colors.green,
                                            ),
                                            onTap: () {
                                              updateNameController.text = state
                                                  .data[index].invoiceData.name;
                                              updatePriceController.text = state
                                                  .data[index]
                                                  .invoiceData
                                                  .price;
                                              updateItemController.text = state
                                                  .data[index].invoiceData.item;
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                          backgroundColor:
                                                              Colors.teal
                                                                  .shade100,
                                                          content: SizedBox(
                                                              height: 250,
                                                              width: 100,
                                                              child: Column(
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            TextField(
                                                                      controller:
                                                                          updateNameController,
                                                                      decoration:
                                                                          (InputDecoration()),
                                                                    )),
                                                                    Expanded(
                                                                        child:
                                                                            TextField(
                                                                      controller:
                                                                          updatePriceController,
                                                                      decoration:
                                                                          (InputDecoration()),
                                                                    )),
                                                                    Expanded(
                                                                        child:
                                                                            TextField(
                                                                      controller:
                                                                          updateItemController,
                                                                      decoration:
                                                                          (InputDecoration()),
                                                                    )),
                                                                    Expanded(
                                                                        child: BlocListener<
                                                                            InvoiceUpdateControllerCubit,
                                                                            InvoiceUpdateControllerState>(
                                                                      listener:
                                                                          (context,
                                                                              state) {
                                                                        if (state
                                                                            is InvoiceUpdateLoading) {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(const SnackBar(content: Text("Loading")));
                                                                        }
                                                                        if (state
                                                                            is InvoiceUpdateLoaded) {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(const SnackBar(content: Text("Updated")));
                                                                        }
                                                                        if (state
                                                                            is InvoiceUpdateException) {
                                                                          {
                                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.err)));
                                                                          }
                                                                        }
                                                                      },
                                                                      child: ElevatedButton(
                                                                          onPressed: () {
                                                                            var data = InvoiceData(
                                                                                item: updateItemController.text,
                                                                                price: updatePriceController.text,
                                                                                name: updateNameController.text);
                                                                            context.read<InvoiceUpdateControllerCubit>().updateData(InvoiceModel(
                                                                                invoiceData: data,
                                                                                id: state.data[index].id));
                                                                          },
                                                                          child: Text("Update Data")),
                                                                    ))
                                                                  ]))));
                                            },
                                          )),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: BlocListener<
                                                InvoiceDeleteControllerCubit,
                                                InvoiceDeleteControllerState>(
                                              listener: (context, state) {
                                                if (state is InvoiceDeleting) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Deleting Invoice")));
                                                }
                                                if (state is InvoiceDeleted) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Deleted Invoice")));
                                                }
                                                if (state
                                                    is InvoiceDeletingException) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content:
                                                              Text(state.err)));
                                                }
                                              },
                                              child: InkWell(
                                                child: const Icon(
                                                  Icons.delete_sweep_outlined,
                                                  color: Colors.red,
                                                ),
                                                onTap: () {
                                                  context
                                                      .read<
                                                          InvoiceDeleteControllerCubit>()
                                                      .deleteData(
                                                          state.data[index]);
                                                },
                                              ),
                                            )))
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            if (state is InvoiceReadException) {
              print(state.err);
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Colors.teal.shade100,
                    content: SizedBox(
                      height: 250,
                      width: 100,
                      child: Column(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: inputNameController,
                            decoration: (const InputDecoration(
                              hintText: "Enter Name",
                            )),
                          )),
                          Expanded(
                              child: TextField(
                            controller: inputPriceController,
                            decoration: (const InputDecoration(
                              hintText: "Enter Price",
                            )),
                          )),
                          Expanded(
                              child: TextField(
                            controller: inputItemController,
                            decoration: (const InputDecoration(
                              hintText: "Enter Item",
                            )),
                          )),
                          Expanded(
                              child: Align(
                                  child: SizedBox(
                                      height: 40,
                                      width: 100,
                                      child: BlocListener<
                                          InvoiceControllerCubit,
                                          InvoiceControllerState>(
                                        listener: (context, state) {
                                          if (state is InvoiceLoading) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text("Loading")));
                                          }
                                          if (state
                                              is InvoiceGeneratedSuccessful) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Invoice Generated Sucessfully")));
                                          }
                                          if (state is InvoiceException) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(state.err)));
                                          }
                                        },
                                        child: ElevatedButton(
                                            onPressed: () {
                                              context
                                                  .read<
                                                      InvoiceControllerCubit>()
                                                  .addInvoiceData(
                                                    inputNameController.text,
                                                    inputItemController.text,
                                                    inputPriceController.text,
                                                  );
                                            },
                                            child: Text("Add")),
                                      ))))
                        ],
                      ),
                    ),
                  ));
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add_card),
      ),
    );
  }
}
