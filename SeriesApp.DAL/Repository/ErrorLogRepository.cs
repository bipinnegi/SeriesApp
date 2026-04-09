using System.Data;
using System.Data.SqlClient;
using SeriesApp.DAL.DBHelper;

namespace SeriesApp.DAL.Repository
{
    public class ErrorLogRepository
    {
        private readonly DBHelper.DBHelper dbHelper;

        public ErrorLogRepository()
        {
            dbHelper = new DBHelper.DBHelper();
        }

        
        public void LogError(string message, string stackTrace, string pageName)
        {
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@ErrorMessage", message),
                new SqlParameter("@StackTrace", stackTrace),
                new SqlParameter("@PageName", pageName)
            };

            dbHelper.ExecuteNonQuery("sp_LogError", CommandType.StoredProcedure, parameters);
        }
    }
}