// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:jamiah_riyazul_sabak/shared/routes.dart';
// import '../controller/homecntrl.dart';
// import '../model/studentmodel.dart';

// class NewRecordForm extends StatefulWidget {
//   final Studentmodel student;

//   const NewRecordForm({super.key, required this.student});

//   @override
//   State<NewRecordForm> createState() => _NewRecordFormState();
// }

// class _NewRecordFormState extends State<NewRecordForm> {
//   final HomeController controller = Get.find();
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController paraController = TextEditingController();
//   final TextEditingController remarksController = TextEditingController();

//   @override
//   void dispose() {
//     dateController.dispose();
//     paraController.dispose();
//     remarksController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFF2CD),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFFFF2CD),
//         elevation: 0,
//         title: Text(
//           'New Record for ${widget.student.name}',
//           style: const TextStyle(
//             color: Color(0xFF2C3E50),
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Color(0xFF2C3E50)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: dateController,
//                   decoration: InputDecoration(
//                     labelText: 'Date (YYYY-MM-DD)',
//                     labelStyle: TextStyle(color: Colors.grey[700]),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         color: Color(0xFF1E3A5F),
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                   validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: paraController,
//                   decoration: InputDecoration(
//                     labelText: 'Para',
//                     labelStyle: TextStyle(color: Colors.grey[700]),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         color: Color(0xFF1E3A5F),
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                   validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: remarksController,
//                   decoration: InputDecoration(
//                     labelText: 'Remarks',
//                     labelStyle: TextStyle(color: Colors.grey[700]),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         color: Color(0xFF1E3A5F),
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                   validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 24),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1E3A5F),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: controller.isSaving
//                         ? null
//                         : () async {
//                             if (_formKey.currentState!.validate()) {
//                               controller.setLoading(true);

//                               try {
//                                 await controller.addRecord(
//                                   student: widget.student,
//                                   date: dateController.text,
//                                   para: paraController.text,
//                                   remarks: remarksController.text,
//                                 );

//                                 if (context.mounted) {
//                                   Navigator.pop(context);

//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         'Record added successfully',
//                                       ),
//                                       backgroundColor: Color(0xFF4CAF50),
//                                     ),
//                                   );
//                                 }
//                               } finally {
//                                 controller.setLoading(false);
//                               }
//                             }
//                           },
//                     child: controller.isSaving
//                         ? const SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: Colors.white,
//                             ),
//                           )
//                         : const Text(
//                             'Save Record',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
