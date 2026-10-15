import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'set_profile_widget.dart' show SetProfileWidget;
import 'package:flutter/material.dart';

class SetProfileModel extends FlutterFlowModel<SetProfileWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadDataJd7 = false;
  FFUploadedFile uploadedLocalFile_uploadDataJd7 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataJd7 = '';

  bool isDataUploading_uploadData5ef = false;
  FFUploadedFile uploadedLocalFile_uploadData5ef =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadData5ef = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
