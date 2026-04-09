using SeriesApp.DAL.Repository;

namespace SeriesApp.BAL.Services
{
    public class ErrorLogService
    {
        private readonly ErrorLogRepository repository;

        public ErrorLogService()
        {
            repository = new ErrorLogRepository();
        }

        
        public void LogError(string message, string stackTrace, string pageName)
        {
            repository.LogError(message, stackTrace, pageName);
        }
    }
}