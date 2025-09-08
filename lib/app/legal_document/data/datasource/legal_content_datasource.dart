import 'package:flutter_boilerplate/app/legal_document/data/model/api/legal_document.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:playx/playx.dart';

abstract class LegalContentDatasource {
  Future<NetworkResult<ApiLegalDocument>> getPrivacyPolicy();
  Future<NetworkResult<ApiLegalDocument>> getTermsConditions();
}

class RemoteLegalContentDatasource implements LegalContentDatasource {
  final PlayxNetworkClient client;

  RemoteLegalContentDatasource({required this.client});

  @override
  Future<NetworkResult<ApiLegalDocument>> getPrivacyPolicy() async {
    final result = await client.get<ApiLegalDocument>(
      Endpoints.privacyPolicy,
      fromJson: ApiLegalDocument.fromJson,
    );

    return result;
  }

  @override
  Future<NetworkResult<ApiLegalDocument>> getTermsConditions() async {
    final result = await client.get<ApiLegalDocument>(
      Endpoints.termsConditions,
      fromJson: ApiLegalDocument.fromJson,
    );

    return result;
  }
}
