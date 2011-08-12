var preview;

var s;
var a, b;

var data = {};

$(function() {
	preview = $('.preview');
	
	cr = $('#cropbox').Jcrop({
		onChange: update_crop,
		onSelect: update_crop,
		setSelect: [0, 0, 500, 500],
		aspectRatio: 1
	});
  
	$('#links').find('a').click(function() {
		
		s = $(this).text();
		
		var dims = $(this).text().split('х');
		
		a = parseInt(dims[0]);
		b = parseInt(dims[1]);
		
		$('#cropbox').Jcrop({
			aspectRatio: a / b
		}).change();
		
		$("#resolution").val(s);
	});
	$("#resolution").val($('#links').find('a').first().text());
	
	
	$('#user_submit').click(function(event) {
		
		console.log($('#user_edit').attr('action'));
		
		$.post($('#user_edit').attr('action'), $('#user_edit').serialize(), function(data) {
			console.log(data);
		});
		
		console.log('dd');
		event.preventDefault();
		return false;
	});
});

function update_crop(coords) {
	console.log('updating');

    var rx = preview.width() / coords.w;
    var ry = preview.height() / coords.h;
    
    var lw = $('#cropbox').width();
    var lh = $('#cropbox').height();
    var ratio = 1;
    
    $('.preview').css({
    	width: a,
    	height: b
    });
    
	$('#preview').css({
		width: Math.round(rx * lw) + 'px',
		height: Math.round(ry * lh) + 'px',
		marginLeft: '-' + Math.round(rx * coords.x) + 'px',
		marginTop: '-' + Math.round(ry * coords.y) + 'px'
	});

	$("#crop_x").val(Math.round(coords.x * ratio));
	$("#crop_y").val(Math.round(coords.y * ratio));
	$("#crop_w").val(Math.round(coords.w * ratio));
	$("#crop_h").val(Math.round(coords.h * ratio));
}