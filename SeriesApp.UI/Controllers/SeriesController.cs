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

        public SeriesController()
        {
            service = new SeriesService();
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
                return Ok(new { success = false, message = ex.Message });
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
                return Ok(new { success = false, message = ex.Message });
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
                return Ok(new { success = false, message = ex.Message });
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
                return Ok("Error: " + ex.Message);
            }
        }

        
        //  DECRYPT
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
                return Ok("Error: " + ex.Message);
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

                return Ok(item);
            }
            catch (Exception ex)
            {
                return Ok(new { success = false, message = ex.Message });
            }
        }
    }
}