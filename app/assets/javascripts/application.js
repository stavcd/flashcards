// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

jQuery(function ($) {
    $('#crop_image').Jcrop(
        {
            onSelect: writeCoordinates,
            boxWidth: 500,
            aspectRatio: 1,
            minSize: [50, 50],
            setSelect: [0, 0, 50, 50]
        }
    );

    function writeCoordinates(c) {

        $('#card_image_crop_data_x').val(c.x)
        $('#card_image_crop_data_y').val(c.y)
        $('#card_image_crop_data_width').val(c.w)
        $('#card_image_crop_data_height').val(c.h)

    }
});