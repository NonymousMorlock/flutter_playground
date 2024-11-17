import 'package:discord_test/payment_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentViewmodel>().listenToPayments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listen to Payments'),
      ),
      body: Center(
        child: Consumer<PaymentViewmodel>(
          builder: (context, viewmodel, child) {
            final state = viewmodel.state;

            if (state is PaymentLoading) {
              return const CircularProgressIndicator();
            } else if (state is PaymentReceived) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check, color: Colors.green, size: 24),
                  const SizedBox(width: 8),
                  Text('Payment received'),
                ],
              );
            } else if (state is PaymentError) {
              return Text('Error: ${state.message}');
            } else if (state is PaymentStopped) {
              return const Text('Stopped listening to payments.');
            } else {
              return const Text('No payment events yet.');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger listening to payments
          context.read<PaymentViewmodel>().listenToPayments();
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
