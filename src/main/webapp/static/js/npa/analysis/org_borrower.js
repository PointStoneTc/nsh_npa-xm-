$(function() {
  $.getJSON("loancontractAnalysis.do?orgBorrowerData", function(json) {
    createChart('chart', json);
  });
});

function createChart(id, json) {
  var echartsWarp = document.getElementById(id);
  var myChart = echarts.init(echartsWarp);

  var v = new Array();
  $.each(json, function(i, n) {
    var item = new keyValueItem(n.orgName, n.ct);
    v.push(item);

  });

  option = {
    title: {
      text: '借款人占比',
      left: 'center',
      textStyle: {
        color: '#000000'
      }
    },
    tooltip: {
      trigger: 'item',
      formatter: "{c}人 ({d}%)"
    },
    series: [{
      type: 'pie',
      radius: ['50%', '70%'],
      avoidLabelOverlap: false,
      center: ['50%', '50%'],
      data: v.sort(function(a, b) {
        return a.value - b.value;
      }),
      roseType: 'radius',
      label: {
        normal: {
          textStyle: {
            color: 'rgba(0, 0, 0, 0.7)'
          }
        }
      },
      labelLine: {
        normal: {
          lineStyle: {
            color: 'rgba(0, 0, 0, 0.7)'
          },
          smooth: 0.2,
          length: 10,
          length2: 20
        }
      },
      animationType: 'scale',
      animationEasing: 'elasticOut',
      animationDelay: function(idx) {
        return Math.random() * 200;
      }
    }]
  };

  myChart.setOption(option);
  console.info(2);
}

function keyValueItem(name, value) {
  this.name = name;
  this.value = value;
}