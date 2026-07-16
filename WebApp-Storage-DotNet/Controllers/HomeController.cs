using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using Microsoft.AspNetCore.Mvc;

namespace WebApp_Storage_DotNet.Controllers;

public class HomeController : Controller
{
    private const string BlobContainerName = "webappstoragedotnet-imagecontainer";
    private readonly IConfiguration _configuration;

    public HomeController(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public async Task<IActionResult> Index()
    {
        try
        {
            var blobContainer = await GetBlobContainerAsync();
            var allBlobs = new List<Uri>();

            await foreach (BlobItem blob in blobContainer.GetBlobsAsync())
            {
                if (blob.Properties.BlobType == BlobType.Block)
                {
                    allBlobs.Add(blobContainer.GetBlobClient(blob.Name).Uri);
                }
            }

            return View(allBlobs);
        }
        catch (Exception ex)
        {
            ViewData["message"] = ex.Message;
            ViewData["trace"] = ex.StackTrace;
            return View("Error");
        }
    }

    [HttpPost]
    public async Task<IActionResult> UploadAsync(List<IFormFile> selectFiles)
    {
        try
        {
            if (selectFiles.Count > 0)
            {
                var blobContainer = await GetBlobContainerAsync();

                foreach (var file in selectFiles.Where(file => file.Length > 0))
                {
                    BlobClient blob = blobContainer.GetBlobClient(GetRandomBlobName(file.FileName));
                    await using var stream = file.OpenReadStream();
                    await blob.UploadAsync(stream, overwrite: false);
                }
            }

            return RedirectToAction(nameof(Index));
        }
        catch (Exception ex)
        {
            ViewData["message"] = ex.Message;
            ViewData["trace"] = ex.StackTrace;
            return View("Error");
        }
    }

    [HttpPost]
    public async Task<IActionResult> DeleteImage(string name)
    {
        try
        {
            var blobContainer = await GetBlobContainerAsync();
            var uri = new Uri(name);
            var filename = Path.GetFileName(uri.LocalPath);

            var blob = blobContainer.GetBlobClient(filename);
            await blob.DeleteIfExistsAsync();

            return RedirectToAction(nameof(Index));
        }
        catch (Exception ex)
        {
            ViewData["message"] = ex.Message;
            ViewData["trace"] = ex.StackTrace;
            return View("Error");
        }
    }

    [HttpPost]
    public async Task<IActionResult> DeleteAll()
    {
        try
        {
            var blobContainer = await GetBlobContainerAsync();

            await foreach (var blob in blobContainer.GetBlobsAsync())
            {
                if (blob.Properties.BlobType == BlobType.Block)
                {
                    await blobContainer.DeleteBlobIfExistsAsync(blob.Name);
                }
            }

            return RedirectToAction(nameof(Index));
        }
        catch (Exception ex)
        {
            ViewData["message"] = ex.Message;
            ViewData["trace"] = ex.StackTrace;
            return View("Error");
        }
    }

    private async Task<BlobContainerClient> GetBlobContainerAsync()
    {
        var connectionString = _configuration.GetConnectionString("StorageConnectionString")
            ?? _configuration["StorageConnectionString"];

        if (string.IsNullOrWhiteSpace(connectionString))
        {
            throw new InvalidOperationException("Storage connection string is missing. Set ConnectionStrings:StorageConnectionString in appsettings.json.");
        }

        var blobServiceClient = new BlobServiceClient(connectionString);
        var blobContainer = blobServiceClient.GetBlobContainerClient(BlobContainerName);
        await blobContainer.CreateIfNotExistsAsync(PublicAccessType.Blob);
        return blobContainer;
    }

    private static string GetRandomBlobName(string filename)
    {
        var ext = Path.GetExtension(filename);
        return $"{DateTime.UtcNow.Ticks}_{Guid.NewGuid()}{ext}";
    }
}
