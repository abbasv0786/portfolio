import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/services/image_service.dart';
import 'package:portfolio/widgets/app_image.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('classifies image sources', () {
    expect(ImageService.isDataUrl('data:image/png;base64,AAAA'), isTrue);
    expect(ImageService.isRemote('https://example.com/a.png'), isTrue);
    expect(ImageService.isAsset('assets/images/image_woof.webp'), isTrue);
    expect(ImageService.isAsset(''), isFalse);
    expect(ImageService.isAsset('data:image/png;base64,AAAA'), isFalse);
  });

  test('bundled asset round-trips through a data URL', () async {
    const path = 'assets/images/image_woof.webp';
    final dataUrl = await ImageService.assetToDataUrl(path);
    expect(dataUrl, startsWith('data:image/webp;base64,'));

    final original = (await rootBundle.load(path)).buffer.asUint8List();
    expect(ImageService.decode(dataUrl), original);
  });

  test('every bundled project image and the profile photo fit the cap',
      () async {
    for (final path in [
      'assets/images/image_dr_batra.webp',
      'assets/images/image_gpt.webp',
      'assets/images/image_kbook.webp',
      'assets/images/image_lk.webp',
      'assets/images/image_ssp.webp',
      'assets/images/image_tragofone.webp',
      'assets/images/image_woof.webp',
      'assets/images/movie_suggester.jpeg',
      'assets/images/rag_chatbot.png',
      'assets/images/profile.png',
    ]) {
      await ImageService.assetToDataUrl(path);
    }
  });

  test('rejects images over the size cap', () {
    expect(
      () => ImageService.toDataUrl(
          Uint8List(ImageService.maxBytes + 1), 'big.png'),
      throwsException,
    );
  });

  testWidgets('AppImage renders a data URL from memory', (tester) async {
    final dataUrl =
        await ImageService.assetToDataUrl('assets/images/image_woof.webp');
    await tester.pumpWidget(MaterialApp(home: AppImage(dataUrl)));
    final image = tester.widget<Image>(find.byType(Image));
    expect(image.image, isA<MemoryImage>());
  });
}
