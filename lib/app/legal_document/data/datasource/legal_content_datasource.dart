import 'package:flutter_boilerplate/app/legal_document/data/model/legal_document.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:playx/playx.dart';

abstract class LegalContentDatasource {
  Future<NetworkResult<LegalDocument>> getPrivacyPolicy();
  Future<NetworkResult<LegalDocument>> getTermsConditions();
}

class RemoteLegalContentDatasource implements LegalContentDatasource {
  final PlayxNetworkClient client;

  RemoteLegalContentDatasource({required this.client});

  @override
  Future<NetworkResult<LegalDocument>> getPrivacyPolicy() async {
    final result = await client.get<LegalDocument>(
      Endpoints.privacyPolicy,
      fromJson: LegalDocument.fromJson,
    );

    return result;
  }

  @override
  Future<NetworkResult<LegalDocument>> getTermsConditions() async {
    final result = await client.get<LegalDocument>(
      Endpoints.termsConditions,
      fromJson: LegalDocument.fromJson,
    );

    return result;
  }
}
