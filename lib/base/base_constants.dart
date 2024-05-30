

import 'dart:typed_data';

const defaultDuration = Duration(milliseconds: 300);
const dAnimDuration = Duration(milliseconds: 200);

// HEADERS
const contentType = 'Content-Type';
const contentTypeJson = 'application/json; charset=utf-8';
const authorization = 'Authorization';
const bearer = 'Bearer';

// Http status code
const httpStatusCodeSuccess200 = 200;
const httpStatusCodeSuccess201 = 201;
const httpStatusCodeSuccess202 = 202;
const httpStatusCodeError403 = 403;
const httpStatusCodeError401 = 401;
const httpStatusCodeError405 = 405;

// const paddingApp = 16.0;
const sampleText = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever';

const dDebounceDuration = Duration(milliseconds: 300);

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);

const pageSizeDefault = 15;