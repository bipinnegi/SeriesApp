<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="SeriesApp.UI.Report" %>

<!DOCTYPE html>
<html>
<head>
    <title>Series Report</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body { font-family: Arial; }

        h2 {
            background-color: #dcdcdc;
            padding: 10px;
            border: 1px solid #999;
        }

        .box {
            border: 1px solid #999;
            background-color: #f5f5f5;
            padding: 10px;
            width: 300px;
        }

        .grid-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .grid-table th, .grid-table td {
            border: 1px solid #999;
            padding: 6px;
            text-align: center;
        }

        .year-header {
            background-color: olive;
            color: white;
        }

        .sub-header {
            background-color: #4a6c8c;
            color: white;
        }

        .total-row {
            background-color: green;
            color: white;
            font-weight: bold;
        }
    </style>
</head>

<body>

<h2>Series Report</h2>

<div class="box">
    <b>Select Years</b><br/><br/>
    <div id="yearList"></div>
</div>

<br/>
<button id="btnReport">Generate Report</button>

<table class="grid-table" id="reportTable"></table>

<script>
    $(document).ready(function () {

        loadYears();

        $("#btnReport").click(function () {

            var selectedYears = [];

            $("input[name='year']:checked").each(function () {
                selectedYears.push($(this).val());
            });

            if (selectedYears.length === 0) {
                alert("Select year");
                return;
            }

            $.ajax({
                url: "/api/series/search",
                success: function (data) {

                    // FILTER
                    data = data.filter(x => selectedYears.includes(x.ReleaseYear.toString()));

                    var formats = ["ODI", "TEST", "T20", "T10"];
                    var genders = ["Mens", "Womens", "Other"];

                    var html = "";

                    // HEADER ROW 1
                    html += "<tr><th rowspan='2'>Match Format</th>";
                    selectedYears.forEach((y, i) => {
                        html += "<th class='year-header' colspan='3'>Year " + (i + 1) + "</th>";
                    });
                    html += "</tr>";

                    // HEADER ROW 2
                    html += "<tr>";
                    selectedYears.forEach(() => {
                        html += "<th class='sub-header'>Men</th><th class='sub-header'>Women</th><th class='sub-header'>Other</th>";
                    });
                    html += "</tr>";

                    // DATA ROWS
                    formats.forEach(format => {

                        html += "<tr>";
                        html += "<td>" + format + "</td>";

                        selectedYears.forEach(year => {

                            var men = data.filter(x => x.ReleaseYear == year && x.MatchFormat == format && x.Gender == "Mens").length;
                            var women = data.filter(x => x.ReleaseYear == year && x.MatchFormat == format && x.Gender == "Womens").length;
                            var other = data.filter(x => x.ReleaseYear == year && x.MatchFormat == format && x.Gender == "Other").length;

                            html += "<td>" + men + "</td>";
                            html += "<td>" + women + "</td>";
                            html += "<td>" + other + "</td>";
                        });

                        html += "</tr>";
                    });

                    // TOTAL ROW
                    html += "<tr class='total-row'><td>Total</td>";

                    selectedYears.forEach(year => {

                        var men = data.filter(x => x.ReleaseYear == year && x.Gender == "Mens").length;
                        var women = data.filter(x => x.ReleaseYear == year && x.Gender == "Womens").length;
                        var other = data.filter(x => x.ReleaseYear == year && x.Gender == "Other").length;

                        html += "<td>" + men + "</td>";
                        html += "<td>" + women + "</td>";
                        html += "<td>" + other + "</td>";
                    });

                    html += "</tr>";

                    $("#reportTable").html(html);
                }
            });

        });

        function loadYears() {

            $.ajax({
                url: "/api/series/search",
                success: function (data) {

                    var years = [...new Set(data.map(x => x.ReleaseYear))];

                    var html = "";
                    years.forEach(y => {
                        html += "<input type='checkbox' name='year' value='" + y + "' /> " + y + "<br/>";
                    });

                    $("#yearList").html(html);
                }
            });
        }

    });
</script>

</body>
</html>