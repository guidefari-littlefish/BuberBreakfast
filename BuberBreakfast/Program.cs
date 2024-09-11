using BuberBreakfast.Services.Breakfasts;
//using BuberBreakfast.Services.Breakfasts.RequestResponseLoggingMiddleware;

var builder = WebApplication.CreateBuilder(args);
{
    builder.Services.AddControllers();
    builder.Services.AddSingleton<IBreakfastService, BreakfastService>();
}

// Add services to the container.


var app = builder.Build();
{
    app.UseMiddleware<RequestResponseLoggingMiddleware>();
    app.UseHttpsRedirection();
    app.MapControllers();
    app.Run();
}
