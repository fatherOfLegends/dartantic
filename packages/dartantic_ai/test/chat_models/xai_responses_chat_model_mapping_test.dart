import 'package:dartantic_ai/dartantic_ai.dart';
import 'package:openai_dart/openai_dart.dart' as openai;
import 'package:test/test.dart';

void main() {
  group('XAIResponsesChatModel option mapping', () {
    test('maps xAI options to internal Responses options', () {
      final mapped = XAIResponsesChatModel.toOpenAIOptionsForTesting(
        const XAIResponsesChatModelOptions(
          temperature: 0.4,
          topP: 0.9,
          maxOutputTokens: 256,
          store: true,
          metadata: {'k': 'v'},
          include: ['reasoning.encrypted_content'],
          parallelToolCalls: true,
          reasoningEffort: XAIReasoningEffort.high,
          reasoningSummary: XAIReasoningSummary.concise,
          imageDetail: XAIImageDetail.high,
          serverSideTools: {
            XAIServerSideTool.webSearch,
            XAIServerSideTool.codeInterpreter,
          },
          webSearchConfig: XAIWebSearchConfig(
            contextSize: XAIWebSearchContextSize.high,
            searchContentTypes: ['text', 'image'],
          ),
          codeInterpreterConfig: XAICodeInterpreterConfig(
            containerId: 'cont_123',
          ),
        ),
      );

      expect(mapped.temperature, 0.4);
      expect(mapped.topP, 0.9);
      expect(mapped.maxOutputTokens, 256);
      expect(mapped.store, isTrue);
      expect(mapped.metadata, {'k': 'v'});
      expect(mapped.include, ['reasoning.encrypted_content']);
      expect(mapped.parallelToolCalls, isTrue);
      expect(mapped.reasoningEffort, OpenAIReasoningEffort.high);
      expect(mapped.reasoningSummary, OpenAIReasoningSummary.concise);
      expect(mapped.imageDetail, openai.ImageDetail.high);
      expect(mapped.serverSideTools, isNotNull);
      expect(mapped.serverSideTools, contains(OpenAIServerSideTool.webSearch));
      expect(
        mapped.serverSideTools,
        contains(OpenAIServerSideTool.codeInterpreter),
      );
      expect(mapped.webSearchConfig, isNotNull);
      expect(mapped.codeInterpreterConfig, isNotNull);
    });

    test('maps MCP tool config into raw responses payload entries', () {
      final tools = XAIResponsesChatModel.buildMcpToolsForTesting([
        const XAIMcpToolConfig(
          serverUrl: 'https://mcp.example.com/mcp',
          serverLabel: 'example',
          serverDescription: 'Test MCP server',
          allowedToolNames: ['search_docs', 'lookup_api'],
          authorization: 'Bearer token',
          extraHeaders: {'X-Test': '1'},
        ),
      ]);

      expect(tools, hasLength(1));
      final tool = tools.first;
      expect(tool['type'], 'mcp');
      expect(tool['server_url'], 'https://mcp.example.com/mcp');
      expect(tool['server_label'], 'example');
      expect(tool['server_description'], 'Test MCP server');
      expect(tool['allowed_tool_names'], ['search_docs', 'lookup_api']);
      expect(tool['authorization'], 'Bearer token');
      expect(tool['extra_headers'], {'X-Test': '1'});
    });

    test('keeps MCP out of OpenAI server-side tool enum mapping', () {
      final mapped = XAIResponsesChatModel.toOpenAIOptionsForTesting(
        const XAIResponsesChatModelOptions(
          serverSideTools: {XAIServerSideTool.mcp},
        ),
      );

      expect(mapped.serverSideTools, isEmpty);
    });

    test('keeps image generation mapping in chat path', () {
      final mapped = XAIResponsesChatModel.toOpenAIOptionsForTesting(
        const XAIResponsesChatModelOptions(
          serverSideTools: {XAIServerSideTool.imageGeneration},
        ),
      );

      // Chat mapping remains independent from native media endpoint routing.
      expect(
        mapped.serverSideTools,
        contains(OpenAIServerSideTool.imageGeneration),
      );
    });
  });
}
