import 'dart:async';
import 'dart:convert';
import 'package:discord_test/failure.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class PaymentRepository {
  final String url;

  PaymentRepository({required this.url});

  Stream<Either<Failure, Map<String, dynamic>>> listenToPayments() async* {
    try {
      final request = http.Request('GET', Uri.parse(url));
      final response = await request.send();

      if (response.statusCode == 200) {
        // Start listening to the stream of events
        int index = 0;
        await for (var data in response.stream
            .transform(Utf8Decoder())
            .transform(LineSplitter())) {
          index++;
          if (data.isNotEmpty && data.startsWith("data:")) {
            // Parse the event data and yield it as a Map
            final eventData = jsonDecode(data.substring(5).trim()) as
            Map<String,
                dynamic>;
            if(index == 5) {
              eventData.addAll({'status': 'success'});
            }
            yield Right(eventData);
          }
        }
      } else {
        // In case of non-200 status code, yield a failure
        yield Left(ServerFailure(
          message: 'Failed to connect to SSE server',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      // Yield a failure in case of an exception
      yield Left(ServerFailure(message: 'Error connecting to SSE server: $e', statusCode: 500));
    }
  }

}
