import 'package:image_picker/image_picker.dart';

class ImagePickerFunction {
  static Future<XFile?> imagepicker() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    return file;
  }
}
