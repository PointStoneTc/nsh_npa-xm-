$(function() {
  $.getJSON("loancontractAnalysis.do?orgAmountData", function(json) {
    createChart('chart', json);
  });
});

function createChart(id, json) {
  var echartsWarp = document.getElementById(id);
  var myChart = echarts.init(echartsWarp);

  var orgs = new Array();
  var v1 = new Array();
  var v2 = new Array();
  $.each(json, function(i, n) {
    orgs.push(n.orgName);
    v1.push(n.v1);
    v2.push(n.v2);
  });

  option = {
    tooltip: {
      trigger: 'axis',
      axisPointer: { // 坐标轴指示器，坐标轴触发有效
        type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
      }
    },
    legend: {
      data: ['收回本金', '剩余本金']
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      containLabel: true
    },
    xAxis: {
      type: 'value'
    },
    yAxis: {
      type: 'category',
      data: orgs
    },
    series: [{
      name: '收回本金',
      type: 'bar',
      stack: '总量',
      label: {
        normal: {
          show: true,
          position: 'inside'
        }
      },
      data: v1
    }, {
      name: '剩余本金',
      type: 'bar',
      stack: '总量',
      label: {
        normal: {
          show: true,
          position: 'inside'
        }
      },
      data: v2
    }]
  };

  myChart.setOption(option);
}