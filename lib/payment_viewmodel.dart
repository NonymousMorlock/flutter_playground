import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:discord_test/payment_repository.dart';
import 'package:discord_test/viewmodel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'failure.dart';
import 'networking.dart';

part 'payment_state.dart';

class PaymentViewmodel extends Viewmodel<PaymentState> {
  PaymentViewmodel(this._repository) : super(const PaymentInitial());

  final PaymentRepository _repository;
  StreamSubscription<Either<Failure, Map<String, dynamic>>>? _subscription;

  // Start listening to the payment stream
  void listenToPayments() {
    emit(const PaymentLoading());

    _subscription = _repository.listenToPayments().listen(
      (event) {
        event.fold(
          (failure) {
            emit(PaymentError(failure.message));
            _cancelSubscription(); // Cancel after error
          },
          (paymentData) {
            debugPrint('Payment Event: $paymentData');
            if(paymentData['status'] == 'success') {
              emit(PaymentReceived(paymentData));
              _cancelSubscription(); // Cancel after successful payment
            }
          },
        );
      },
      onError: (error) {
        emit(PaymentError('An error occurred: $error'));
        _cancelSubscription(); // Cancel after onError
      },
      onDone: () {
        emit(const PaymentStopped());
      },
    );
  }

  // Cancel the stream subscription
  void _cancelSubscription() {
    _subscription?.cancel();
    _subscription = null; // Clean up
  }

  void stopListening() {
    _cancelSubscription();
    emit(const PaymentStopped());
  }

  @override
  void dispose() {
    _cancelSubscription();
    super.dispose();
  }
}
