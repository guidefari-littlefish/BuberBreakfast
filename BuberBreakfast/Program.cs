using BuberBreakfast.Services.Breakfasts;
//using BuberBreakfast.Services.Breakfasts.RequestResponseLoggingMiddleware;

var builder = WebApplication.CreateBuilder(args);
{
    builder.Services.AddControllers();
    builder.Services.AddScoped<IBreakfastService, BreakfastService>();
}

// Add services to the container.


var app = builder.Build();
{
    app.UseExceptionHandler("/error");
    app.UseMiddleware<RequestResponseLoggingMiddleware>();
    app.UseHttpsRedirection();
    app.MapControllers();
    app.Run();
}
