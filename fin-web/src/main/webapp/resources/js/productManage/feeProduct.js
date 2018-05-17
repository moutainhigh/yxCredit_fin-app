var g_userManage = {
    tableCustomer : null,
    currentItem : null,
    fuzzySearch : false,
    getQueryCondition : function(data) {
        var paramFilter = {};
        var page = {};
        var param = {};
        param.state="12";
        param.personName=null;
        param.beginTime=null;
        param.endTime=null;
        paramFilter.param = param;
        page.firstIndex = data.start == null ? 0 : data.start;
        page.pageSize = data.length  == null ? 10 : data.length;
        paramFilter.page = page;
        return paramFilter;
    }
};
$(function (){
    $("#nianlixi").blur(function(){  // 失去焦点
        var nianlilv=$("#nianlixi").val();
        debugger
        if(isNaN(nianlilv)){
            layer.alert("年利率格式有误！",{icon: 2, title:'操作提示'});
            return
        }
        var yuelilv=(nianlilv/12).toFixed(4);
        var rililv=(nianlilv/365).toFixed(4);
        $("#yuelixi").val(yuelilv);
        $("#li_xi").val(rililv);
    });
});
$(function (){
    getProduct();
    getPeriodsSelect();
    if(g_userManage.tableCustomer){
        g_userManage.tableCustomer.ajax.reload();
    }else{
        g_userManage.tableCustomer = $('#fee_list').dataTable($.extend({
            'iDeferLoading':true,
            "bAutoWidth" : false,
            "Processing": true,
            "ServerSide": true,
            "sPaginationType": "full_numbers",
            "bPaginate": true,
            "bLengthChange": false,
            "destroy":true,
            "dom": 'rt<"bottom"i><"bottom"flp><"clear">',
            "ajax" : function(data, callback, settings) {//ajax配置为function,手动调用异步查询
                var queryFilter = g_userManage.getQueryCondition(data);
                Comm.ajaxPost('product/feeList', JSON.stringify(queryFilter), function (result) {
                    //封装返回数据
                    debugger
                    var returnData = {};
                    var resData = result.data.list;
                    var resPage = result.data;
                    returnData.draw = data.draw;
                    returnData.recordsTotal = resPage.total;
                    returnData.recordsFiltered = resPage.total;
                    returnData.data = resData;
                    callback(returnData);
                },"application/json");
            },
            "order": [],
            "columns": [
                {"data": null ,"searchable":false,"orderable" : false},
                {"data": "id","orderable" : false,"class":'hidden'},
                {"data": "product_amount","orderable" : false},
                {"data": "product_periods","orderable" : false},
                // {"data": "product_com_fee","orderable" : false},
                {"data": "year_rate","orderable" : false},
                {"data": "month_rate","orderable" : false},
                {"data": "li_xi","orderable" : false},
                // {"data": "zhifu_fee","orderable" : false},
                {"data": "loan_rate","orderable" : false},
                // {"data": "fengxian_fee","orderable" : false},
                {"data": "asuer_rate","orderable" : false},
                // {"data": "zhina_fee","orderable" : false},
                {"data": "yuqi_fee","orderable" : false},
                // {"data": "zongheri_fee","orderable" : false},
                {
                    "data": "null", "orderable": false,
                    "defaultContent":""
                }
            ],

            "createdRow": function ( row, data, index,settings,json ) {
                var btnUpdate = $('<a class="tabel_btn_style" onclick="editDetail(\'2\',\''+data.crm_product_paraent_id+'\',\''+data.product_periods+'\',\''+data.id+'\')">修改 </a>&nbsp; ');
                var btnDetele = $(' &nbsp; <a class="tabel_btn_style" onclick="deleteDetail(\''+data.id+'\')"> 删除</a>');
                $('td', row).eq(10).append(btnUpdate).append(btnDetele);

            },
        }, CONSTANT.DATA_TABLES.DEFAULT_OPTION)).api();
        g_userManage.tableCustomer.on("order.dt search.dt", function() {
            g_userManage.tableCustomer.column(0, {
                search : "applied",
                order : "applied"
            }).nodes().each(function(cell, i) {
                cell.innerHTML = i + 1
            })
        }).draw();
    }
});


//格式时间
function getFirstTime(inputTime) {
    var y,m,d,h,mi,s;
    if(inputTime) {
        y = inputTime.slice(0,4);
        m = inputTime.slice(4,6);
        d = inputTime.slice(6,8);
        h = inputTime.slice(8,10);
        mi = inputTime.slice(10,12);
        s = inputTime.slice(12);
        return y+'-'+m+'-'+d+" "+h+":"+mi+":"+s;
    }
}

//打开查看页面
function auditOrder(orderId,customerId){
    var url = "/financial/details?orderId="+orderId+"&customerId="+customerId;
    debugger
    layer.open({
        type : 2,
        title : '审核订单及客户资料',
        area : [ '100%', '100%' ],
        btn : [ '取消' ],
        content:url
    });
}
//添加修改费率
function  editDetail(type,productId,productPeriods,id) {
    if (type=='1'){
        layerIndex = layer.open({
            type : 1,
            title : "新增费率",
            maxmin : true,
            shadeClose : false, //点击遮罩关闭层
            area : [ '600px', '280px'  ],
            content : $('#editDetail'),
            btn : [ '提交', '取消' ],
            success: function () {
                $(".newField").remove();
               // $("input[name='zbs']").remove();
               // $("input[name='jujian_fee']").remove();
                $("#productPeriods").empty();
                $("#productPeriods").append("<option  value=''>请选择</option>");
                $("#productAmount").val('');
                // $("#productComFee").val('');
                $("#li_xi").val('');
                $("#nianlixi").val('');
                $("#yuelixi").val('');
                // $("#zhifu_fee").val('');
                //$("#loan_rate").val('');
                //$("#asuer_rate").val('');
                $("#loan_rate").val('');
                $("#asuer_rate").val('');

                // $("#fengxian_fee").val('');
                // $("#zhina_fee").val('');
                $("#yuqi_fee").val('');
                // $("#zongheri_fee").val('');
            },
            yes:function(index, layero){
                var productComFee=$("#productComFee").val();
                var li_xi=$("#li_xi").val();
                // var zhifu_fee=$("#zhifu_fee").val();
                var loan_rate=$("#loan_rate").val();
                var asuer_rate=$("#asuer_rate").val();
                // var fengxian_fee=$("#fengxian_fee").val();
                // var zhina_fee=$("#zhina_fee").val();
                var yuqi_fee=$("#yuqi_fee").val();
                debugger
                var zbs_jujian_fee = "";
                $("input[name='zbs_jujian_fee']").each(function(){
                    zbs_jujian_fee += $(this).val()+",";
                });
                // var zongheri_fee=$("#zongheri_fee").val();
                if($("#productAmount").val()==""){
                    layer.alert("产品名称未选择！",{icon: 2, title:'操作提示'});
                    return
                }
                if($("#productPeriods").val()==""){
                    layer.alert("产品期数未选择！",{icon: 2, title:'操作提示'});
                    return
                }
                if(isNaN($("#nianlixi").val())){
                    layer.alert("年利率格式有误！",{icon: 2, title:'操作提示'});
                    return
                }
                // if(productComFee==""){
                //     layer.alert("综合费率不能为空！",{icon: 2, title:'操作提示'});
                //     return
                // }else {
                //     if(isNaN(productComFee)){
                //         layer.alert("综合费率格式有误！",{icon: 2, title:'操作提示'});
                //         return
                //     }
                // }
                // if(li_xi==""){
                //     layer.alert("利息不能为空！",{icon: 2, title:'操作提示'});
                //     return
                // }else {
                //     if(isNaN(li_xi)){
                //         layer.alert("利息格式有误！",{icon: 2, title:'操作提示'});
                //         return
                //     }
                // }
                // if(zhifu_fee==""){
                //     layer.alert("支付服务费不能为空！",{icon: 2, title:'操作提示'});
                //     return
                // }else {
                //     if(isNaN(zhifu_fee)){
                //         layer.alert("支付服务费格式有误！",{icon: 2, title:'操作提示'});
                //         return
                //     }
                // }
                if(loan_rate==""){
                    layer.alert("借款利率不能为空！",{icon: 2, title:'操作提示'});
                    return
                }else {
                    if(isNaN(loan_rate)){
                        layer.alert("借款利率格式有误！",{icon: 2, title:'操作提示'});
                        return
                    }
                }
                // if(fengxian_fee==""){
                //     layer.alert("风险评估费不能为空！",{icon: 2, title:'操作提示'});
                //     return
                // }else {
                //     if(isNaN(fengxian_fee)){
                //         layer.alert("风险评估费格式有误！",{icon: 2, title:'操作提示'});
                //         return
                //     }
                // }
                if(asuer_rate==""){
                    layer.alert("担保费率不能为空！",{icon: 2, title:'操作提示'});
                    return
                }else {
                    if(isNaN(asuer_rate)){
                        layer.alert("担保费率格式有误！",{icon: 2, title:'操作提示'});
                        return
                    }
                }
                // if(zhina_fee==""){
                //     layer.alert("滞纳金不能为空！",{icon: 2, title:'操作提示'});
                //     return
                // }else {
                //     if(isNaN(zhina_fee)){
                //         layer.alert("滞纳金格式有误！",{icon: 2, title:'操作提示'});
                //         return
                //     }
                // }
                if(yuqi_fee==""){
                    layer.alert("逾期费率不能为空！",{icon: 2, title:'操作提示'});
                    return
                }else {
                    if(isNaN(yuqi_fee)){
                        layer.alert("逾期费率格式有误！",{icon: 2, title:'操作提示'});
                        return
                    }
                }
                // if(zongheri_fee==""){
                //     layer.alert("综合日费率不能为空！",{icon: 2, title:'操作提示'});
                //     return
                // }else {
                //     if(isNaN(zongheri_fee)){
                //         layer.alert("综合日费率格式有误！",{icon: 2, title:'操作提示'});
                //         return
                //     }
                // }
                var param = {};
                param.productId=$("#productPeriods").val();
                param.productAmount= $("#productAmount").find("option:selected").text();
                param.productPeriods=$("#productPeriods").find("option:selected").text();
                // param.productComFee=productComFee;
                param.li_xi=li_xi;
                param.year_rate=$("#nianlixi").val();
                param.month_rate=$("#yuelixi").val();
                // param.zhifu_fee=zhifu_fee;
                param.asuer_rate=asuer_rate;
                // param.fengxian_fee=fengxian_fee;
                param.loan_rate=loan_rate;
                // param.zhina_fee=zhina_fee;
                param.yuqi_fee=yuqi_fee;
                param.zbs_jujian_fee = zbs_jujian_fee;
                // param.zongheri_fee=zongheri_fee;
                Comm.ajaxPost('product/addFee', JSON.stringify(param), function (result) {
                    debugger
                    layer.msg(result.msg,{time:1000},function () {
                        if (result.code=="0"){
                            layer.closeAll();
                            g_userManage.tableCustomer.ajax.reload();
                        }
                    });
                },"application/json");
            }
        })
    }else {
        layerIndex = layer.open({
            type : 1,
            title : "编辑费率",
            maxmin : true,
            shadeClose : false, //点击遮罩关闭层
            area : [ '600px', '280px'  ],
            content : $('#editDetail'),
            btn : [ '提交', '取消' ],
            success: function () {
                // getPeriodsSelect();
                getProduct();
                $(".newField").remove();
                var param = {};
                param.id=id;
                Comm.ajaxPost('product/getFee', JSON.stringify(param), function (result) {
                    var resData = result.data;
                    $("#productComFee").val(resData.product_com_fee);
                    $("#productAmount").val(resData.crm_product_paraent_id);
                    $("#productPeriods").val(resData.product_id);
                    getPeriods(resData.crm_product_paraent_id,resData.product_id);
                    $("#li_xi").val(resData.li_xi);
                    // $("#zhifu_fee").val(resData.zhifu_fee);
                    $("#asuer_rate").val(resData.asuer_rate);
                    // $("#fengxian_fee").val(resData.fengxian_fee);
                    $("#loan_rate").val(resData.loan_rate);
                    $("#yuqi_fee").val(resData.yuqi_fee);
                    $("#nianlixi").val(resData.year_rate);
                    $("#yuelixi").val(resData.month_rate);
                    var zbs_jujian_fee = resData.zbs_jujian_fee;
                    var zbsArray = zbs_jujian_fee.substring(0,zbs_jujian_fee.length-1).split(',');
                    $.each(zbsArray,function(index,value){
                        if(index%2 === 0){
                            $("#detailInfo").append("<li class='newField' style=\"width:260px\">\n" +
                                "                        <label  class=\"lf licss\"  >总包商</label>\n" +
                                "                        <label >\n" +
                                "                            <input type=\"text\"  name=\"zbs_jujian_fee\" value='"+zbsArray[index]+"'>\n" +
                                "                        </label>\n" +
                                "                    </li>");
                        }else{
                            $("#detailInfo").append("<li class='newField' style=\"width:260px\">\n" +
                                "                        <label  class=\"lf licss\"  >居间服务费</label>\n" +
                                "                        <label >\n" +
                                "                            <input type=\"text\"  name=\"zbs_jujian_fee\" value = '"+zbsArray[index]+"'>\n" +
                                "                        </label>\n" +
                                "                    </li>");
                        }
                    });
                    // $("#zhina_fee").val(resData.zhina_fee);
                    // $("#zongheri_fee").val(resData.zongheri_fee);
                },"application/json");
            },
            yes:function(index, layero){
                debugger;
                var productComFee=$("#productComFee").val();
                var li_xi=$("#li_xi").val();
                // var zhifu_fee=$("#zhifu_fee").val();
                var asuer_rate=$("#asuer_rate").val();
                // var fengxian_fee=$("#fengxian_fee").val();
                var loan_rate=$("#loan_rate").val();
                var yuqi_fee=$("#yuqi_fee").val();
                var zbs_jujian_fee_new = "";
                $("input[name='zbs_jujian_fee']").each(function(){
                    zbs_jujian_fee_new += $(this).val()+",";
                });
                // var zhina_fee=$("#zhina_fee").val();
                // var zongheri_fee=$("#zongheri_fee").val();
                if($("#productAmount").val()==""){
                    layer.alert("产品名称未选择！",{icon: 2, title:'操作提示'});
                    return
                }
                if($("#productPeriods").val()==""){
                    layer.alert("产品期数未选择！",{icon: 2, title:'操作提示'});
                    return
                }
                // if(productComFee==""){
                //     layer.alert("综合费率不能为空！",{icon: 2, title:'操作提示'});
                //     return
                // }else {
                //     if(isNaN(productComFee)){
                //         layer.alert("综合费率格式有误！",{icon: 2, title:'操作提示'});
                //         return
                //     }
                // }
                if(li_xi==""){
                    layer.alert("利息不能为空！",{icon: 2, title:'操作提示'});
                    return
                }else {
                    if(isNaN(li_xi)){
                        layer.alert("利息格式有误！",{icon: 2, title:'操作提示'});
                        return
                    }
                }

                if(isNaN($("#nianlixi").val())){
                    layer.alert("年利率格式有误！",{icon: 2, title:'操作提示'});
                    return
                }
                // if(zhifu_fee==""){
                //     layer.alert("支付服务费不能为空！",{icon: 2, title:'操作提示'});
                //     return
                // }else {
                //     if(isNaN(zhifu_fee)){
                //         layer.alert("支付服务费格式有误！",{icon: 2, title:'操作提示'});
                //         return
                //     }
                // }
                if(loan_rate==""){
                    layer.alert("借款利率不能为空！",{icon: 2, title:'操作提示'});
                    return
                }else {
                    if(isNaN(loan_rate)){
                        layer.alert("借款利率格式有误！",{icon: 2, title:'操作提示'});
                        return
                    }
                }
                // if(fengxian_fee==""){
                //     layer.alert("风险评估费不能为空！",{icon: 2, title:'操作提示'});
                //     return
                // }else {
                //     if(isNaN(fengxian_fee)){
                //         layer.alert("风险评估费格式有误！",{icon: 2, title:'操作提示'});
                //         return
                //     }
                // }
                if(asuer_rate==""){
                    layer.alert("担保费率不能为空！",{icon: 2, title:'操作提示'});
                    return
                }else {
                    if(isNaN(asuer_rate)){
                        layer.alert("担保费率格式有误！",{icon: 2, title:'操作提示'});
                        return
                    }
                }
                // if(zhina_fee==""){
                //     layer.alert("滞纳金不能为空！",{icon: 2, title:'操作提示'});
                //     return
                // }else {
                //     if(isNaN(zhina_fee)){
                //         layer.alert("滞纳金格式有误！",{icon: 2, title:'操作提示'});
                //         return
                //     }
                // }
                if(yuqi_fee==""){
                    layer.alert("逾期费率不能为空！",{icon: 2, title:'操作提示'});
                    return
                }else {
                    if(isNaN(yuqi_fee)){
                        layer.alert("逾期费率格式有误！",{icon: 2, title:'操作提示'});
                        return
                    }
                }
                // if(zongheri_fee==""){
                //     layer.alert("综合日费率不能为空！",{icon: 2, title:'操作提示'});
                //     return
                // }else {
                //     if(isNaN(zongheri_fee)){
                //         layer.alert("综合日费率格式有误！",{icon: 2, title:'操作提示'});
                //         return
                //     }
                // }
                var param = {};
                param.id=id;
                param.productId=$("#productPeriods").val();
                param.productAmount= $("#productAmount").find("option:selected").text();
                param.productPeriods=$("#productPeriods").find("option:selected").text();
                param.productComFee=productComFee;
                param.li_xi=li_xi;
                param.year_rate=$("#nianlixi").val();
                param.month_rate=$("#yuelixi").val();
                // param.zhifu_fee=zhifu_fee;
                // param.fengxian_fee=fengxian_fee;
                param.asuer_rate=asuer_rate;
                param.loan_rate=loan_rate;
                // param.zhina_fee=zhina_fee;
                param.yuqi_fee=yuqi_fee;
                param.zbs_jujian_fee = zbs_jujian_fee_new;
                // param.zongheri_fee=zongheri_fee;
                Comm.ajaxPost('product/updateFee', JSON.stringify(param), function (result) {
                    layer.msg(result.msg,{time:1000},function () {
                        if (result.code=="0"){
                            layer.closeAll();
                            g_userManage.tableCustomer.ajax.reload();
                        }
                    });
                },"application/json");
            }
        })
    }
}
//删除费率
function  deleteDetail(id) {
    var param = {};
    param.id = id;
    param.state="-1";
    Comm.ajaxPost('product/del', JSON.stringify(param), function (result) {
        layer.msg(result.msg,{time:1000},function () {
            if (result.code=="0"){
                g_userManage.tableCustomer.ajax.reload();
            }
        });
    },"application/json");
}
//获取产品分期列表e200601b-6fbe-42dc-99f7-2404a3a42a3e
function getPeriods(crmProductId,productPeriods) {
    debugger
    if(crmProductId==''||crmProductId==undefined){
        crmProductId = $("#productAmount").val();
    }
    if(crmProductId!=""){
        Comm.ajaxPost('product/getPeriodsList', crmProductId, function (result) {
            //封装返回数据
            var resData = result.data;
            $("#productPeriods").empty();
            var selObj = $("#productPeriods");
            for (var i=0;i<resData.length;i++){
                var product_term_min = resData[i].productTermMin;
                var product_term_max = resData[i].productTermMax;
                var product_term_unit = resData[i].productTermUnit;

                //debugger
                //var text=resData[i].periods;
                var text = product_term_min+" 至 "+product_term_max+" "+product_term_unit;
                //var text=resData[i].periods;
                selObj.append("<option  value='"+resData[i].id+"'>"+text+"</option>");
            }
            if(productPeriods!=undefined && productPeriods!=''){
                selObj.val(productPeriods);
            }
        }, "application/json");
    }
    else {
        $("#productPeriods").empty();
        $("#productPeriods").append("<option  value=''>请选择</option>");
    }
}

//获取产品下拉
function getProduct() {
    Comm.ajaxPost('product/getProduct', null, function (result) {
        var resData = result.data;
        $("#productAmount").empty();
        $("#productAmount").append("<option value=''>请选择</option>");
        for (var i=0;i<resData.length;i++){
            var value=resData[i].id;
            var text=resData[i].pro_name;
            $("#productAmount").append("<option name='"+text+"' value='"+value+"'>"+text+"</option>");
        }
    },"application/json",null,null,null,false);
}
//获取期数下拉
function getPeriodsSelect() {
    Comm.ajaxPost('product/getPeriods', null, function (result) {
        var resData = result.data;
        $("#productPeriods").empty();
        $("#productPeriods").append("<option value=''>请选择</option>");
        for (var i=0;i<resData.length;i++){
            var value=resData[i].id;
            var product_term_min = resData[i].product_term_min;
            var product_term_max = resData[i].product_term_max;
            var product_term_unit = resData[i].product_term_unit;

             //debugger
            //var text=resData[i].periods;
            var text = product_term_min+" 至 "+product_term_max+product_term_unit;
            $("#productPeriods").append("<option name='"+text+"' value='"+value+"'>"+text+"</option>");
        }
    },"application/json",null,null,null,false);


}

//添加总包商
function addZBS() {
    //var liIndex = $("#detailInfo li").length-7;
    $("#detailInfo").append("<li class='newField' style=\"width:260px\">\n" +
        "                        <label  class=\"lf licss\"  >总包商</label>\n" +
        "                        <label >\n" +
        "                            <input type=\"text\"  name=\"zbs_jujian_fee\" >\n" +
        "                        </label>\n" +
        "                    </li>" +
        "                    <li class='newField' style=\"width:260px\">\n" +
        "                        <label class=\"lf licss\"  >居间服务费</label>\n" +
        "                        <label >\n" +
        "                            <input type=\"text\"  name=\"zbs_jujian_fee\" >\n" +
        "                        </label>\n" +
        "                    </li>");
}