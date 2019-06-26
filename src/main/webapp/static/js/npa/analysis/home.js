$(function() {
  $.getJSON("loancontractAnalysis.do?orgAmountData", function(json) {
    createChart1('chart1', json);
  });

  $.getJSON("loancontractAnalysis.do?orgBorrowerData", function(json) {
    createChart2('chart2', json);
  });

  $.getJSON("loancontractAnalysis.do?orgErrorData", function(json) {
    createChart3('chart3', json);
  });
});

function createChart1(id, json) {
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

function createChart2(id, json) {
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
      left: 'center'
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
}

function createChart3(id, json) {
  var echartsWarp = document.getElementById(id);
  var myChart = echarts.init(echartsWarp);

  var orgs = new Array();
  var v1 = new Array();
  var v2 = new Array();
  $.each(json, function(i, n) {
    orgs.push(n.orgName);
    v1.push(n.v2);
    v2.push(n.v3);
  });

  option = {
    tooltip: {
      trigger: 'axis',
      axisPointer: { // 坐标轴指示器，坐标轴触发有效
        type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
      }
    },
    legend: {
      data: ['修改完成错误合同', '未修改错误合同']
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
      name: '修改完成错误合同',
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
      name: '未修改错误合同',
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

function keyValueItem(name, value) {
  this.name = name;
  this.value = value;
}