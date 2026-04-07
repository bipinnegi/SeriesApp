using System;
using System.Data;
using System.Data.SqlClient;
using SeriesApp.DAL.DBHelper;

namespace SeriesApp.DAL.Repository
{
    public class SeriesRepository
    {
        private readonly DBHelper.DBHelper dbHelper;

        public SeriesRepository()
        {
            dbHelper = new DBHelper.DBHelper();
        }

        public int InsertSeries(string title, string description, int releaseYear, string genre)
        {
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Title", title),
                new SqlParameter("@Description", description),
                new SqlParameter("@ReleaseYear", releaseYear),
                new SqlParameter("@Genre", genre)
            };

            object result = dbHelper.ExecuteScalar("sp_InsertSeries", CommandType.StoredProcedure, parameters);

            return Convert.ToInt32(result);
        }

        public int UpdateSeries(int seriesId, string title, string description, int releaseYear, string genre)
        {
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@SeriesId", seriesId),
                new SqlParameter("@Title", title),
                new SqlParameter("@Description", description),
                new SqlParameter("@ReleaseYear", releaseYear),
                new SqlParameter("@Genre", genre)
            };

            return dbHelper.ExecuteNonQuery("sp_UpdateSeries", CommandType.StoredProcedure, parameters);
        }

        public DataTable SearchSeries(string title, int? releaseYear)
        {
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Title", (object)title ?? DBNull.Value),
                new SqlParameter("@ReleaseYear", (object)releaseYear ?? DBNull.Value)
            };

            return dbHelper.ExecuteSelectCommand("sp_SearchSeries", CommandType.StoredProcedure, parameters);
        }
    }
}