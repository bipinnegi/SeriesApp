using System;
using System.Collections.Generic;
using System.Web.Http;
using SeriesApp.BAL.Services;
using SeriesApp.BAL.Models;
using SeriesApp.UI.Helpers;

namespace SeriesApp.UI.Controllers
{
    public class SeriesController : ApiController
    {
        private readonly SeriesService service;
        private readonly ErrorLogService logger;

        public SeriesController()
        {
            service = new SeriesService();
            logger = new ErrorLogService();
        }

       
        // ADD
        [HttpPost]
        public IHttpActionResult Add(SeriesModel model)
        {
            try
            {
                int id = service.AddSeries(model);
                return Ok(new { success = true, id = id });
            }
            catch (Exception ex)
            {
                logger.LogError(ex.Message, ex.StackTrace, "Add API");
                return Ok(new { success = false, message = "Error occurred" });
            }
        }

       
        // UPDATE
        [HttpPost]
        public IHttpActionResult Update(SeriesModel model)
        {
            try
            {
                service.UpdateSeries(model);
                return Ok(new { success = true });
            }
            catch (Exception ex)
            {
                logger.LogError(ex.Message, ex.StackTrace, "Update API");
                return Ok(new { success = false, message = "Error occurred" });
            }
        }

        
        // SEARCH
        
        [HttpGet]
        public IHttpActionResult Search(string title = null, int? releaseYear = null)
        {
            try
            {
                var data = service.SearchSeries(title, releaseYear);
                return Ok(data);
            }
            catch (Exception ex)
            {
                logger.LogError(ex.Message, ex.StackTrace, "Search API");
                return Ok(new { success = false });
            }
        }

        
        
        [HttpDelete]
        public IHttpActionResult Delete(int id)
        {
            try
            {
                service.DeleteSeries(id);
                return Ok(new { success = true });
            }
            catch (Exception ex)
            {
                logger.LogError(ex.Message, ex.StackTrace, "Delete API");
                return Ok(new { success = false, message = "Error occurred" });
            }
        }

       
        // ENCRYPT
        [HttpGet]
        public IHttpActionResult Encrypt(string q)
        {
            try
            {
                string encrypted = CryptoHelper.Encrypt(q);
                return Ok(encrypted);
            }
            catch (Exception ex)
            {
                logger.LogError(ex.Message, ex.StackTrace, "Encrypt API");
                return Ok("Error");
            }
        }

     
        // DECRYPT
        [HttpGet]
        public IHttpActionResult Decrypt(string q)
        {
            try
            {
                string decrypted = CryptoHelper.Decrypt(q);
                return Ok(decrypted);
            }
            catch (Exception ex)
            {
                logger.LogError(ex.Message, ex.StackTrace, "Decrypt API");
                return Ok("Error");
            }
        }

        
        // GET BY ID
        [HttpGet]
        public IHttpActionResult GetById(int id)
        {
            try
            {
                var list = service.SearchSeries(null, null);
                var item = list.Find(x => x.SeriesId == id);

                if (item == null)
                    return NotFound();

                return Ok(item);
            }
            catch (Exception ex)
            {
                logger.LogError(ex.Message, ex.StackTrace, "GetById API");
                return NotFound();
            }
        }
    }
}