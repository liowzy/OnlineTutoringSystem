using OnlineTutoringSystem.Tutor;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI; 
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem
{
    public partial class WebForm1211 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["Resources"] = new List<Resource>();
            }
        }

    protected void btnAddResource_Click(object sender, EventArgs e)
    {
            addResourceServerSide();
    }

        protected void addResourceServerSide()
        {
            // Retrieve data from the fields
            string resourceName = txtResourceName.Text;
            string fileName = txtFileName.Text;

            // Assuming fileUpload is an ASP.NET FileUpload control
            byte[] fileData = fileUpload.FileBytes; // Convert file to byte array

            // Add the resource to your dataset or database (you need to have a mechanism to store this data)
            // For now, let's assume you have a List to store the resources
            List<Resource> resources = ViewState["Resources"] as List<Resource> ?? new List<Resource>();
            resources.Add(new Resource { ResourceName = resourceName, FileName = fileName, FileData = fileData });

            // Update the ViewState
            ViewState["Resources"] = resources;

            // Refresh the GridView
            GridViewResource.DataSource = resources;
            GridViewResource.DataBind();

            // Clear form fields
            ClearFormFields();
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
    {
        // For testing purposes, you can inspect the resources in ViewState
        List<Resource> resources = ViewState["Resources"] as List<Resource>;

        if (resources != null)
        {
            foreach (var resource in resources)
            {
                // Process each resource as needed
                // In a real application, you would save this data to the database
            }
        }
    }

    private void ClearFormFields()
    {
        // Clear the form fields after adding a resource
        txtResourceName.Text = string.Empty;
        txtFileName.Text = string.Empty;

        // Reset the FileUpload control
        fileUpload.Attributes.Clear();
        fileUpload.PostedFile.InputStream.Position = 0;
        fileUpload.PostedFile.InputStream.Seek(0, System.IO.SeekOrigin.Begin);
    }

        [Serializable]
        public class Resource
        {
            public string ResourceName { get; set; }
            public string FileName { get; set; }
            public byte[] FileData { get; set; }
        }

    }
}