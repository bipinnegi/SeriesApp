<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddSeries.aspx.cs" Inherits="SeriesApp.UI.AddSeries" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Series</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body { font-family: Arial; background-color: #ffffff; }

        h2 {
            background-color: #dcdcdc;
            padding: 10px;
            border: 1px solid #999;
        }

        .form-table {
            width: 100%;
            border: 1px solid #999;
            background-color: #f5f5f5;
        }

        .form-table td { padding: 6px; }

        input, select, textarea {
            border: 1px solid #999;
            padding: 4px;
            font-size: 12px;
            width: 95%;
        }

        textarea { height: 60px; }

        .error { color: red; font-size: 11px; }

        .btn-panel { margin-top: 10px; }

        button {
            background-color: #e0e0e0;
            border: 1px solid #999;
            padding: 5px 10px;
            cursor: pointer;
        }

        button:hover { background-color: #cfcfcf; }
    </style>
</head>

<body>

<h2>Add / Edit Series</h2>

<input type="hidden" id="seriesId" value="0" />

<table class="form-table">

    <tr>
        <td>Series Name</td>
        <td>
            <input type="text" id="title" />
            <div class="error" id="errTitle"></div>
        </td>

        <td>Series API ID</td>
        <td>
            <input type="number" id="seriesApiId" />
            <div class="error" id="errApiId"></div>
        </td>
    </tr>

    <tr>
        <td>Series Type</td>
        <td>
            <select id="seriesType"></select>
            <div class="error" id="errType"></div>
        </td>

        <td>Series Status</td>
        <td>
            <select id="seriesStatus"></select>
            <div class="error" id="errStatus"></div>
        </td>
    </tr>

    <tr>
        <td>Match Status</td>
        <td><select id="matchStatus"></select></td>

        <td>Match Format</td>
        <td><select id="matchFormat"></select></td>
    </tr>

    <tr>
        <td>Series Match Type</td>
        <td><select id="seriesMatchType"></select></td>

        <td>Gender</td>
        <td>
            <select id="gender"></select>
            <div class="error" id="errGender"></div>
        </td>
    </tr>

    <tr>
        <td>Year</td>
        <td>
            <input type="number" id="releaseYear" />
            <div class="error" id="errYear"></div>
        </td>

        <td>Trophy Type</td>
        <td>
            <input type="text" id="trophyType" />
            <div class="error" id="errTrophy"></div>
        </td>
    </tr>

    <tr>
        <td>Start Date</td>
        <td>
            <input type="date" id="startDate" />
            <div class="error" id="errStart"></div>
        </td>

        <td>End Date</td>
        <td>
            <input type="date" id="endDate" />
            <div class="error" id="errEnd"></div>
        </td>
    </tr>

    <tr>
        <td>Is Active</td>
        <td>
            <select id="isActive">
                <option value="">Select</option>
                <option value="true">Yes</option>
                <option value="false">No</option>
            </select>
            <div class="error" id="errActive"></div>
        </td>

        <td>Description</td>
        <td>
            <textarea id="description"></textarea>
        </td>
    </tr>

</table>

<div class="btn-panel">
    <button id="btnSave">Save</button>
    <button id="btnCancel">Cancel</button>
</div>

<script>
    $(document).ready(function () {

        loadDropdowns();
        loadEditData(); // ✅ now exists

        $("#btnCancel").click(function () {
            window.location.href = "ManageSeries.aspx";
        });

        $("#btnSave").click(function () {

            if (!validateForm()) return;

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
            if (series.SeriesId > 0) url = "/api/series/update";

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
                        alert("Error: " + response.message);
                    }
                }
            });
        });
    });

    function validateForm() {

        $(".error").text("");
        let isValid = true;

        if (!$("#title").val()) { $("#errTitle").text("Required"); isValid = false; }
        if (!$("#seriesApiId").val()) { $("#errApiId").text("Required"); isValid = false; }
        if (!$("#seriesType").val()) { $("#errType").text("Required"); isValid = false; }
        if (!$("#seriesStatus").val()) { $("#errStatus").text("Required"); isValid = false; }
        if (!$("#gender").val()) { $("#errGender").text("Required"); isValid = false; }
        if (!$("#releaseYear").val()) { $("#errYear").text("Required"); isValid = false; }
        if (!$("#trophyType").val()) { $("#errTrophy").text("Required"); isValid = false; }
        if (!$("#startDate").val()) { $("#errStart").text("Required"); isValid = false; }
        if (!$("#endDate").val()) { $("#errEnd").text("Required"); isValid = false; }
        if (!$("#isActive").val()) { $("#errActive").text("Required"); isValid = false; }

        return isValid;
    }

    function loadDropdowns() {
        $("#seriesType").html("<option value=''>Select</option><option>International</option><option>Domestic</option>");
        $("#seriesStatus").html("<option value=''>Select</option><option>Scheduled</option><option>Completed</option>");
        $("#matchStatus").html("<option>Scheduled</option><option>Completed</option>");
        $("#matchFormat").html("<option>ODI</option><option>T20</option>");
        $("#seriesMatchType").html("<option>ODI</option><option>T20</option>");
        $("#gender").html("<option value=''>Select</option><option>Mens</option><option>Womens</option>");
    }

    function loadEditData() {

        var params = new URLSearchParams(window.location.search);
        var encrypted = params.get("q");

        if (!encrypted) return;

        $.ajax({
            url: "/api/series/decrypt?q=" + encrypted,
            type: "GET",
            success: function (res) {

                var parts = new URLSearchParams(res);
                var id = parts.get("Sid");

                $("#seriesId").val(id);

                $.ajax({
                    url: "/api/series/getbyid?id=" + id,
                    type: "GET",
                    success: function (data) {

                        $("#title").val(data.Title);
                        $("#seriesApiId").val(data.SeriesApiId);
                        $("#seriesType").val(data.SeriesType);
                        $("#seriesStatus").val(data.SeriesStatus);
                        $("#gender").val(data.Gender);
                        $("#releaseYear").val(data.ReleaseYear);
                        $("#trophyType").val(data.TrophyType);
                        $("#startDate").val(data.StartDate?.split('T')[0]);
                        $("#endDate").val(data.EndDate?.split('T')[0]);
                        $("#isActive").val(data.IsActive.toString());
                        $("#description").val(data.Description);
                    }
                });
            }
        });
    }
</script>

</body>
</html>