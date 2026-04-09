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
                model.Genre,

                model.SeriesApiId,
                model.SeriesType,
                model.SeriesStatus,
                model.MatchStatus,
                model.MatchFormat,
                model.SeriesMatchType,
                model.Gender,
                model.TrophyType,
                model.StartDate,
                model.EndDate,
                model.IsActive
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
                model.Genre,

                model.SeriesApiId,
                model.SeriesType,
                model.SeriesStatus,
                model.MatchStatus,
                model.MatchFormat,
                model.SeriesMatchType,
                model.Gender,
                model.TrophyType,
                model.StartDate,
                model.EndDate,
                model.IsActive
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

                    SeriesApiId = row["SeriesApiId"] == DBNull.Value ? 0 : Convert.ToInt32(row["SeriesApiId"]),
                    SeriesType = row["SeriesType"].ToString(),
                    SeriesStatus = row["SeriesStatus"].ToString(),
                    MatchStatus = row["MatchStatus"].ToString(),
                    MatchFormat = row["MatchFormat"].ToString(),
                    SeriesMatchType = row["SeriesMatchType"].ToString(),
                    Gender = row["Gender"].ToString(),
                    TrophyType = row["TrophyType"].ToString(),

                    StartDate = row["StartDate"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["StartDate"]),
                    EndDate = row["EndDate"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["EndDate"]),

                    IsActive = row["IsActive"] == DBNull.Value ? false : Convert.ToBoolean(row["IsActive"]),
                    CreatedDate = Convert.ToDateTime(row["CreatedDate"]),
                    UpdatedDate = row["UpdatedDate"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["UpdatedDate"])
                });
            }

            return list;
        }
        public int DeleteSeries(int seriesId)
        {
            if (seriesId <= 0)
                throw new Exception("Invalid Series ID");

            return repository.DeleteSeries(seriesId);
        }

        private void ValidateModel(SeriesModel model)
        {
            if (string.IsNullOrWhiteSpace(model.Title))
                throw new Exception("Title is required");
        }
    }
}