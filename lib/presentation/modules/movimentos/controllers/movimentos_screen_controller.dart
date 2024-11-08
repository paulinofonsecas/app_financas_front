import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/domain/usecases/i_movimento_usecase.dart';

import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class MovimentoScreenController extends GetxController {
  late final PagingController<int, Movimento> pagingController;
  late final IMovimentoUseCases service;
  var page = 1;
  var pageSize = 10;
  late DateTime date;

  @override
  void onInit() {
    service = getIt();
    pagingController = PagingController(firstPageKey: 1);
    date = DateTime.now();

    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.onInit();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final newItems = await getPaginatedMovimentos(pageKey);
      final isLastPage = newItems.length < pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<List<Movimento>> getPaginatedMovimentos(
    int page,
  ) async {
    var result = await service.listPaginatedMovimentos(page, pageSize);
    if (result is Right) {
      return result.getOrElse(() => []);
    } else {
      throw result.swap().getOrElse(
            () => Failure(
              'Erro desconhecido no ' 'movimento screen controller',
            ),
          );
    }
  }

  Future<Either<Failure, List<Movimento>>> listMovimentos() {
    if (date.day == DateTime.now().day) {
      return service.listMovimentos();
    } else {
      return service.listMovimentosAt(date);
    }
  }

  void selecionarDateTime(BuildContext context) async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      is24HourMode: true,
      type: OmniDateTimePickerType.date,
    );

    if (dateTime != null) {
      if (dateTime.isAfter(DateTime.now())) {
        Get.snackbar(
          'Data inválida',
          'A data não pode ser menor que a data atual',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      date = dateTime;
      update();
    }
  }
}
