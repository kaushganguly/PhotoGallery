// ----------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
//
// THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,
// EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES
// OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
// ----------------------------------------------------------------------------------

namespace WebApp_Storage_DotNet.Controllers
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Http;
    using Microsoft.AspNetCore.Mvc;
    using Azure.Storage.Blobs;
    using Azure.Storage.Blobs.Models;

    public class HomeController : Controller
    {
        const string blobContainerName = "webappstoragedotnet-imagecontainer";

        private readonly BlobServiceClient _blobServiceClient;

        public HomeController(BlobServiceClient blobServiceClient)
        {
            _blobServiceClient = blobServiceClient;
        }

        private BlobContainerClient GetBlobContainer()
        {
            return _blobServiceClient.GetBlobContainerClient(blobContainerName);
        }

        public async Task<IActionResult> Index()
        {
            try
            {
                BlobContainerClient container = GetBlobContainer();
                await container.CreateIfNotExistsAsync(PublicAccessType.Blob);

                List<Uri> allBlobs = new List<Uri>();
                foreach (BlobItem blob in container.GetBlobs())
                {
                    if (blob.Properties.BlobType == BlobType.Block)
                        allBlobs.Add(container.GetBlobClient(blob.Name).Uri);
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
                IFormFileCollection files = Request.Form.Files;
                int fileCount = files.Count;

                if (fileCount > 0)
                {
                    BlobContainerClient container = GetBlobContainer();
                    for (int i = 0; i < fileCount; i++)
                    {
                        BlobClient blob = container.GetBlobClient(GetRandomBlobName(files[i].FileName));
                        await blob.UploadAsync(files[i].OpenReadStream());
                    }
                }
                return RedirectToAction("Index");
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
                Uri uri = new Uri(name);
                string filename = Path.GetFileName(uri.LocalPath);

                var blob = GetBlobContainer().GetBlobClient(filename);
                await blob.DeleteIfExistsAsync();

                return RedirectToAction("Index");
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
                BlobContainerClient container = GetBlobContainer();
                foreach (var blob in container.GetBlobs())
                {
                    if (blob.Properties.BlobType == BlobType.Block)
                    {
                        await container.DeleteBlobIfExistsAsync(blob.Name);
                    }
                }

                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                ViewData["message"] = ex.Message;
                ViewData["trace"] = ex.StackTrace;
                return View("Error");
            }
        }

        private string GetRandomBlobName(string filename)
        {
            string ext = Path.GetExtension(filename);
            return string.Format("{0:10}_{1}{2}", DateTime.Now.Ticks, Guid.NewGuid(), ext);
        }
    }
}