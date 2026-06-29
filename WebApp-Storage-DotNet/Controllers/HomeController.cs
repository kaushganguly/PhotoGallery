//---------------------------------------------------------------------------------- 
// Copyright (c) Microsoft Corporation. All rights reserved. 
// 
// THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,  
// EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES  
// OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE. 
//---------------------------------------------------------------------------------- 
// The example companies, organizations, products, domain names, 
// e-mail addresses, logos, people, places, and events depicted 
// herein are fictitious.  No association with any real company, 
// organization, product, domain name, email address, logo, person, 
// places, or events is intended or should be inferred. 

namespace WebApp_Storage_DotNet.Controllers
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Threading.Tasks;
    using Azure.Storage.Blobs;
    using Azure.Storage.Blobs.Models;
    using Microsoft.AspNetCore.Http;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.Configuration;

    /// <summary>
    /// Azure Blob Storage Photo Gallery - Demonstrates how to use the Blob Storage service.
    /// Blob storage stores unstructured data such as text, binary data, documents or media files.
    /// Blobs can be accessed from anywhere in the world via HTTP or HTTPS.
    /// </summary>
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
        public async Task<IActionResult> UploadAsync(List<IFormFile>? selectFiles)
        {
            try
            {
                var blobContainer = await GetBlobContainerAsync();

                if (selectFiles is not null)
                {
                    foreach (var file in selectFiles)
                    {
                        if (file.Length <= 0)
                        {
                            continue;
                        }

                        BlobClient blob = blobContainer.GetBlobClient(GetRandomBlobName(file.FileName));
                        await using var stream = file.OpenReadStream();
                        await blob.UploadAsync(
                            stream,
                            new BlobUploadOptions
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
                Uri uri = new(name);
                string filename = Path.GetFileName(uri.LocalPath);

                await blobContainer.DeleteBlobIfExistsAsync(filename);

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

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View();
        }

        private async Task<BlobContainerClient> GetBlobContainerAsync()
        {
            var connectionString = configuration["StorageConnectionString"];
            if (string.IsNullOrWhiteSpace(connectionString))
            {
                throw new InvalidOperationException("StorageConnectionString is not configured.");
            }

            BlobContainerClient blobContainer = new BlobServiceClient(connectionString).GetBlobContainerClient(BlobContainerName);
            await blobContainer.CreateIfNotExistsAsync(PublicAccessType.Blob);
            return blobContainer;
        }

        private string GetRandomBlobName(string filename)
        {
            string extension = Path.GetExtension(filename);
            return $"{DateTime.UtcNow.Ticks}_{Guid.NewGuid()}{extension}";
        }
    }
}
