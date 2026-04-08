<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageSeries.aspx.cs" Inherits="SeriesApp.UI.ManageSeries" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Series</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

    <table border="1" id="seriesTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Description</th>
                <th>Year</th>
                <th>Genre</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>



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
                        rows += "<td>" + item.Title + "</td>";
                        rows += "<td>" + item.Description + "</td>";
                        rows += "<td>" + item.ReleaseYear + "</td>";
                        rows += "<td>" + item.Genre + "</td>";
                        rows += "<td><button onclick='editSeries(" + item.SeriesId + ")'>Edit</button></td>";
                        rows += "</tr>";

                    });

                    $("#seriesTable tbody").html(rows);
                }
            });
        }

    });

    function editSeries(id) {
        window.location.href = "AddSeries.aspx?mode=E&id=" + id;
    }
    </script>
</body>
</html>