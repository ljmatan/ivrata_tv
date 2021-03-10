import 'package:flutter/material.dart';
import 'package:ivrata_tv/global/eula_agreement.dart';
import 'package:ivrata_tv/logic/cache/prefs.dart';
import 'package:ivrata_tv/ui/shared/focusable_button.dart';

class AgreementDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Material(
              elevation: 2,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Text(
                            EulaAgreement.text,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: FocusableButton(
                          autofocus: true,
                          width: 200,
                          height: 44,
                          label: 'I AGREE',
                          onTap: () async {
                            await Prefs.instance.setBool('eulaAccepted', true);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
