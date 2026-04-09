<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddSeries.aspx.cs" Inherits="SeriesApp.UI.AddSeries" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Series</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

    <h2>Add / Edit Series</h2>

    <input type="hidden" id="seriesId" value="0" />

    <div>
        <label>Series Name:</label>
        <input type="text" id="title" />
    </div>

    <div>
        <label>Series API ID:</label>
        <input type="number" id="seriesApiId" />
    </div>

    <div>
        <label>Series Type:</label>
        <select id="seriesType">
            <option>International</option>
            <option>Domestic</option>
            <option>Women</option>
            <option>Mens</option>
        </select>
    </div>

    <div>
        <label>Series Status:</label>
        <select id="seriesStatus">
            <option>Scheduled</option>
            <option>Completed</option>
            <option>Live</option>
            <option>Abandon</option>
        </select>
    </div>

    <div>
        <label>Match Status:</label>
        <select id="matchStatus">
            <option>Scheduled</option>
            <option>Completed</option>
            <option>Live</option>
            <option>Abandon</option>
        </select>
    </div>

    <div>
        <label>Match Format:</label>
        <select id="matchFormat">
            <option>ODI</option>
            <option>TEST</option>
            <option>T20</option>
            <option>T10</option>
        </select>
    </div>

    <div>
        <label>Series Match Type:</label>
        <select id="seriesMatchType">
            <option>ODI</option>
            <option>TEST</option>
            <option>T20I</option>
        </select>
    </div>

    <div>
        <label>Gender:</label>
        <select id="gender">
            <option>Mens</option>
            <option>Womens</option>
            <option>Other</option>
        </select>
    </div>

    <div>
        <label>Year:</label>
        <input type="number" id="releaseYear" />
    </div>

    <div>
        <label>Trophy Type:</label>
        <input type="text" id="trophyType" />
    </div>

    <div>
        <label>Start Date:</label>
        <input type="date" id="startDate" />
    </div>

    <div>
        <label>End Date:</label>
        <input type="date" id="endDate" />
    </div>

    <div>
        <label>Is Active:</label>
        <select id="isActive">
            <option value="true">Yes</option>
            <option value="false">No</option>
        </select>
    </div>

    <div>
        <label>Description:</label>
        <textarea id="description"></textarea>
    </div>

    <br />

    <button id="btnSave">Save</button>

    <script>
        $(document).ready(function () {

            loadEditData();

            $("#btnSave").click(function () {

                var series = {
                    SeriesId: $("#seriesId").val(),
                    Title: $("#title").val(),
                    Description: $("#description").val(),
                    ReleaseYear: $("#releaseYear").val(),
                    Genre: "General",

                    SeriesApiId: $("#seriesApiId").val(),
                    SeriesType: $("#seriesType").val(),
                    SeriesStatus: $("#seriesStatus").val(),
                    MatchStatus: $("#matchStatus").val(),
                    MatchFormat: $("#matchFormat").val(),
                    SeriesMatchType: $("#seriesMatchType").val(),
                    Gender: $("#gender").val(),
                    TrophyType: $("#trophyType").val(),
                    StartDate: $("#startDate").val(),
                    EndDate: $("#endDate").val(),
                    IsActive: $("#isActive").val() === "true"
                };

                var url = "/api/series/add";

                if (series.SeriesId > 0) {
                    url = "/api/series/update";
                }

                $.ajax({
                    url: url,
                    type: "POST",
                    data: JSON.stringify(series),
                    contentType: "application/json",
                    success: function (response) {
                        if (response.success) {
                            alert("Saved successfully!");
                            window.location.href = "ManageSeries.aspx";
                        } else {
                            alert(response.message);
                        }
                    }
                });

            });

        });

        function loadEditData() {

            var params = new URLSearchParams(window.location.search);
            var encrypted = params.get("q");

            if (!encrypted) return;

            $.ajax({
                url: "/api/series/decrypt?q=" + encrypted,
                type: "GET",
                success: function (res) {

                    var parts = new URLSearchParams(res);
                    var mode = parts.get("Mode");
                    var id = parts.get("Sid");

                    if (mode === "E") {

                        $("#seriesId").val(id);

                        $.ajax({
                            url: "/api/series/getbyid?id=" + id,
                            type: "GET",
                            success: function (data) {

                                $("#title").val(data.Title);
                                $("#description").val(data.Description);
                                $("#releaseYear").val(data.ReleaseYear);

                                $("#seriesApiId").val(data.SeriesApiId);
                                $("#seriesType").val(data.SeriesType);
                                $("#seriesStatus").val(data.SeriesStatus);
                                $("#matchStatus").val(data.MatchStatus);
                                $("#matchFormat").val(data.MatchFormat);
                                $("#seriesMatchType").val(data.SeriesMatchType);
                                $("#gender").val(data.Gender);
                                $("#trophyType").val(data.TrophyType);
                                $("#startDate").val(data.StartDate?.split('T')[0]);
                                $("#endDate").val(data.EndDate?.split('T')[0]);
                                $("#isActive").val(data.IsActive.toString());
                            }
                        });

                    }
                }
            });

        }
    </script>

</body>
</html>