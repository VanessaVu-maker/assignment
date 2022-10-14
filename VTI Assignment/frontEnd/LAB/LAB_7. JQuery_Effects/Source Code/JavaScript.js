$(document).ready(function() {
    $(".btn_An_1").click(function() {
        $(".content1").fadeOut();
        $(".btn_An_1").hide();
        $(".btn_Xemthem_1").show();
    });
    $(".btn_Xemthem_1").click(function() {
        $(".content1").fadeIn();
        $(".btn_An_1").show();
        $(".btn_Xemthem_1").hide();
    });

    $(".btn_An_2").click(function() {
        $(".content2").fadeOut();
        $(".btn_An_2").hide();
        $(".btn_Xemthem_2").show();
    });
    $(".btn_Xemthem_2").click(function() {
        $(".content2").fadeIn();
        $(".btn_An_2").show();
        $(".btn_Xemthem_2").hide();
    });

    $(".btn_An_3").click(function() {
        $(".content3").fadeOut();
        $(".btn_An_3").hide();
        $(".btn_Xemthem_3").show();
    });
    $(".btn_Xemthem_3").click(function() {
        $(".content3").fadeIn();
        $(".btn_An_3").show();
        $(".btn_Xemthem_3").hide();
    });

    $(".btn_An_4").click(function() {
        $(".content4").fadeOut();
        $(".btn_An_4").hide();
        $(".btn_Xemthem_4").show();
    });
    $(".btn_Xemthem_4").click(function() {
        $(".content4").fadeIn();
        $(".btn_An_4").show();
        $(".btn_Xemthem_4").hide();
    });

});