import 'package:dartantic_ai/dartantic_ai.dart';
import 'package:test/test.dart';

void main() {
  group('xAI Responses Provider', () {
    test('has expected provider identity and defaults', () {
      final provider = XAIResponsesProvider(apiKey: 'test-key');

      expect(provider.name, equals('xai-responses'));
      expect(provider.displayName, equals('xAI Responses'));
      expect(provider.apiKeyName, equals('XAI_API_KEY'));
      expect(provider.defaultModelNames[ModelKind.chat], isNotNull);
      expect(
        provider.defaultModelNames[ModelKind.media],
        equals(XAIResponsesProvider.defaultMediaModel),
      );
      expect(provider.defaultModelNames[ModelKind.embeddings], isNull);
    });

    test('creates chat model using xAI base URL by default', () {
      final provider = XAIResponsesProvider(apiKey: 'test-key');

      final model = provider.createChatModel() as XAIResponsesChatModel;

      expect(model.baseUrl, equals(XAIResponsesProvider.defaultBaseUrl));
    });

    test('throws for embeddings and supports media generation', () {
      final provider = XAIResponsesProvider(apiKey: 'test-key');

      expect(provider.createEmbeddingsModel, throwsA(isA<UnsupportedError>()));

      final mediaModel = provider.createMediaModel();
      expect(mediaModel, isA<XAIResponsesMediaGenerationModel>());
      expect(mediaModel.name, equals(XAIResponsesProvider.defaultMediaModel));
    });

    test('requires api key to create media model', () {
      final provider = XAIResponsesProvider(apiKey: '');
      expect(
        provider.createMediaModel,
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('XAI_API_KEY is required'),
          ),
        ),
      );
    });
  });
}
