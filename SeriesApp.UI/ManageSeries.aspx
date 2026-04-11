<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageSeries.aspx.cs" Inherits="SeriesApp.UI.ManageSeries" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Series</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body { font-family: Arial; background-color: #ffffff; }

        h2 {
            background-color: #dcdcdc;
            padding: 10px;
            border: 1px solid #999;
        }

        .search-table {
            border: 1px solid #999;
            background-color: #f5f5f5;
            width: 100%;
        }

        .search-table td { padding: 6px; }

        input, select {
            border: 1px solid #999;
            padding: 3px;
            font-size: 12px;
        }

        .btn-panel { margin-top: 10px; }

        button {
            background-color: #e0e0e0;
            border: 1px solid #999;
            padding: 5px 10px;
            cursor: pointer;
        }

        button:hover { background-color: #cfcfcf; }

        .grid-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 12px;
        }

        .grid-table th {
            background-color: #dcdcdc;
            border: 1px solid #999;
            padding: 5px;
        }

        .grid-table td {
            border: 1px solid #999;
            padding: 5px;
        }
    </style>
</head>

<body>

<h2>Manage Series</h2>

<table class="search-table">
    <tr>
        <td>Series API ID</td>
        <td><input type="number" id="searchApiId" /></td>

        <td>Series Name</td>
        <td><input type="text" id="searchTitle" /></td>

        <td>Series Type</td>
        <td>
            <select id="searchType">
                <option value="">All</option>
                <option>International</option>
                <option>Domestic</option>
                <option>Women</option>
                <option>Mens</option>
            </select>
        </td>
    </tr>

    <tr>
        <td>Series Start From</td>
        <td><input type="date" id="searchStartDate" /></td>

        <td>Series End To</td>
        <td><input type="date" id="searchEndDate" /></td>

        <td>Sort By</td>
        <td>
            <select id="sortBy">
                <option value="">Select</option>
                <option value="asc">Start Date Asc</option>
                <option value="desc">Start Date Desc</option>
            </select>
        </td>
    </tr>
</table>

<div class="btn-panel">
    <button id="btnSearch">Search</button>
    <button id="btnRefresh">Refresh</button>
    <button onclick="window.location.href='AddSeries.aspx'">Add Series</button>
</div>

<table class="grid-table" id="seriesTable">
    <thead>
        <tr>
            <th>Series ID</th>
            <th>API ID</th>
            <th>Series Name</th>
            <th>Year</th>
            <th>Type</th>
            <th>Status</th>
            <th>Format</th>
            <th>Gender</th>
            <th>Start</th>
            <th>End</th>
            <th>Active</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody></tbody>
</table>

<script>
    $(document).ready(function () {

        loadData();

        $("#btnSearch").click(loadData);
        $("#btnRefresh").click(function () {
            location.reload();
        });

        function loadData() {

            $.ajax({
                url: "/api/series/search",
                data: {
                    apiId: $("#searchApiId").val(),
                    title: $("#searchTitle").val(),
                    type: $("#searchType").val(),
                    startDate: $("#searchStartDate").val(),
                    endDate: $("#searchEndDate").val(),
                    sortBy: $("#sortBy").val()
                },
                success: function (data) {

                    let rows = "";

                    $.each(data, function (i, item) {

                        rows += "<tr>";
                        rows += "<td>" + item.SeriesId + "</td>";
                        rows += "<td>" + item.SeriesApiId + "</td>";
                        rows += "<td>" + item.Title + "</td>";
                        rows += "<td>" + item.ReleaseYear + "</td>";
                        rows += "<td>" + item.SeriesType + "</td>";
                        rows += "<td>" + item.SeriesStatus + "</td>";
                        rows += "<td>" + item.MatchFormat + "</td>";
                        rows += "<td>" + item.Gender + "</td>";
                        rows += "<td>" + formatDate(item.StartDate) + "</td>";
                        rows += "<td>" + formatDate(item.EndDate) + "</td>";
                        rows += "<td>" + (item.IsActive ? "Yes" : "No") + "</td>";
                        rows += "<td>";
                        rows += "<button onclick='editSeries(" + item.SeriesId + ")'>Edit</button>";
                        rows += "<button onclick='deleteSeries(" + item.SeriesId + ")'>Delete</button>";
                        rows += "</td>";
                        rows += "</tr>";

                    });

                    $("#seriesTable tbody").html(rows);
                }
            });
        }
    });

    // ✅ FIXED: Edit function
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

    // ✅ FIXED: Delete function
    function deleteSeries(id) {

        if (!confirm("Are you sure you want to delete this record?"))
            return;

        $.ajax({
            url: "/api/series/delete?id=" + id,
            type: "DELETE",
            success: function (res) {
                if (res.success) {
                    alert("Deleted successfully!");
                    location.reload();
                } else {
                    alert(res.message);
                }
            }
        });
    }

    function formatDate(date) {
        return date ? date.split('T')[0] : "";
    }
</script>

</body>
</html>