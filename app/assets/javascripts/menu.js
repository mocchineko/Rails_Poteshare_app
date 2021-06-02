$(function () {

    $(".nav-trigger").click(function () {
        $(this).next().slideToggle();
    }).next().hide();

});