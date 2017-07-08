$(function() {
  $('head').append('<style class="pie-chart-css"></style>');
  var pieChartCss = $('.pie-chart-css'),
      pieSize = 200,
      pieSizeHalf = pieSize / 2;

  // pie chartのborder-radius
  pieChartCss.append('#js-pie-chart { ' +
                        'position: relative; ' +
                        'width: ' + pieSize + 'px; ' +
                        'height: ' + pieSize + 'px; ' +
                        '}');
  
  pieChartCss.append('.pie:before { ' +
                        'border-radius: ' + pieSizeHalf + 'px 0 0 ' + pieSizeHalf + 'px; ' +
                        '}' +
                        '.pie.large:after { ' +
                        'border-radius: 0 ' + pieSizeHalf + 'px ' + pieSizeHalf + 'px 0; ' + 
                        '}');

  // pie chartの初めの角度
  var startDeg = 0;

  $('.pie').each(function(i) {
    var $this = $(this),
        value = $this.attr('data-percentage'),  // 各pie chart部分のパーセンテージ
        valueDeg = value * 3.6,                 // 各pie chart部分の角度(100%で360度のため1%は3.6度)
        pieColor = $this.attr('data-color'),    // 各pie chart部分の色
        selector = '',
        cssText = '';
    
    // pie chartが50%より大きい場合にクラスを追加
    if (value > 50) $this.addClass('large');
    
    // pie chartの数だけセレクタをつないでいく
    selector += '.pie';
    for (var j = 1; j <= i; ++j) selector += ' + .pie';

    // startDeg
    cssText += selector;
    cssText += ' { ' +
                '-webkit-transform: rotate(' + startDeg + 'deg); ' +
                '-moz-transform: rotate(' + startDeg + 'deg); ' +
                '-ms-transform: rotate(' + startDeg + 'deg); ' +
                'transform: rotate(' + startDeg + 'deg); } ';
    
    // valueDeg
    cssText += selector;
    cssText += ':before { ' +
                '-webkit-transform: rotate(' + valueDeg + 'deg); ' +
                '-moz-transform: rotate(' + valueDeg + 'deg); ' +
                '-ms-transform: rotate(' + valueDeg + 'deg); ' +
                'transform: rotate(' + valueDeg + 'deg); } ';
    
    // pieColor
    cssText += selector + ':before, ' + selector + ':after {' +
                'background-color: ' + pieColor + '; }';
    
    // CSSを追加
    pieChartCss.append(cssText);
    // スタート角度を更新
    startDeg += valueDeg;
  });

});
