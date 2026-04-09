<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageSeries.aspx.cs" Inherits="SeriesApp.UI.ManageSeries" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Series</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            font-size: 12px;
        }

        th, td {
            border: 1px solid black;
            padding: 5px;
            text-align: center;
        }

        th {
            background-color: #eee;
        }

        .table-container {
            overflow-x: auto;
        }
    </style>
</head>

<body>

    <h2>Manage Series</h2>

    <div>
        <label>Title:</label>
        <input type="text" id="searchTitle" />

        <label>Year:</label>
        <input type="number" id="searchYear" />

        <button id="btnSearch">Search</button>
    </div>

    <br />

    <div class="table-container">
        <table id="seriesTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>API ID</th>
                    <th>Title</th>
                    <th>Year</th>
                    <th>Type</th>
                    <th>Series Status</th>
                    <th>Match Status</th>
                    <th>Format</th>
                    <th>Match Type</th>
                    <th>Gender</th>
                    <th>Trophy</th>
                    <th>Start</th>
                    <th>End</th>
                    <th>Active</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

    <script>
        $(document).ready(function () {

            loadData();

            $("#btnSearch").click(function () {
                loadData();
            });

            function loadData() {

                var title = $("#searchTitle").val();
                var year = $("#searchYear").val();

                $.ajax({
                    url: "/api/series/search?title=" + title + "&releaseYear=" + year,
                    type: "GET",
                    success: function (data) {

                        var rows = "";

                        $.each(data, function (i, item) {

                            rows += "<tr>";
                            rows += "<td>" + item.SeriesId + "</td>";
                            rows += "<td>" + item.SeriesApiId + "</td>";
                            rows += "<td>" + item.Title + "</td>";
                            rows += "<td>" + item.ReleaseYear + "</td>";
                            rows += "<td>" + item.SeriesType + "</td>";
                            rows += "<td>" + item.SeriesStatus + "</td>";
                            rows += "<td>" + item.MatchStatus + "</td>";
                            rows += "<td>" + item.MatchFormat + "</td>";
                            rows += "<td>" + item.SeriesMatchType + "</td>";
                            rows += "<td>" + item.Gender + "</td>";
                            rows += "<td>" + item.TrophyType + "</td>";
                            rows += "<td>" + formatDate(item.StartDate) + "</td>";
                            rows += "<td>" + formatDate(item.EndDate) + "</td>";
                            rows += "<td>" + (item.IsActive ? "Yes" : "No") + "</td>";
                            rows += "<td>" + item.Description + "</td>";
                            rows += "<td><button onclick='editSeries(" + item.SeriesId + ")'>Edit</button></td>";
                            rows += "</tr>";

                        });

                        $("#seriesTable tbody").html(rows);
                    }
                });
            }

        });

        function formatDate(date) {
            if (!date) return "";
            return date.split('T')[0];
        }

        function editSeries(id) {

            var query = "Mode=E&Sid=" + id;

            $.ajax({
                url: "/api/series/encrypt?q=" + query,
                type: "GET",
                success: function (res) {
                    window.location.href = "AddSeries.aspx?q=" + encodeURIComponent(res);
                }
            });
        }
    </script>

</body>
</html>