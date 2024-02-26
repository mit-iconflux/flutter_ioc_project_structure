import 'dart:async';
import 'dart:isolate';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:ioc_demo/configurations/flavoring/flavor.dart';
import 'package:ioc_demo/utilities%20/utility.dart';

class ConnectivityHelper {
  final StreamController<bool> streamController = StreamController<bool>();

  /*
    checkConnectivity() is used to get the connectionStatus once when call this
    method. It will return not nullable boolean value.

    onlyCheckConnectivity is used for when you don't want to make api call for
    check the internet connection. Default value of this parameter is false.
   */

  Future<bool> checkConnectivity({bool onlyCheckConnectivity = false}) async {
    try {
      final ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        if (onlyCheckConnectivity) {
          return true;
        } else {
          final bool isConnected = await pingUrl(
            networkPingUrl,
          );
          return isConnected;
        }
      } else {
        return false;
      }
    } catch (e) {
      Utility.showLog('Error in connectivity check : $e');
      return false;
    }
  }

  /*
    checkConnectionStream() is used to get the connectionStatus real-time,
    It return a stream. You can call the listener method of the stream to
    get the live update of the internet connection.

    onlyCheckConnectivity is used for when you don't want to make api call for
    check the internet connection. Default value of this parameter is false.
   */
  Stream<bool> checkConnectionStream({
    bool onlyCheckConnectivity = false,
  }) async* {
    bool isConnected = false;
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) async {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        if (onlyCheckConnectivity) {
          streamController.add(true);
        } else {
          isConnected = await pingUrl(
            networkPingUrl,
          );
          streamController.add(isConnected);
        }
      } else {
        isConnected = false;
        streamController.add(isConnected);
      }
    });

    yield* streamController.stream;
  }

/*
  Future<bool> pingUrl() async {
    try {
      final Response<dynamic> response = await Dio()
          .get(
        ConnectivityConfigString.checkPingInternetUrl,
      )
          .timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode! < 200 || response.statusCode! > 299) {
        return false;
      }
      return true;
    } catch (e) {
      Utility.showLog('Error in InternetCheck $e');
      return false;
    }
  }*/

  Future<bool> pingUrl(String pingUrl) async {
    //Main Receive port for initially call the async method
    final ReceivePort mainReceiverPort = ReceivePort();
    await Isolate.spawn(_postMainReceiveResult, <String, dynamic>{
      'sendPort': mainReceiverPort.sendPort,
      'pingUrl': pingUrl,
    });

    // Send port for communicate to pass params
    final SendPort argumentSenderPort =
        await mainReceiverPort.first as SendPort;

    // Receiver to get main response of api call
    final ReceivePort apiResponseReceiverPort = ReceivePort();

    argumentSenderPort.send(
      <String, dynamic>{
        'port': apiResponseReceiverPort.sendPort,
      },
    );

    final bool resultModel = await apiResponseReceiverPort.first as bool;
    return resultModel;
  }

  static Future<void> _postMainReceiveResult(
    Map<String, dynamic> message,
  ) async {
    final SendPort mainSenderPort = message['sendPort'] as SendPort;
    final String pingUrl = message['pingUrl'] as String;

    // Receiver point to read argument
    final ReceivePort argumentReceiverPort = ReceivePort();

    // Main sender port
    mainSenderPort.send(argumentReceiverPort.sendPort);

    final Map<String, dynamic> args =
        await argumentReceiverPort.first as Map<String, dynamic>;

    final SendPort apiResponseSenderPort = args['port'] as SendPort;
    bool result = false;
    try {
      final Response<dynamic> response = await Dio()
          .get(
            pingUrl,
          )
          .timeout(
            const Duration(seconds: 10),
          );

      if (response.statusCode! < 200 || response.statusCode! > 299) {
        result = false;
      }
      result = true;
    } catch (e) {
      Utility.showLog('Error in InternetCheck $e');
      result = false;
    }

    apiResponseSenderPort.send(result);
  }

  /*
  disposeStream() is used to close the running stream.
   */
  void disposeStream() {
    streamController.close();
  }
}
