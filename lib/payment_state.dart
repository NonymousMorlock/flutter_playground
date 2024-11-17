part of 'payment_viewmodel.dart';


sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

final class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

final class PaymentReceived extends PaymentState {
  const PaymentReceived(this.paymentData);

  final Map<String, dynamic> paymentData;

  @override
  List<Object> get props => [paymentData];
}

final class PaymentError extends PaymentState {
  const PaymentError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class PaymentStopped extends PaymentState {
  const PaymentStopped();
}
