import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});

  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

abstract class HttpClient {
  Future<void> request({@required String url, @required String method});
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  
  RemoteAuthentication sut;
  HttpClientSpy httpClient;
  String url;

  setUp(() {
     httpClient = HttpClientSpy();
     url = faker.internet.httpUrl();
     sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Teste classe remote_authentication com parametros corretos', () async {
    await sut.auth();
    verify(httpClient.request(url: url, method: 'post'));
  });
}
