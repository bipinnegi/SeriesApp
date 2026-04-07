<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddSeries.aspx.cs" Inherits="SeriesApp.UI.AddSeries" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Series</title>

    <!-- jQuery CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

    <h2>Add / Edit Series</h2>

    <input type="hidden" id="seriesId" value="0" />

    <div>
        <label>Title:</label>
        <input type="text" id="title" />
    </div>

    <div>
        <label>Description:</label>
        <input type="text" id="description" />
    </div>

    <div>
        <label>Release Year:</label>
        <input type="number" id="releaseYear" />
    </div>

    <div>
        <label>Genre:</label>
        <input type="text" id="genre" />
    </div>

    <br />

    <button id="btnSave">Save</button>


    <script>
    $(document).ready(function () {

        $("#btnSave").click(function () {

            var series = {
                SeriesId: $("#seriesId").val(),
                Title: $("#title").val(),
                Description: $("#description").val(),
                ReleaseYear: $("#releaseYear").val(),
                Genre: $("#genre").val()
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
                },
                error: function () {
                    alert("Error occurred");
                }
            });

        });

    });
    </script>

</body>
</html>