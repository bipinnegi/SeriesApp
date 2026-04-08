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

            loadEditData();

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

                    // res = "Mode=E&Sid=1"
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
                                $("#genre").val(data.Genre);
                            }
                        });

                    }
                }
            });

        }
    </script>

</body>
</html>