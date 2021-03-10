import 'package:flutter/material.dart';

class FutureBuilderNoData extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot;

  FutureBuilderNoData(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: snapshot.connectionState != ConnectionState.done
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                snapshot.hasError
                    ? snapshot.error.toString()
                    : snapshot.hasData && snapshot.error == true
                        ? snapshot.data.message
                        : 'Error. Please try again later.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30),
              ),
            ),
    );
  }
}
