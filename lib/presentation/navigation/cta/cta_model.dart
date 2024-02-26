import 'package:equatable/equatable.dart';

class CTAModel extends Equatable {
  const CTAModel(this.text, this.type, this.url, this.method, {this.payload});

  const CTAModel.deepLink(this.url)
      : text = '',
        payload = '',
        method = '',
        type = CTAType.deepLink;
  final String text;
  final CTAType type;
  final String url;
  final String method;
  final String? payload;

  CTAModel copyWith({
    String? text,
    CTAType? type,
    String? url,
    String? method,
  }) {
    return CTAModel(
      text ?? this.text,
      type ?? this.type,
      url ?? this.url,
      method ?? this.method,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => <Object>[text, type, url, method];
}

enum CTAType { web, deepLink, externalApp, callback }
