using System;
using System.Collections.Generic;
using System.Data;
using SeriesApp.DAL.Repository;
using SeriesApp.BAL.Models;

namespace SeriesApp.BAL.Services
{
    public class SeriesService
    {
        private readonly SeriesRepository repository;

        public SeriesService()
        {
            repository = new SeriesRepository();
        }

        public int AddSeries(SeriesModel model)
        {
            ValidateModel(model);

            return repository.InsertSeries(
                model.Title,
                model.Description,
                model.ReleaseYear,
                model.Genre
            );
        }

        public int UpdateSeries(SeriesModel model)
        {
            ValidateModel(model);

            return repository.UpdateSeries(
                model.SeriesId,
                model.Title,
                model.Description,
                model.ReleaseYear,
                model.Genre
            );
        }

        public List<SeriesModel> SearchSeries(string title, int? releaseYear)
        {
            DataTable dt = repository.SearchSeries(title, releaseYear);

            List<SeriesModel> list = new List<SeriesModel>();

            foreach (DataRow row in dt.Rows)
            {
                list.Add(new SeriesModel
                {
                    SeriesId = Convert.ToInt32(row["SeriesId"]),
                    Title = row["Title"].ToString(),
                    Description = row["Description"].ToString(),
                    ReleaseYear = Convert.ToInt32(row["ReleaseYear"]),
                    Genre = row["Genre"].ToString(),
                    CreatedDate = Convert.ToDateTime(row["CreatedDate"]),
                    UpdatedDate = row["UpdatedDate"] == DBNull.Value
                                  ? (DateTime?)null
                                  : Convert.ToDateTime(row["UpdatedDate"])
                });
            }

            return list;
        }

        private void ValidateModel(SeriesModel model)
        {
            if (string.IsNullOrWhiteSpace(model.Title))
                throw new Exception("Title is required");

            if (model.ReleaseYear <= 0)
                throw new Exception("Invalid Release Year");
        }
    }
}