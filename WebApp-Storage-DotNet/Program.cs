using Azure.Identity;
using Microsoft.Extensions.Azure;
using Microsoft.Extensions.FileProviders;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

// Configure structured JSON console logging for Azure Container Apps log aggregation.
// Clears default providers (simple console, debug) to avoid duplicate output.
builder.Logging.ClearProviders();
builder.Logging.AddJsonConsole(options =>
{
    options.IncludeScopes = true;
    options.UseUtcTimestamp = true;
    options.TimestampFormat = "yyyy-MM-ddTHH:mm:ss.fffZ";
    options.JsonWriterOptions = new JsonWriterOptions
    {
        Indented = false
    };
});

// Add services to the container.
builder.Services.AddControllersWithViews();

// Register BlobServiceClient using Managed Identity (DefaultAzureCredential).
// Reads Storage:ServiceUri from configuration — no connection strings required.
builder.Services.AddAzureClients(clientBuilder =>
{
    clientBuilder.AddBlobServiceClient(
        builder.Configuration.GetSection("Storage"));
    clientBuilder.UseCredential(new DefaultAzureCredential());
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();

// Serve static files from legacy content folders (Content, Scripts, Images, fonts)
var contentRoot = app.Environment.ContentRootPath;
foreach (var folder in new[] { "Content", "Scripts", "Images", "fonts" })
{
    var folderPath = Path.Combine(contentRoot, folder);
    if (Directory.Exists(folderPath))
    {
        app.UseStaticFiles(new StaticFileOptions
        {
            FileProvider = new PhysicalFileProvider(folderPath),
            RequestPath = "/" + folder
        });
    }
}

app.UseRouting();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();