<?php echo $header; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_install) { ?>
  <div class="alert alert-error"><i class="icon-exclamation-sign"></i> <?php echo $error_install; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="box">
    <div class="box-heading">
      <h1><i class="icon-eye-open icon-large"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="box-content">
      <div class="row-fluid">
        
        
        <div class="span3">
          <div class="well well-small">
          
          
          
            <div id="chart-sale" class="chart"></div>
            <div class="detail">
              <h5><?php echo $total_sale; ?></h5>
              <?php echo $text_total_sale; ?></div>
          
          
          </div>
        </div>
        
        
        <div class="span3">
          <div class="well well-small">
            <div id="chart-order" class="chart"></div>
            <div class="detail">
              <h5><?php echo $total_order; ?></h5>
              <?php echo $text_total_order; ?></div>
          </div>
        </div>
        
        <div class="span3">
          <div class="well well-small">
            <div id="chart-customer" class="chart"></div>
            <div class="detail">
              <h5><?php echo $total_customer; ?></h5>
              <?php echo $text_total_customer; ?></div>
          </div>
        </div>
        
        
        <div class="span3">
          <div class="well well-small">
            <div id="chart-online" class="chart"></div>
            <div class="detail">
              <h5><?php echo $total_online; ?></h5>
              <?php echo $text_total_online; ?></div>
          </div>
        </div>
      
      
      
      </div>
      <div class="row-fluid">
        <div class="span12">
          <h2>Statistics
            <div class="btn-group pull-right" data-toggle="buttons-radio">
              <button class="btn active" value="day"><?php echo $text_day; ?></button>
              <button class="btn" value="week"><?php echo $text_week; ?></button>
              <button class="btn" value="month"><?php echo $text_month; ?></button>
              <button class="btn" value="year"><?php echo $text_year; ?></button>
            </div>
          </h2>
        </div>
      </div>
      <div class="row-fluid">
        <div class="span12">
          <div id="report" style="height: 250px; margin-bottom: 20px;"></div>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/jquery/flot/jquery.flot.js"></script> 
<script type="text/javascript" src="view/javascript/jquery/flot/jquery.flot.resize.min.js"></script> 
<script type="text/javascript"><!--
var option = {	
	shadowSize: 0,
	bars: {
		show: true,
		barWidth: 0.9,
		align: 'center',
		lineWidth: 0,
		fill: true,
		fillColor: '#FF0000'
	},
	grid: false,
	xaxis: {
		ticks: false
	},
	yaxis: {
		ticks: false
	}
}

var data = [];

for (var i = 0; i < 5; i++) {
	data.push([i, Math.floor((Math.random() * 100) + 1)]);
}


<?php $sale_data = array(); ?>
<?php foreach ($sales as $key => $value) { ?>
<?php $sale_data[] = '[' . $key . ', ' . $value . ']'; ?>
<?php } ?>


$.plot($('#chart-sale'), [[<?php echo implode(', ', $sale_data); ?>]], option);

var option = {	
	shadowSize: 0,
	bars: {
		show: true,
		barWidth: 0.9,
		align: 'center',
		lineWidth: 0,
		fill: true,
		fillColor: '#0000FF'
	},
	grid: false,
	xaxis: {
		ticks: false
	},
	yaxis: {
		ticks: false
	}
}

var data = [];

for (var i = 0; i < 5; i++) {
	data.push([i, Math.floor((Math.random() * 100) + 1)]);
}
		
$.plot($('#chart-order'), [data], option);

var option = {	
	shadowSize: 0,
	bars: {
		show: true,
		barWidth: 0.9,
		align: 'center',
		lineWidth: 0,
		fill: true,
		fillColor: '#00FF00'
	},
	grid: false,
	xaxis: {
		ticks: false
	},
	yaxis: {
		ticks: false
	}
}

var data = [];

for (var i = 0; i < 5; i++) {
	data.push([i, Math.floor((Math.random() * 100) + 1)]);
}
		
$.plot($('#chart-customer'), [data], option);

var option = {	
	shadowSize: 0,
	bars: {
		show: true,
		barWidth: 0.9,
		align: 'center',
		lineWidth: 0,
		fill: true,
		fillColor: '#FEB900'
	},
	grid: false,
	xaxis: {
		ticks: false
	},
	yaxis: {
		ticks: false
	}
}

var data = [];

for (var i = 0; i < 5; i++) {
	data.push([i, Math.floor((Math.random() * 100) + 1)]);
}
		
$.plot($('#chart-online'), [data], option);

$('.btn-group button').on('click', function() {
	$.ajax({
		type: 'get',
		url: 'index.php?route=common/home/chart&token=<?php echo $token; ?>&range=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('.btn-group button').prop('disabled', true);
		},
		complete: function() {
			$('.btn-group button').prop('disabled', false);
		},		
		success: function(json) {
			var option = {	
				shadowSize: 0,
				lines: { 
					show: true,
					fill: true,
					lineWidth: 1
				},
				grid: {
					backgroundColor: '#FFFFFF',
					hoverable: true,
					clickable: false
				},
				points: {
					show: true				
				},
				colors: ['#8CC7E0', '#2D83A6'],
				xaxis: {
            		ticks: json.xaxis
				}
			}
			
			var plot = $.plot($('#report'), [json.order, json.customer], option);	
					
			$('#report').bind('plothover', function(event, pos, item) {
				$('.tooltip').remove();
			  
				if (item) {
					$('<div id="tooltip" class="tooltip top in"><div class="tooltip-arrow"></div><div class="tooltip-inner">' + item.datapoint[1].toFixed(2) + '</div></div>').appendTo('body');
					
					$('#tooltip').css({
						position: 'absolute',
						left: item.pageX - ($('#tooltip').outerWidth() / 2),
						top: item.pageY - $('#tooltip').outerHeight(),
						pointer: 'cusror'
					}).fadeIn('slow');	
					
					$(plot.getPlaceholder()).css('cursor', 'pointer');		
			  	} else {
					$(plot.getPlaceholder()).css('cursor', 'auto');
				}
			});
		}
	});	
})

$('.btn-group .active').trigger('click');
//--></script> 
<?php echo $footer; ?>