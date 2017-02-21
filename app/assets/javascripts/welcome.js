$(document).ready(function(){

    $('#country_name').change(function(){
        $.ajax({
            url: '/welcome/get-cities',
            type: 'POST',
            beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            data: {
                country_name: $(this).val()
            },
            success: function(response) {
                $('#select_city_block').html(response);
            }
        });
        $('#weather_result').html('');
    });

    $('body').on('click','#get_weather', function(){
        $.ajax({
            url: '/welcome/get-weather',
            type: 'POST',
            beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            data: {
                country_name: $('#country_name').val(),
                city_name: $('#city_name').val(),
            },
            success: function(response) {
                $('#weather_result').html(response);
            }
        });
    });
});
