using System.Text;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;

public class RequestResponseLoggingMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger _logger;

    public RequestResponseLoggingMiddleware(RequestDelegate next, ILoggerFactory loggerFactory)
    {
        _next = next;
        _logger = loggerFactory.CreateLogger<RequestResponseLoggingMiddleware>();
    }

    public async Task Invoke(HttpContext context)
    {
        // Log the request
        await LogRequest(context.Request);

        // Create a new response body stream
        var originalBodyStream = context.Response.Body;
        using var responseBody = new MemoryStream();
        context.Response.Body = responseBody;

        // Continue down the Middleware pipeline
        await _next(context);

        // Log the response
        await LogResponse(context.Response);

        // Copy the response to the original stream and restore the response body
        await responseBody.CopyToAsync(originalBodyStream);
        context.Response.Body = originalBodyStream;
    }

    private async Task LogRequest(HttpRequest request)
    {
        request.EnableBuffering();
        var body = await new StreamReader(request.Body).ReadToEndAsync();
        request.Body.Position = 0;

        _logger.LogInformation($"Request Headers: {request.Headers}");
        _logger.LogInformation($"Request: {request.Method} {request.Path} {request.QueryString} {body}");
    }

    private async Task LogResponse(HttpResponse response)
    {
        response.Body.Seek(0, SeekOrigin.Begin);
        var body = await new StreamReader(response.Body).ReadToEndAsync();
        response.Body.Seek(0, SeekOrigin.Begin);

        _logger.LogInformation($"Response: {response.StatusCode} {body}");
    }
}