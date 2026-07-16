using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using Microsoft.AspNetCore.Mvc;

namespace WebApp_Storage_DotNet.Controllers;

public class HomeController(IConfiguration configuration) : Controller
{
    private const string BlobContainerName = "webappstoragedotnet-imagecontainer";

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
    public async Task<IActionResult> UploadAsync()
    {
        try
        {
            var blobContainer = await GetBlobContainerAsync();
            var files = Request.Form.Files;

            foreach (var file in files.Where(file => file.Length > 0))
            {
                BlobClient blob = blobContainer.GetBlobClient(GetRandomBlobName(file.FileName));
                await using var stream = file.OpenReadStream();
                await blob.UploadAsync(stream, overwrite: false);
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
        var blobServiceClient = new BlobServiceClient(configuration.GetConnectionString("StorageConnectionString"));
        var containerClient = blobServiceClient.GetBlobContainerClient(BlobContainerName);
        await containerClient.CreateIfNotExistsAsync(PublicAccessType.Blob);
        return containerClient;
    }

    private static string GetRandomBlobName(string filename)
    {
        var ext = Path.GetExtension(filename);
        return $"{DateTime.UtcNow.Ticks}_{Guid.NewGuid()}{ext}";
    }
}
