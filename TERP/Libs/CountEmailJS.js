
$(function () {
    var ajaxcall = function () {
        $.ajax({
            type: "POST",
            url: "/TERP/CountEmailWs.asmx/CountEmail",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                clearInterval(interval);
            },
            success: function (result) {
                if (result.d == 0) {
                    $('#lbMailNotic').css("opacity", "0");
                }
                else if (result.d > 9) {
                    $('#lbMailNotic').css("opacity", "1");
                    $('#lbMailNotic').html("9+");
                }
                else {
                    $('#lbMailNotic').css("opacity", "1");
                    $('#lbMailNotic').html(result.d);
                }
            }
        })
    };
    var interval = setInterval(ajaxcall, 1000);
})