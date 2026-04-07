using System;
using System.Collections.Generic;
using System.Web.Http;
using SeriesApp.BAL.Services;
using SeriesApp.BAL.Models;

namespace SeriesApp.UI.Controllers
{
    public class SeriesController : ApiController
    {
        private readonly SeriesService service;

        public SeriesController()
        {
            service = new SeriesService();
        }

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
    }
}