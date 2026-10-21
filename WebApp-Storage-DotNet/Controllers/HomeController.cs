using System.Security.Cryptography;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using Microsoft.AspNetCore.Mvc;
using WebApp_Storage_DotNet.Models;

namespace WebApp_Storage_DotNet.Controllers;

public sealed class HomeController(
    BlobServiceClient blobServiceClient,
    ILogger<HomeController> logger) : Controller
{
    private const string BlobContainerName = "webappstoragedotnet-imagecontainer";

    public async Task<IActionResult> Index()
    {
        try
        {
            var container = await GetContainerAsync();
            var images = new List<GalleryImage>();

            await foreach (var blob in container.GetBlobsAsync())
            {
                if (blob.Properties.BlobType == BlobType.Block)
                {
                    var blobClient = container.GetBlobClient(blob.Name);
                    images.Add(new GalleryImage(blob.Name, blobClient.Uri));
                }
            }

            return View(images);
        }
        catch (Exception exception)
        {
            logger.LogError(exception, "Unable to load the photo gallery.");
            return View("Error");
        }
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> UploadAsync(List<IFormFile>? selectFiles)
    {
        try
        {
            if (selectFiles is not null)
            {
                var container = await GetContainerAsync();
                foreach (var file in selectFiles.Where(file => file.Length > 0))
                {
                    var extension = Path.GetExtension(Path.GetFileName(file.FileName));
                    var blobName = $"{DateTimeOffset.UtcNow.ToUnixTimeMilliseconds()}_{Convert.ToHexString(RandomNumberGenerator.GetBytes(16))}{extension}";
                    var blob = container.GetBlobClient(blobName);
                    await using var stream = file.OpenReadStream();
                    await blob.UploadAsync(stream, new BlobUploadOptions
                    {
                        HttpHeaders = new BlobHttpHeaders
                        {
                            ContentType = string.IsNullOrWhiteSpace(file.ContentType)
                                ? "application/octet-stream"
                                : file.ContentType
                        }
                    });
                }
            }

            return RedirectToAction(nameof(Index));
        }
        catch (Exception exception)
        {
            logger.LogError(exception, "Unable to upload gallery images.");
            return View("Error");
        }
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteImage(string blobName)
    {
        try
        {
            var container = await GetContainerAsync();
            await container.DeleteBlobIfExistsAsync(blobName);
            return RedirectToAction(nameof(Index));
        }
        catch (Exception exception)
        {
            logger.LogError(exception, "Unable to delete gallery image.");
            return View("Error");
        }
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteAll()
    {
        try
        {
            var container = await GetContainerAsync();
            await foreach (var blob in container.GetBlobsAsync())
            {
                if (blob.Properties.BlobType == BlobType.Block)
                {
                    await container.DeleteBlobIfExistsAsync(blob.Name);
                }
            }

            return RedirectToAction(nameof(Index));
        }
        catch (Exception exception)
        {
            logger.LogError(exception, "Unable to delete gallery images.");
            return View("Error");
        }
    }

    public IActionResult Error() => View();

    private async Task<BlobContainerClient> GetContainerAsync()
    {
        var container = blobServiceClient.GetBlobContainerClient(BlobContainerName);
        await container.CreateIfNotExistsAsync(PublicAccessType.Blob);
        return container;
    }
}
