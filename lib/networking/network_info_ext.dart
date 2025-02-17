import 'dart:convert';

import 'package:vowchainsdk/export.dart';
import 'package:http/http.dart' as http;

extension NetworkInfoExt on NetworkInfo {
  Future<NodeInfoResponse> fetchNetworkInfo({http.Client? client}) async {
    client ??= http.Client();

    final nodeInfoUri = Uri.parse('${lcdUrl.toString()}/node_info');

    final response = await client.get(nodeInfoUri);

    if (response.statusCode != 200 || response.body.isEmpty) {
      throw Exception(
          'Could not find node info (status ${response.statusCode})');
    }

    return NodeInfoResponse.fromJson(jsonDecode(response.body));
  }

  Future<bool> isVersion({
    required String version,
    http.Client? client,
  }) async {
    client ??= http.Client();

    if (version.isEmpty) {
      throw ArgumentError(
          'The version must not be empty. A valid example is "2.2"');
    }

    final nodeInfoResponse = await fetchNetworkInfo(client: client);

    return nodeInfoResponse.applicationVersion.version.startsWith(version);
  }
}
