
function getCommitsHistory(start_date, end_date, repo_name) {
	$.ajax({
		url: '/repositories/'+repo_name+'/repo_commits',
		type:'get',
		dataType: 'json',
		data:{
			since_date: start_date,
			until_date: end_date
		},
		beforeSend: function(){
		 	// Show image container
		 	$('#loader').show();
		},
		success: function(data){
			if(data.length == 0){
				$('.err').html('Not found commits between ' + start_date + ' to ' + end_date);
				$('#d3_commits_graph').html('');
			}else{
				$('.err').html('');
				createChart(data);
			}        
		},
		error: function(jqXHR, textStatus, errorThrown){
			// Hide image container
			$("#loader").hide();
		},
		complete:function(data){
			// Hide image container
			$("#loader").hide();
		}        
	});
}
function createChart(response){

	var width = 800,   // width of svg
	height = 400,  // height of svg
	padding = 50; 
	d3.select('svg').remove();

	var response = response
	data = []
	var parseDate = d3.time.format('%d-%b-%y')
	response.forEach(function(d){
		date = new Date(d.committer_date)
		data.push({date:parseDate(date),close: new Date((d.committer_date)).getHours(), commited_by: d.committer_name, message: d.commit_message})
	})

	// Set the dimensions of the canvas / graph
	var margin = {top: 30, right: 50, bottom: 30, left: 50},
			width = 800 - margin.left - margin.right,
			height = 400 - margin.top - margin.bottom;
	// Parse the date / time
	var parseDate = d3.time.format('%d-%b-%y').parse;
	// Set the ranges
	var x = d3.time.scale().range([0, width]);
	var y = d3.scale.linear().range([height, 0]);
	// Define the axes
	var xAxis = d3.svg.axis().scale(x)
			.orient('bottom').ticks(5);
	var yAxis = d3.svg.axis().scale(y)
			.orient('left').ticks(5);
	// Define the line
	var valueline = d3.svg.line()
		.x(function(d) { return x(d.date); })
		.y(function(d) { return y(d.close); });
					
	var toolTip = d3.tip()
		.attr('class', 'd3-tip')
		.offset([-10, 0])
		.html(function (d) {
			var tooltipHTML = "<span class = 'name'>" + "Commited by :- " + d.commited_by + "</span><br/>" + "Commit Message :- " + d.message + "<br/>" +  "On Date :- " + d.date;
			return tooltipHTML;
		});
	// Adds the svg canvas
	var svg = d3.select('#d3_commits_graph')
		.append('svg')
		.attr('width', width + margin.left + margin.right)
		.attr('height', height + margin.top + margin.bottom)
		.append('g')
		.attr('transform', 
		'translate(' + margin.left + ',' + margin.top + ')');

	svg.call(toolTip);
	// Get the data
	data.forEach(function(d) {
		d.date = parseDate(d.date);
		d.close = +d.close;
	});
	// Scale the range of the data
	x.domain(d3.extent(data, function(d) { return d.date; }));
	y.domain([0, d3.max(data, function(d) { return d.close; })]);

	svg.append('text')
		.attr('x', (width / 2))             
		.attr('y', 0 - (margin.top / 2))
		.attr('text-anchor', 'middle')  
		.style('font-size', '20px') 
		.style('text-decoration', 'underline')  
		.text('Commit History Graph');

	// Add the valueline path.
	svg.append('path')
		.attr('class', 'line')
		.attr('d', valueline(data));

	// Add the scatterplot
	svg.selectAll('dot')
		.data(data)
		.enter().append('circle')
		.attr('r', 3.5)
		.attr('cx', function(d) { return x(d.date); })
		.attr('cy', function(d) { return y(d.close); })
		.text(function(d){return d.commited_by;})
		.on('mouseover', toolTip.show)
		.on('mouseout', toolTip.hide);

	// Add the X Axis
	svg.append('g')
		.attr('class', 'x axis')
		.attr('transform', 'translate(0,' + height + ')')
		.call(xAxis);

	// Add the Y Axis
	svg.append('g')
		.attr('class', 'y axis')
		.call(yAxis);

	svg.append('text')
		.attr('text-anchor', 'middle')  // this makes it easy to centre the text as the transform is applied to the anchor
		.attr('transform', 'translate('+ (padding/2) +','+(height/2)+')rotate(-90)')  // text is drawn off the screen top left, move down and out and rotate
		.text('Time');

	svg.append('text')
		.attr('text-anchor', 'middle')  // this makes it easy to centre the text as the transform is applied to the anchor
		.attr('transform', 'translate('+ (width/2) +','+(height-(padding/3))+')')  // centre below axis
		.text('Date');
}