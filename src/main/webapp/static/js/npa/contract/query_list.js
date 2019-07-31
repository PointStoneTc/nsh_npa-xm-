var datagridId = "queryList";
var isFirstQuery = true;
var map_f; // 存储已经找到的所有人;
var map_nf; // 存储没有找到的所有人;
var userName_bak, idNumber_bak;

$(function() {
    map_f = new Map();
    map_nf = new Map();

    $('#' + datagridId)
        .datagrid(
            {
                rownumbers: true,
                singleSelect: false,
                fitColumns: true,
                striped: true,
                checkOnSelect: true,
                url: 'query.do?datagrid&field=id,numCode,customerNo,louNo,borrowerName,idNumber,guaranteesName,guaranteesIdNumber,amount,amountSurplus,oInterestRate,issueDate,dueDate,interestDate,adjustInterestRate,officer,corporateOrgName,hangInteres,litigationStat,guaranteeMode,disposeMode,stat',
                method: 'post',
                toolbar: '#tb',
                onLoadSuccess: function(data){
                   if(!isFirstQuery)
                       alert('查询完毕,共计查到:' + data.total + '条数据!');
                }
            });

    doPrintListClear();
});

/**
 * 刷新列表
 * 
 * @returns
 */
function reloadTable() {
    $('#' + datagridId).datagrid('reload');
}

/**
 * 查询
 * 
 * @returns
 */
function doQuery() {
    if ($('#userName').val() == '' && $('#idNumber').val() == '') {
        tip('请输入查询条件!');
        return false;
    }

    if ($('#idNumber').val() != '') {
        var id_s = $('#idNumber').val().split(',');
        for (var i = 0; i < id_s.length; i++) {
            if (!validateIdNumber(id_s[i])) {
                tip('身份证号码:' + id_s[i] + '格式错误!');
                return false;
            }
        }
    }

    if ($('#userName').val() != '' && $('#idNumber').val() != '') {
        if ($('#userName').val().indexOf(',') > -1 || $('#idNumber').val().indexOf(',') > -1) {
            tip('多人查询,只允许输入一个条件!');
            return false;
        }
    }

    $('#' + datagridId).datagrid('load', {
        userName: $('#userName').val(),
        idNumber: $('#idNumber').val()
    });

    userName_bak = $('#userName').val();
    idNumber_bak = $('#idNumber').val();

    $('#printList').linkbutton('enable');
    
    isFirstQuery = false;
}

/**
 * 清空
 * 
 * @returns
 */
function doClear() {
    $('#userName').textbox('clear');
    $('#idNumber').textbox('clear');
    clearVarBak();
}

/**
 * 添加到打印清单
 * 
 * @returns
 */
function doPrintList() {
    if (map_f.size() + map_nf.size() > 10) {
        tip('打印区域最多10条数据!');
        return false;
    }

    var html = '';
    // 判断是否查询到了数据
    if ($('#' + datagridId).datagrid('getRows') == 0) { // 一条数据都没有找到
        var array_temp = arrayUser();
        $.each(array_temp, function(i, n) {
            if (map_nf.containsKey(n)) return false;
            map_nf.put(n, n);
            html += '<li><a class="delbtn" onclick="delItem(map_nf, \'' + n + '\', this)"></a><div class="oneItem">' + n + '</div></li>';
        });
        $('#notFindexportList').append(html);

        btnSetEffect();
        return true;
    }

    var rows = $('#' + datagridId).datagrid('getSelections');
    // 1.判断是否选择了数据
    if (rows.length == 0) {
        tip('请先选择数据!');
        return false;
    }

    // 2.往缓存里增加数据,并追加到已经找到的ul里
    $.each(rows, function(i, n) {
        if (!map_f.containsKey(n.id)) {
            map_f.put(n.id, n);
            html += '<li><a class="delbtn" onclick="delItem(map_f, ' + n.id + ', this)"></a>';
            html += '<div><h3>档案编号 [' + n.numCode + '] </h3></div>';
            html += '<div><label class="title">客户号</label><span class="ct">' + n.customerNo + '</span></div>';
            html += '<div><label class="title">借据号</label><span class="ct">' + n.louNo + '</span></div>';
            html += '<div><label class="title">借款人</label><span class="ct">' + n.borrowerName + '(' + n.idNumber + ')</span></div>';
            html += dbr(n.guaranteesName, n.guaranteesIdNumber);
            html += '<div><label class="title">原贷金额</label><span class="ct rmb">' + formatNull(n.amount, null) + '</span></div>';
            html += '<div><label class="title">原贷利率(‰)</label><span class="ct">' + n.oInterestRate + '</span></div>';
            html += '<div><label class="title">贷款发放日</label><span class="ct">' + n.issueDate + '</span></div>';
            html += '<div><label class="title">贷款到期日</label><span>' + n.dueDate + '</span></div>';
            html += '<div><label class="title">信贷员</label><span class="ct">' + n.officer + '</span></div>';
            html += '<div><label class="title">所属支行</label><span class="ct">' + n.corporateOrgName + '</span></div>';
            html += '<div><label class="title">诉讼状态</label><span class="ct">' + lgst(n.litigationStat) + '</span></div>';
            html += '<div><label class="title">担保方式</label><span class="ct">' + dbfs(n.guaranteeMode) + '</span></div>';
            html += '<div><label class="title">处理方式</label><span class="ct">' + clfs(n.disposeMode) + '</span></div>';
            html += '</li>';
        }
    });
    $('#findExportList').append(html);

    // 3.往缓存里增加数据,并追加到未找到已经找到的ul里
    html = '';
    var array_temp = arrayUser();
    if (array_temp.length > 1) { // 只有一条数据的情况下,一定在找到的列表中
        $.each(array_temp, function(i, n) {
            var isNotFind = true;
            $.each(rows, function(index, dom) {
                if (n == dom.borrowerName || n == dom.idNumber) {
                    isNotFind = false;
                    return false;
                }

                var n_s = dom.guaranteesName.split(',');
                for (var x = 0; x < n_s.length; x++) {
                    if (n == n_s[x]) {
                        isNotFind = false;
                        return false;
                    }
                }

                var i_s = dom.guaranteesIdNumber.split(',');
                for (var x = 0; x < i_s.length; x++) {
                    if (n == i_s[x]) {
                        isNotFind = false;
                        return false;
                    }
                }
            });

            if (isNotFind && !map_nf.containsKey(n)) {
                map_nf.put(n, n);
                html += '<li><a class="delbtn" onclick="delItem(map_nf, \'' + n + '\', this)"></a><div class="oneItem">' + n + '</div></li>';
            }
        });

        $('#notFindexportList').append(html);
    }

    btnSetEffect();
}

/**
 * 清空打印区域
 * 
 * @returns
 */
function doPrintListClear() {
    map_f.clear();
    map_nf.clear();
    $('#printList').linkbutton('disable');
    $('#printListClear').linkbutton('disable');
    $('#save').linkbutton('disable');
    $('#findExportList').empty();
    $('#notFindexportList').empty();
}

/**
 * 保存文件
 * 
 * @returns
 */
function saveFile() {
    var url = 'query.do?savePdf';
    var form = $('<form></form>').attr('action', url).attr('method', 'post');
    form.append($('<input></input>').attr('type', 'hidden').attr('name', 'list').attr('value', map_f.keys().join()));
    form.append($('<input></input>').attr('type', 'hidden').attr('name', 'nfParam').attr('value', map_nf.keys().join()));
    form.appendTo('body').submit().remove();
}

/**
 * 设置功能按钮生、失效
 * 
 * @returns
 */
function btnSetEffect() {
    $('#printList').linkbutton('disable');
    $('#save').linkbutton('enable');
    $('#printListClear').linkbutton('enable');
    clearVarBak();
}

/**
 * 情况临时查询数据的参数
 * 
 * @returns
 */
function clearVarBak() {
    userName_bak = '';
    idNumber_bak = '';
}

/**
 * 把查询条件变成数组
 * 
 * @returns
 */
function arrayUser() {
    var array_temp = new Array();

    if (userName_bak != '' && idNumber_bak != '') { // 姓名和身份证联合查询
        array_temp.push(userName_bak + ':' + idNumber_bak);
    } else {
        if (userName_bak != '') {
            var name_splits = userName_bak.split(',');
            $.each(name_splits, function(i, n) {
                array_temp.push(n);
            });
        }

        if (idNumber_bak != '') {
            var idNumber_splits = idNumber_bak.split(',');
            $.each(idNumber_splits, function(i, n) {
                array_temp.push(n);
            });
        }
    }

    return array_temp;
}

/**
 * @param names
 * @param idNumbers
 * @returns
 */
function dbr(names, idNumbers) {
    if (names == '' || idNumbers == '') return '';

    var name_splits = names.split(',');
    var idNumber_splits = idNumbers.split(',');
    var res = '';
    var html = '<div><label class="title">担保人</label>';

    $.each(name_splits, function(i, n) {
        res += n + '(' + idNumber_splits[i] + ')</br>';
    });

    if (name_splits.length == 1) {
        html += '<span class="ct">' + res + '</span></div>';
    } else {
        html += '<p>' + res + '</p></div>';
    }

    return html;
}

/**
 * 删除打印中的元素
 * 
 * @param map
 * @param key
 * @param event
 * @returns
 */
function delItem(map, key, target) {
    map.remove(key);
    $(target).parent().remove();
    if (map_nf.isEmpty() && map_f.isEmpty()) doPrintListClear();
}