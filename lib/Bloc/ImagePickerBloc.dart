import 'package:bloc/bloc.dart';
import 'package:employeeapp/DataProvider/PickImage.dart';

abstract class ImagePickerEvent{}

class GetImageCameraEvent extends ImagePickerEvent{}

class ImagePickerBloc extends Bloc<ImagePickerEvent, ModelImagePicker>{
  ImagePickerBloc() : super(null);

  @override
  Stream<ModelImagePicker> mapEventToState(ImagePickerEvent event) async*{
    // TODO: implement mapEventToState
    if(event is GetImageCameraEvent) yield await PickImage().getCameraImage();
  }
}