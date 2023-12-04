using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace OnlineTutoringSystem
{
    /// <summary>
    /// Summary description for FileHandler
    /// </summary>
    public class FileHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            // Retrieve the file path from the query string
            string filePath = context.Request.QueryString["filePath"];

            if (!string.IsNullOrEmpty(filePath))
            {
                // Map the virtual file path to the physical file path
                string physicalPath = context.Server.MapPath(filePath);

                // Check if the file exists
                if (File.Exists(physicalPath))
                {
                    // Set the content type based on the file extension
                    string contentType = MimeMapping.GetMimeMapping(Path.GetExtension(physicalPath));
                    context.Response.ContentType = contentType;

                    // Set the content-disposition header to force the browser to prompt the user to download the file
                    context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(physicalPath));

                    // Write the file content to the response
                    context.Response.WriteFile(physicalPath);

                    // End the response to prevent any additional content from being sent
                    context.Response.End();
                }
                else
                {
                    // File not found
                    context.Response.StatusCode = 404;
                    context.Response.StatusDescription = "File not found";
                    context.Response.Write("File not found");
                }
            }
            else
            {
                // Invalid request
                context.Response.StatusCode = 400;
                context.Response.StatusDescription = "Bad request";
                context.Response.Write("Bad request");
            }
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}