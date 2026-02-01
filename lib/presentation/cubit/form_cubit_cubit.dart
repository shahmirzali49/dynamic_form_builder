import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'form_cubit_state.dart';

class FormCubitCubit extends Cubit<FormCubitState> {
  FormCubitCubit() : super(FormCubitInitial());
}
