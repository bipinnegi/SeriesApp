using System;

namespace SeriesApp.BAL.Models
{
    public class SeriesModel
    {
        public int SeriesId { get; set; }

        public string Title { get; set; }
        public string Description { get; set; }
        public int ReleaseYear { get; set; }
        public string Genre { get; set; }

        public int SeriesApiId { get; set; }
        public string SeriesType { get; set; }
        public string SeriesStatus { get; set; }
        public string MatchStatus { get; set; }
        public string MatchFormat { get; set; }
        public string SeriesMatchType { get; set; }
        public string Gender { get; set; }
        public string TrophyType { get; set; }

        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }

        public bool IsActive { get; set; }

        public DateTime CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }
    }
}