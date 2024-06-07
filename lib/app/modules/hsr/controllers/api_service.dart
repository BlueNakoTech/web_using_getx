import 'dart:convert';
import 'package:http/http.dart' as http;

class CorsHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Add CORS headers
    request.headers['Access-Control-Allow-Origin'] = '*';
    request.headers['Access-Control-Allow-Methods'] =
        'GET, POST, PUT, DELETE, OPTIONS';
    request.headers['Access-Control-Allow-Headers'] =
        'Origin, Content-Type, X-Auth-Token, ClientId, ClientSecret, Authorization';

    // Perform the request with the modified headers
    return _inner.send(request);
  }
}

class ApiService {
  static const String baseUrl =
      'https://careful-mouse-gradually.ngrok-free.app';
  String? _authToken;
  final http.Client httpClient = CorsHttpClient();

  Future<void> allowCors() async {
    final url = Uri.parse('$baseUrl/cors-options');
    final response = await httpClient.send(http.Request('OPTIONS', url));
    // Handle the response if necessary
  }

  Future<void> authenticate(String clientId, String clientPin) async {
    final url = Uri.parse('$baseUrl/api-client');

    final response = await httpClient.post(
      url,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers':
            'Origin, Content-Type, X-Auth-Token, ClientId, ClientSecret, Authorization',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'clientId': clientId,
        'clientPin': clientPin,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _authToken = data['accessToken'];
    } else {
      throw Exception('Failed to authenticate');
    }
  }

  Future<Map<String, dynamic>> checkStatus() async {
    if (_authToken == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('$baseUrl/status');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_authToken',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to check status');
    }
  }

  Future<Map<String, dynamic>> runCaptureCommand() async {
    if (_authToken == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('$baseUrl/run/capture');
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer $_authToken',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to run capture command');
    }
  }

  Future<Map<String, dynamic>> runSerialCommand(String pin) async {
    if (_authToken == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('$baseUrl/run/serial/$pin');
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer $_authToken',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to run serial command');
    }
  }

  Future<Map<String, dynamic>> getData(String key) async {
    if (_authToken == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('$baseUrl/get/$key');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_authToken',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get data');
    }
  }
}
