
//window refresh
$(document).ready(function () {
    $(localStorage.option).attr('class', 'option-active');
    $('#style').scrollTop(localStorage.scrollposition);
    localStorage.scrollposition = "";
    
});

//handle Request button
$('#TERPContentPlaceHolder_btnRequest').click(function () {
    localStorage.option = "#TERPContentPlaceHolder_btnRequest";
});

//handle Task button
$('#TERPContentPlaceHolder_btnTask').click(function () {
    localStorage.option = "#TERPContentPlaceHolder_btnTask";
});


//save position of scrollbar
$('#style').scroll(function () {
    let topScroll = $('#style').scrollTop();
    localStorage.scrollposition = topScroll;
});

