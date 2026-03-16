import 'package:dartantic_interface/dartantic_interface.dart';
import 'package:meta/meta.dart';

/// Options for configuring the xAI Responses chat model.
@immutable
class XAIResponsesChatModelOptions extends ChatModelOptions {
  /// Creates a new set of options for the xAI Responses chat model.
  const XAIResponsesChatModelOptions({
    this.temperature,
    this.topP,
    this.maxOutputTokens,
    this.store,
    this.metadata,
    this.include,
    this.parallelToolCalls,
    this.reasoning,
    this.reasoningEffort,
    this.reasoningSummary,
    this.responseFormat,
    this.truncationStrategy,
    this.user,
    this.imageDetail,
    this.serverSideTools,
    this.fileSearchConfig,
    this.webSearchConfig,
    this.codeInterpreterConfig,
    this.imageGenerationConfig,
    this.mcpTools,
  });

  /// Sampling temperature for generation.
  final double? temperature;

  /// Nucleus sampling parameter.
  final double? topP;

  /// Maximum number of output tokens.
  final int? maxOutputTokens;

  /// Whether to persist server-side session state.
  final bool? store;

  /// Optional metadata forwarded to the API.
  final Map<String, dynamic>? metadata;

  /// Additional response fields to include.
  final List<String>? include;

  /// Whether multiple tool calls can run in parallel.
  final bool? parallelToolCalls;

  /// Reasoning configuration payload.
  final Map<String, dynamic>? reasoning;

  /// Requested reasoning effort level.
  final XAIReasoningEffort? reasoningEffort;

  /// Requested reasoning summary style.
  final XAIReasoningSummary? reasoningSummary;

  /// Response formatting configuration.
  final Map<String, dynamic>? responseFormat;

  /// Truncation configuration.
  final Map<String, dynamic>? truncationStrategy;

  /// End-user identifier.
  final String? user;

  /// Preferred detail for image inputs.
  final XAIImageDetail? imageDetail;

  /// Enabled xAI server-side tools.
  final Set<XAIServerSideTool>? serverSideTools;

  /// Configuration for the `file_search` tool.
  final XAIFileSearchConfig? fileSearchConfig;

  /// Configuration for the `web_search` tool.
  final XAIWebSearchConfig? webSearchConfig;

  /// Configuration for the `code_interpreter` tool.
  final XAICodeInterpreterConfig? codeInterpreterConfig;

  /// Configuration for the `image_generation` tool.
  final XAIImageGenerationConfig? imageGenerationConfig;

  /// Configuration for one or more remote MCP tools.
  final List<XAIMcpToolConfig>? mcpTools;
}

/// Reasoning effort levels for xAI Responses models.
enum XAIReasoningEffort {
  /// Lower latency, lower reasoning depth.
  low,

  /// Balanced latency and reasoning depth.
  medium,

  /// Highest reasoning depth.
  high,
}

/// Reasoning summary verbosity preference for xAI Responses.
enum XAIReasoningSummary {
  /// Return a detailed summary.
  detailed,

  /// Return a concise summary.
  concise,

  /// Let the model choose.
  auto,

  /// Do not request summary content.
  none,
}

/// Preferred detail level for image inputs.
enum XAIImageDetail {
  /// Automatic detail selection.
  auto,

  /// Lower-detail processing.
  low,

  /// Higher-detail processing.
  high,
}

/// xAI server-side tools for Responses calls.
enum XAIServerSideTool {
  /// Web search tool.
  webSearch,

  /// File search tool.
  fileSearch,

  /// Image generation tool.
  imageGeneration,

  /// Code interpreter tool.
  codeInterpreter,

  /// Remote MCP tool.
  mcp,
}

/// Configuration for the xAI `file_search` tool.
@immutable
class XAIFileSearchConfig {
  /// Creates a file search configuration.
  const XAIFileSearchConfig({
    this.vectorStoreIds = const <String>[],
    this.maxResults,
    this.filters,
    this.ranker,
    this.scoreThreshold,
  });

  /// Vector store IDs to search across.
  final List<String> vectorStoreIds;

  /// Maximum number of result chunks returned by the API.
  final int? maxResults;

  /// Optional server-side filter payload.
  final Map<String, dynamic>? filters;

  /// Optional ranker identifier.
  final String? ranker;

  /// Minimum score threshold for returned chunks.
  final num? scoreThreshold;
}

/// Context size hint for web search.
enum XAIWebSearchContextSize {
  /// Lower context for faster responses.
  low,

  /// Balanced context size.
  medium,

  /// Maximum context collection.
  high,
}

/// Approximate user location for web search.
@immutable
class XAIWebSearchLocation {
  /// Creates a web search location hint.
  const XAIWebSearchLocation({
    this.city,
    this.region,
    this.country,
    this.timezone,
  });

  /// City hint.
  final String? city;

  /// Region/state hint.
  final String? region;

  /// Country hint.
  final String? country;

  /// IANA timezone hint.
  final String? timezone;
}

/// Configuration for the xAI `web_search` tool.
@immutable
class XAIWebSearchConfig {
  /// Creates a web search configuration.
  const XAIWebSearchConfig({
    this.contextSize,
    this.location,
    this.followupQuestions,
    this.searchContentTypes,
  });

  /// Context size hint.
  final XAIWebSearchContextSize? contextSize;

  /// Optional user location hint.
  final XAIWebSearchLocation? location;

  /// Whether follow-up questions are requested.
  final bool? followupQuestions;

  /// Desired content types, e.g. `text` or `image`.
  final List<String>? searchContentTypes;
}

/// Configuration for the xAI `code_interpreter` tool.
@immutable
class XAICodeInterpreterConfig {
  /// Creates a code interpreter configuration.
  const XAICodeInterpreterConfig({this.containerId, this.fileIds});

  /// Existing container ID to reuse.
  final String? containerId;

  /// File IDs to mount into the container.
  final List<String>? fileIds;
}

/// Image generation quality hint.
enum XAIImageGenerationQuality {
  /// Lower quality.
  low,

  /// Medium quality.
  medium,

  /// Highest quality.
  high,

  /// Provider-selected quality.
  auto,
}

/// Image generation size hint.
enum XAIImageGenerationSize {
  /// Provider-selected size.
  auto,

  /// 256x256.
  square256,

  /// 512x512.
  square512,

  /// 1024x1024.
  square1024,

  /// 1536x1024.
  landscape1536x1024,

  /// 1792x1024.
  landscape1792x1024,

  /// 1024x1536.
  portrait1024x1536,

  /// 1024x1792.
  portrait1024x1792,
}

/// Configuration for the xAI `image_generation` tool.
@immutable
class XAIImageGenerationConfig {
  /// Creates an image generation configuration.
  const XAIImageGenerationConfig({
    this.partialImages = 0,
    this.quality = XAIImageGenerationQuality.auto,
    this.size = XAIImageGenerationSize.auto,
  });

  /// Number of partial preview images to stream.
  final int partialImages;

  /// Output quality hint.
  final XAIImageGenerationQuality quality;

  /// Output size hint.
  final XAIImageGenerationSize size;
}

/// Configuration for a remote MCP server tool.
@immutable
class XAIMcpToolConfig {
  /// Creates an MCP server configuration.
  const XAIMcpToolConfig({
    required this.serverUrl,
    this.serverLabel,
    this.serverDescription,
    this.allowedToolNames,
    this.authorization,
    this.extraHeaders,
  });

  /// MCP server URL.
  final String serverUrl;

  /// Optional display label for the server.
  final String? serverLabel;

  /// Optional server description.
  final String? serverDescription;

  /// Optional allowlist of tools.
  final List<String>? allowedToolNames;

  /// Optional bearer token forwarded as Authorization.
  final String? authorization;

  /// Optional custom headers forwarded to the MCP server.
  final Map<String, String>? extraHeaders;
}
