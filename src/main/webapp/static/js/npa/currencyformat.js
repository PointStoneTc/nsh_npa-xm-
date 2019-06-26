/**
 * 无符号金钱显示：123,456.00
 */
function formatNull(val, row) {
    return accounting.formatMoney(val, "", 2);
}
/**
 * 人民币金钱显示：￥123,456.00
 */
function formatYuan(val, row) {
    return accounting.formatMoney(val, "￥", 2);
}
/**
 * 美元金钱显示：$123,456.00
 */
function formatDollar(val, row) {
    return accounting.formatMoney(val, "$", 2);
}
/**
 * 欧元金钱显示：€123,456.00
 */
function formatEuro(val, row) {
    return accounting.formatMoney(val, "€", 2);
}
/**
 * 百分数显示：90.00%
 */
function formatPerc(val, row) {
    return accounting.toFixed(val * 100, 2) + '%';
}