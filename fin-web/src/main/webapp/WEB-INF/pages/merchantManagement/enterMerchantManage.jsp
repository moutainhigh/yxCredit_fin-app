<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@ include file ="../common/taglibs.jsp"%>
    <%@ include file="../common/importDate.jsp"%>
    <link rel="stylesheet" href="${ctx}/resources/css/paperInfo.css${version}"/>
    <link rel="stylesheet" href="${ctx}/resources/assets/datepick/need/laydate.css${version}">
    <script src="${ctx}/resources/assets/datepick/laydate.js"></script>
    <script src="${ctx}/resources/assets/js/jquery.form.min.js${version}"></script>
    <script src='${ctx}/resources/js/merchantManagement/enterMerchantManage.js${version}'></script>
    <script type="text/javascript" src="${ctx}/resources/assets/treeTable/js/jquery.treetable.js"></script>
    <script type="text/javascript" src="${ctx}/resources/assets/zTree/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/resources/assets/zTree/tree.js"></script>
    <link rel="stylesheet" href="${ctx}/resources/assets/zTree/css/zTreeStyle/zTreeStyle.css" />
    <link rel="stylesheet" href="${ctx}/resources/assets/select-mutiple/css/select-multiple.css${version}"/>
    <script src="https://gosspublic.alicdn.com/aliyun-oss-sdk-4.4.4.min.js"></script>
    <script src="${ctx}/resources/js/areaQuota/city.data-3.js${version}"></script>
    <title>入驻商户管理</title>
    <style type="text/css">
        .laydate_body .laydate_y {margin-right: 0;}
        .line-cut{float: left;position: relative;top: 6px;left: -5px;}
        .onlyMe input{margin:0;vertical-align:middle;}
        #sign_list{font-size:13px;}
        .checkShow,.uploadContact{color:#05c1bc}
        .checkShow{margin-right: 8px;}

        .paperBlockfree{cursor: pointer;}
        .paperBlockfree{overflow: hidden;}

        #divFrom input{border:none;background-color: #fff;text-align: left;}
        .unit{position: relative; top:1px;}
        /*合理性样式*/
        #showReasonable input[name=ReasonableInput],#showReasonable input[name=ReasonableInput_fitment],#showReasonable input[name=ReasonableInput_fitment_money]{border:1px solid #ddd}
        .ReasonableUl li{
            display: inline-block;
            width: 10%;
            border: 1px solid #ddd;
            padding:.5em;
            margin:.5em 0;
            transition: width 2s;
            -moz-transition: width 2s;
            -webkit-transition: width 2s;
            -o-transition: width 2s;
        }
        .ReasonableUl li:hover{
            display: inline-block;
            width: 25%;
            transition: width 2s;
            -moz-transition: width 2s;
            -webkit-transition: width 2s;
            -o-transition: width 2s;
            border: 1px solid #ddd;
            padding:.5em;
            margin:.5em 0;
        }
        .ReasonableUl li img{
            width: 100%;
            cursor: pointer;
        }
        .answerRemark,#elecRemark,#customerRemark,#giveAmount{width: 100%;position: relative;left:-10px;}
        #customerRemark,#elecRemark,#advice{width: 96%;margin-left: 20px;}
        .imagediv{
            width:150px;
            height:150px;
            background-color:white;
            text-align: center;
            float: left;
            position: relative;
            margin-right: 1em;
        }
        .addMaterial{
            width:150px;
            height:150px;
            vertical-align: middle;
        }
        .picShow{
            position:absolute;
            z-index:100;
            opacity:0;
            filter:alpha(opacity=0);
            height:150px;
            width:150px;
            readonly:true;
        }
        #firstCredit,#passRemark,#cheatRemark{width:95%;float:left;margin-left:0px;margin-left:4px;}
        #cheatRemark{width: 99%;}
        .telRecord{height: 37px;  text-align: left;  padding-left: 35px;}
        #recordList1 td,#recordList2 td,#recordList3 td,#recordList4 td,#answerBody td,#answerBody1 td{border:none;border-right:1px solid #ccc}
        #recordList1 tr,#recordList2 tr,#recordList3 tr,#recordList4 tr,#answerBody tr,#answerBody1 tr{border:1px solid #ccc;}
        .answerTh th{text-align: center; font-weight: normal;border:none;}
        .answerTh thead{border:1px solid #ccc;border-top:none;background: #DFF1D9}
        .cencus{height: 40px;width:100%;line-height:40px;float:left;border-right:1px solid #ccc;border-left:1px solid #ccc;background-color: white; text-align: left;
            padding-left: 29px;
        }
        .MerInput{
            margin:.5em 0;
        }
        #MerMsg tr td{
            text-align: right;
            padding-left:0.2em;
        }
        #auditFinds{
            padding: 1em;
        }
        #auditFinds p{
            height:30px;
            line-height: 30px;
            text-align: left;
        }
        #auditFinds .icon-file-text-alt:before{
            color: #05C1BC;
            font-size: 22px;
        }
        #auditFinds p,#auditFinds p span{
            font-size: 15px;
            font-weight: 700;
        }
        .findsTable{
            width: 800px;
        }
        .findsTable thead tr th,.findsTable tbody tr td{
            height:30px;
            line-height: 30px;
            border: 1px solid #ccc;
            text-align: center;
        }
        #auditFinds .rules,#auditFinds .scoreCard,#auditFinds .blackList{
            margin-bottom: 20px;
        }
        /*显示图片*/
        #imageCard .imgShow,#cheatImg .imgShow,#phoneImg .imgShow{width:40px;height: 40px;float:left;margin-right:1em;}
        #imageCard .imgShowTd{padding-left: 1em;text-align:left}
        #BigImg{ width: 200px;height: 200px;position: absolute;top:-166px;left: 175px;display: none;z-index: 9999;}
        .align{width:110px;}
        #divFrom td{text-align: center;}
        #divFrom input{text-align: center;}
        #imageCard tr{height: 37px;}
        .paperBlockfree{cursor: pointer;}
        .paperBlockfree{overflow: hidden;}
        #divFrom .telRecord{text-align: left;font-weight: bold;}
        .picShow {
            position: absolute;
            z-index: 100;
            opacity: 0;
            filter: alpha(opacity=0);
            height: 100%;
            width: 100%;
            top: 1em;
            left: 1em;
        }
        #contract_list{font-size: 13px;}
        #auditFinds{
            padding: 1em;
        }
        #auditFinds p{
            height:30px;
            line-height: 30px;
            text-align: left;
        }
        #auditFinds .icon-file-text-alt:before{
            color: #05C1BC;
            font-size: 22px;
        }
        #auditFinds p,#auditFinds p span{
            font-size: 15px;
            font-weight: 700;
        }
        .findsTable{
            width: 800px;
        }
        .findsTable thead tr th,.findsTable tbody tr td{
            height:30px;
            line-height: 30px;
            border: 1px solid #ccc;
            text-align: center;
        }
        #auditFinds .rules,#auditFinds .scoreCard,#auditFinds .blackList{
            margin-bottom: 20px;
        }
        #clerk_manager_table{
            border:0;

        }
        #clerk_manager_table td{
            background:white;
            width: 250px;
            height: 40px;
            border: 1px solid black;
        }

        .laydate_body .laydate_y {margin-right: 0;}
        .line-cut{float: left;position: relative;top: 6px;left: -5px;}
        .onlyMe{font-size: 13px;}
        .onlyMe input{margin:0;text-align: center;}
        .tdTitle{text-align: right;width: 120px;font-weight:bold;}
        #container td input{background-color: #fff; border:none;text-align: left;
            width: 100%;
            height: 80%;
            text-align: left;
            margin: 0;
            border: 1px solid #ccc;
        }
        #imageCard {width:40px;height: 40px;float:left;margin-right:1em;}
        .imgShow{max-width: 100%;max-height: 100%;}
        #imageCard .imgShowTd{padding-left: 1em;}
        #BigImg{ width: 200px;height: 200px;position: absolute;top:-166px;left: 175px;display: none;z-index: 9999;}
        #showNewImg ul{text-align: left}
        #showNewImg ul li{display: inline-block;width:25%;border:1px solid #ddd;text-align: center;margin:.2em 0;}
        .imgDiv{width:120px;height:160px;border:1px solid #ddd;padding:.2em;margin:.2em auto;}
        .imgContainer{display: inline-block;position: relative}

        .closeImg{
            position: absolute;
            top: -10px;
            right: -10px;
            width: 20px;
            height: 20px;
            z-index: 999;
            font-size: 20px;
            /* border: 1px solid; */
            border-radius: 50%;
            background: #000;
            color: #fff;
            line-height: 20px;
            cursor: pointer;
        }
        #divYesAndNO{
            width:200px;
            height:200px;
            border:1px solid #D0D0D0;
            /*background-color: #D0D0D0;*/
            position: fixed;
            right:200px;
            top:100px;
        }
    </style>
</head>
<body>
<div class="page-content">
    <input type="hidden" id="merchantId" value="">
    <input type="hidden" id="fanQIZhaState " value="">
    <input type="hidden" id="3 ">
    <div class="commonManager">
        <div class="Manager_style add_user_info search_style">
            <ul class="search_content clearfix">
                <li style="width:250px;">
                    <label class="lf">商户名称:</label>
                    <label style="width: 100px">
                        <input type="text" id="search_merchantName">
                    </label>
                </li>
                <li style="width:250px;">
                    <label class="lf">申请人:</label>
                    <label style="width: 100px">
                        <input type="text" id="search_apply_name">
                    </label>
                </li>
                <li style=" width: 200px;">
                    <label class="lf" >省</label>
                    <label>
                        <select name="condition" size="1" id="province_search" onchange="citySelAdd(this.options[this.options.selectedIndex].value,$('#city_search'))"
                                style="width:163px;margin-left: 10px;height: 28px" >
                            <option value="">-请选择-</option>
                        </select>
                    </label>
                </li>
                <li style=" width: 200px;">
                    <label class="lf">市</label>
                    <label>
                        <select name="condition" size="1" id="city_search" onchange="areaSelAdd(this.options[this.options.selectedIndex].value,$('#district_search'))"
                                style="width:163px;margin-left: 10px;height: 28px" >
                            <option value="">-请选择-</option>
                        </select>
                    </label>
                </li>
                <li style=" width: 200px;">
                    <label class="lf">区</label>
                    <label>
                        <select name="condition" size="1" id="district_search" style="width:163px;margin-left: 10px;height: 28px" >
                            <option value="">-请选择-</option>
                        </select>
                    </label>
                </li>
                <li style="width:200px;">
                    <button id="btn_search" type="button" class="btn btn-primary queryBtn">查询</button>
                    <button id="btn_reset" type="button" class="btn btn-primary queryBtn" >查询重置</button>
                </li>
            </ul>
        </div>
        <div class="Manager_style">
            <div class="order_list">
                <table style="cursor:pointer;" id="sign_list" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>序号</th>
                        <%--<th>商户编号</th>--%>
                        <th>名称</th>
                        <th>商户等级</th>
                        <th>主营业务</th>
                        <th>门店地址</th>
                        <th>详细地址</th>
                        <th>申请人</th>
                        <th>审核状态</th>
                        <th>反欺诈状态</th>
                        <th>商户状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- 商户详细信息弹出窗 -->
<div id="div_add_merchant" style="display: none">
    <div class="addCommon clearfix">
        <div>
            <div id="container" class="of-auto_H" style="padding:20px;">
                <div id="divFrom">
                    <div class="paddingBox xdproadd" style="width:1200px">
                        <div class="paperBlockfree" style="margin-top:20px">
                            <%--商户基本信息--%>
                            <div class="block_hd" style="float:left;">
                                <s class="ico icon-file-text-alt"></s><span class="bl_tit">商户基本信息</span>
                            </div>
                            <table class="tb_info " style="font-size:12px; color: #000;">
                                <tbody>
                                <tr>
                                    <td  width="131px;">公司名称:</td>
                                    <td  style="width: 288px;">
                                        <input id='add_mer_name' type="text"  class="text_add" style="width: 250px;" placeholder="公司名称" readonly>
                                    </td>
                                    <td  width="131px">营业执照注册号:</td>
                                    <td width="23%" id="tdSex">
                                        <input id='add_license_number' type="text" class="text_add" style="height: 28px;width: 250px;" placeholder="营业执照注册号" >
                                    </td>
                                    <td class="align" width="131px">主营业务:</td>
                                    <td id="proTel" width="23%">
                                        <input id="add_main_business" type="text" class="text_add" style="width: 250px; "/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align">企业类型:</td>
                                    <td id="applyIdcard">
                                        <%--<input id='add_type' type="text"  placeholder="企业类型" style="width: 250px;">--%>
                                        <select  id="add_type" type="text" style="width: 250px;height:31px;font-size: 14px; text-align: left;" >
                                            <option value="">请选择</option>
                                        </select>
                                    </td>
                                    <td class="align">营业执照日期:</td>
                                    <td>
                                        <input readonly="true" placeholder="点击选取日期" class="eg-date" id="add_license_date" type="text" style="width: 250px;" />
                                        <%--<input id="add_license_date" type="text" class="text_add" style="width: 250px;"/>--%>
                                    </td>
                                    <td class="align">注册资本:</td>
                                    <td id="applyCensus">
                                        <input id="add_registered_capital" type="text" class="text_add" style="width: 250px;"/>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="align">员工人数:</td>
                                    <td id="tdBirth">
                                        <input id="add_employees_number" type="text" class="text_add" style="width: 250px;" placeholder="员工人数"/>
                                    </td>
                                    <td class="align" >门店地址:</td>
                                    <td id="applyMerry" style="width: 223px;" colspan="3">
                                        <%--<input id="add_mer_address" type="text" class="text_add"/>--%>
                                        <select name="state" id="province" onchange="citySelAdd(this.options[this.options.selectedIndex].value,$('#city'))"type="text" style="width: 190px;height:30px;font-size: 14px;" >
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">&nbsp省&nbsp</span>

                                        <select name="state" id="city" onchange="areaSelAdd(this.options[this.options.selectedIndex].value,$('#area'))" type="text" style=" width: 190px;height:30px;font-size: 14px;" >
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">&nbsp市&nbsp</span>

                                        <select name="state" id="area" type="text" style=" width: 190px;height:30px;font-size: 14px;" >
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">区</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>门店电话:</td>
                                    <td id="unitName">
                                        <input id="add_merchant_tel" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                    <td class="align">详细地址:</td>
                                    <td id="education" >
                                        <input id="add_merchant_detail_address" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                    <td class="align">门店邮箱:</td>
                                    <td >
                                        <input id="add_merchant_email" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                </tr>
                            </table>
                            <%--申请人信息--%>
                            <div class="block_hd" style="float:left; margin-top: 30px;">
                                <s class="ico icon-file-text-alt"></s><span class="bl_tit">申请人信息</span>
                            </div>
                            <table class="tb_info " style="font-size:12px; color: #000;">
                                <tbody>
                                <tr>
                                    <td style="width:131px;">申请人姓名:</td>
                                    <td>
                                        <input id="add_apply_name" type="text" class="text_add" style="width: 250px;"/>
                                    </td>

                                    <td style="width:131px;">申请人电话:</td>
                                    <td>
                                        <input id="add_apply_tel" type="text" class="text_add" style="width: 250px;"/>
                                    </td>

                                    <td style="width:131px;">申请人身份证号:</td>
                                    <td >
                                        <input id="add_apply_idcard" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <%--法人信息--%>
                            <div class="block_hd" style="float:left; margin-top: 30px;">
                                <s class="ico icon-file-text-alt"></s><span class="bl_tit">法人信息</span>
                            </div>
                            <table class="tb_info " style="font-size:12px; color: #000;" id="faren_table">
                                <tbody>
                                <tr>
                                    <td width="131px;">法人姓名:</td>
                                    <td  width="288px;">
                                        <input id="add_person_name" type="text" class="text_add" style="width: 250px;" />
                                    </td>
                                    <td>法人电话:</td>
                                    <td>
                                        <input id="add_person_tel" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                    <td>法人身份证号:</td>
                                    <td>
                                        <input id="add_persion_card" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>法人银行卡号:</td><!--***************-->
                                    <td>
                                        <input id="add_persion_bank_account" type="text" class="text_add" style="width: 250px;"/>
                                    </td>

                                    <td>法人银行卡号开户行:</td>
                                    <td colspan="3">
                                        <select name="state" id="faren_province" onchange="citySelAdd(this.options[this.options.selectedIndex].value,$('#faren_city'))"type="text" style="width: 190px;height:30px;font-size: 14px;" >
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">省&nbsp;</span>
                                        <select name="state" id="faren_city"  type="text" style=" width: 190px;height:30px;font-size: 14px;" >
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">市&nbsp;</span>
                                        <input id="add_persion_opening_bank" type="text" class="text_add" style="width: 200px;" placeholder="输入银行名"/>
                                    </td>
                                </tr>
                                <%--总行名称 如：建设银行--%>
                                <tr>
                                    <td style="width:131px;">法人银行名称:</td>
                                    <td>
                                        <select  style="width: 250px; height: 31px;" id="add_persion_opening_bank_head">
                                            <option val="">请选择</option>
                                        </select>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <%--收款人委托人信息--%>
                            <div class="block_hd" style="float:left; margin-top: 30px;">
                                <s class="ico icon-file-text-alt"></s><span class="bl_tit">收款委托人信息</span>
                            </div>
                            <table class="tb_info " style="font-size:12px; color: #000;" id="add_money_bailor_table">
                                <tbody>
                                <tr>
                                    <td style="width: 131px;">收款委托人姓名:</td>
                                    <td>
                                        <input id="add_money_bailor_name" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                    <td>收款委托人电话:</td>
                                    <td>
                                        <input id="add_money_bailor_tel" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                    <td>收款委托人身份证号:</td>
                                    <td>
                                        <input id="add_money_bailor_idcard" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>收款委托人银行卡号:</td>
                                    <td>
                                        <input id="add_money_bailor_account" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                    <td>收款委托人开户行:</td>
                                    <td colspan="3">
                                        <select name="state" id="weituo_province" onchange="citySelAdd(this.options[this.options.selectedIndex].value,$('#weituo_city'))"type="text" style="width: 190px;height:30px;font-size: 14px;" >
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">省&nbsp;</span>
                                        <select name="state" id="weituo_city"  type="text" style=" width: 190px;height:30px;font-size: 14px;" >
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">市&nbsp;</span>
                                        <input id="add_money_bailor_oppen_bank" type="text" class="text_add" style="width: 200px;"placeholder="输入银行名"/>
                                    </td>
                                </tr>
                                <%--总行名称 如：建设银行--%>
                                <tr>
                                    <td style="width:131px;">委托人银行名称:</td>
                                    <td>
                                        <select  style="width: 250px; height: 31px;" id="add_money_bailor_oppen_bank_head">
                                            <option val="">请选择</option>
                                        </select>
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                            <%--对公账号--%>
                            <div class="block_hd" style="float:left; margin-top: 30px;">
                                <s class="ico icon-file-text-alt"></s><span class="bl_tit">对公账号</span>
                            </div>
                            <table class="tb_info " style="font-size:12px; color: #000;" id="add_public_opening_table">
                                <tbody>
                                <tr>
                                    <td style="width:131px;">对公账号名称:</td>
                                    <td>
                                        <input id="add_public_account_name" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                    <td>对公账号:</td>
                                    <td>
                                        <input id="add_public_bank_account" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>对公开户行:</td>
                                    <td colspan="5">
                                        <select name="state" id="public_province" onchange="citySelAdd(this.options[this.options.selectedIndex].value,$('#public_city'))"type="text" style="width: 190px;height:30px;font-size: 14px;" >
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">省&nbsp;</span>
                                        <select name="state" id="public_city"  type="text" style=" width: 190px;height:30px;font-size: 14px;" >
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">市&nbsp;</span>
                                        <input id="add_public_opening_bank" type="text" class="text_add" style="width: 250px;" placeholder="输入银行名"/>
                                    </td>
                                </tr>
                                <%--总行名称 如：建设银行--%>
                                <tr>
                                    <td style="width:131px;">对公银行名称:</td>
                                    <td>
                                        <select  style="width: 250px; height: 31px;" id="add_public_opening_bank_head">
                                            <option val="">请选择</option>
                                        </select>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="paperBlockfree" style="position: relative;margin-top:20px;">
                            <div class="block_hd" style="float:left;" style="float:left;" onclick="shrink(this)">
                                <s class="ico icon-file-text-alt"></s><span class="bl_tit">影像资料</span>
                            </div>
                            <script>
                                function setImagePreview1(me,tdId){
//                                            debugger
                                    if(tdId =='td_idcard_zhengmian'){
                                        if(($("#td_idcard_zhengmian").children()).length>1){
                                            layer.msg("身份证正面照只能传一张",{time:1000});
                                            return ;
                                        }
                                    }
                                    //td_idcard_fanmian
                                    if(tdId =='td_idcard_fanmian'){
                                        if(($("#td_idcard_fanmian").children()).length>1){
                                            layer.msg("身份证反面照只能传一张",{time:1000});
                                            return ;
                                        }
                                    }
                                    // layer.load(2);
                                    var uploadImgNum = $(me).parent().parent().parent().parent().attr("id");
                                    var uploadImgType = $(me).parent().parent().parent().find('input[name="type"]').val();
                                    var imgObjPreview=me.nextElementSibling;
                                    if(me.files && me.files[0]){
                                        var type=me.files[0].type;
                                        if(type.indexOf("image")==-1){
                                            // layer.closeAll();
                                            layer.msg("您上传的图片格式不正确，请重新选择!",{time:1000});
                                            return;
                                        }
                                        //火狐下，直接设img属性
                                        imgObjPreview.src = window.URL.createObjectURL(me.files[0]);
                                        var index =layer.load(2);
                                        /**********阿里云js sdk上传文件************/
                                        var val= me.value;
                                        var suffix = val.substr(val.indexOf("."));
                                        var obj=timestamp();  // 这里是生成文件名
                                        var storeAs = 'upload-file/'+"/"+obj+suffix;  //命名空间
                                        var file = me.files[0];
                                        Comm.ajaxUpload('accessToken/getToken','',function (res) {
                                            var result = res.data;
                                            var client = new OSS.Wrapper({
                                                accessKeyId: result.AccessKeyId,
                                                accessKeySecret: result.AccessKeySecret,
                                                stsToken: result.SecurityToken,
                                                secure: true,
                                                endpoint: 'https://oss-cn-beijing.aliyuncs.com',
                                                bucket: 'miaofuxianjindai-001'
                                            });
                                            client.multipartUpload(storeAs, file).then(function (result) {
                                                var res = result.res.requestUrls[0].split('?')[0];
                                                if(uploadImgType!='1'){
                                                    $("#"+uploadImgNum).append(uploadImgHtml);
                                                    var num = uploadImgNum.replace(/[^0-9]/ig,"");
                                                    $("#"+uploadImgNum).find("input[name=type]").val(num);
                                                }
                                                $(me).attr('disabled',true);
                                                //$(me).hide();
                                                //$(me).next("img").attr({onclick:"tt(this.src)"});
                                                $(me).parent().parent().parent().find("input[name=originalName]").val(file.name);
                                                $(me).parent().parent().prev().prev().prev().val(res);//图片阿里云地址
                                                //$("#img_idcard_zhengmian").val(res);
                                                console.log(res);
                                                $(me).parent().parent().parent().find("input[name=src]").val(res);
                                                $(me).parent().parent().parent().addClass("getFanQiZha");
                                                //$(me).parent().append("<span class='closeImg' onclick='closeDelete(this)'>×</span>");
                                                //layer.closeAll();
                                                layer.close(index);
                                                if($(me).after().src != '../resources/images/photoadd.png'){
                                                    $(me).prev().css("display","inline-block");
                                                }
                                                var td_img=
                                                        '<div>' +
                                                        '<input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">'+
                                                        '<input type="hidden" class="imgHidden"  name="src" value=""/>'+
                                                        '<input type="hidden" class="imgHidden" name="originalName" value="">'+
                                                        '<input type="hidden" class="imgHidden" name="isfront" value="0">'+
                                                        '<form action="" enctype="multipart/form-data">'+
                                                        '<div class="imagediv">'+
                                                        '<span style="display: none; color: red;" class="closeImg" onclick="closeDelete(this,\''+tdId+'\')">X</span>'+
                                                        '<input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,\''+tdId+'\')"/>'+
                                                        '<img class="addMaterial"  src="../resources/images/photoadd.png" />'+
                                                        '</div>'+
                                                        '</form>'+
                                                        '</div>' ;
                                                $("#"+tdId).append(td_img);
                                            }).catch(function (err) {
                                                //console.log(err);
                                                layer.closeAll();
                                            });
                                        })
                                    }
                                    return true;
                                }
                                function closeDelete(me,tdId){
                                    //删除该div
                                    $(me).parent().parent().parent().remove();
                                    console.log($("#"+tdId).children().length);
                                    //如果一直删到整个td下面没有元素了，就生成一个图片div
                                    if($("#"+tdId).children().length == 0){
                                        var td_img=
                                                '<div>' +
                                                '<input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">'+
                                                '<input type="hidden" class="imgHidden"  name="src" value=""/>'+
                                                '<input type="hidden" class="imgHidden" name="originalName" value="">'+
                                                '<input type="hidden" class="imgHidden" name="isfront" value="0">'+
                                                '<form action="" enctype="multipart/form-data">'+
                                                '<div class="imagediv">'+
                                                '<span style="display: none; color: red;" class="closeImg" onclick="closeDelete(this,\''+tdId+'\')">X</span>'+
                                                '<input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,\''+tdId+'\')"/>'+
                                                '<img class="addMaterial"  src="../resources/images/photoadd.png" />'+
                                                '</div>'+
                                                '</form>'+
                                                '</div>' ;
                                        $("#"+tdId).append(td_img);
                                    }
                                }
                            </script>
                            <table class="tb_info" style="font-size:12px;">
                                <tbody>
                                <tr style="height: 200px;">
                                    <td style="background: #DEF0D8;width: 10%;">法人身份证正面</td>
                                    <td colspan="3" style="text-align: left;" id="td_idcard_zhengmian">
                                        <div>
                                            <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                            <input type="hidden" class="imgHidden"  name="src" value=""/>
                                            <input type="hidden" class="imgHidden" name="originalName" value="">
                                            <input type="hidden" class="imgHidden" name="isfront" value="0">
                                            <form action="" enctype="multipart/form-data">
                                                <div class="imagediv">
                                                    <span id="xxxx" style="display: none;" class="closeImg" onclick="closeDelete(this,'td_idcard_zhengmian')">X</span>
                                                    <input type="file" name="pic" class="picShow" onchange="setImagePreview1(this,'td_idcard_zhengmian')"/>
                                                    <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                </div>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="height: 200px;">
                                    <%--身份证反面照片--%>
                                    <td style="background: #DEF0D8;width: 10%">法人身份证反面</td>
                                    <td colspan="3" style="text-align: left" id="td_idcard_fanmian">
                                        <div>
                                            <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                            <input type="hidden" class="imgHidden" name="src" value=""/>
                                            <input type="hidden" class="imgHidden" name="originalName" value="">
                                            <input type="hidden" class="imgHidden" name="isfront" value="0">
                                            <form action="" enctype="multipart/form-data">
                                                <div class="imagediv">
                                                    <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_idcard_fanmian')">X</span>
                                                    <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_idcard_fanmian')"/>
                                                    <img class="addMaterial"   src="../resources/images/photoadd.png" />
                                                </div>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="height: 200px;">
                                    <%--营业执照--%>
                                    <td style="background: #DEF0D8;width: 10%">营业执照</td>
                                    <td colspan="3" style="text-align: left;" id="td_yinyezhizhao">
                                        <div>
                                            <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                            <input type="hidden" class="imgHidden" name="src" value=""/>
                                            <input type="hidden" class="imgHidden" name="originalName" value="">
                                            <input type="hidden" class="imgHidden" name="isfront" value="0">
                                            <form action="" enctype="multipart/form-data">
                                                <div class="imagediv">
                                                    <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_yinyezhizhao')">X</span>
                                                    <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_yinyezhizhao')"/>
                                                    <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                </div>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="height: 200px;">
                                    <td style="background: #DEF0D8;width: 10%">门头logo照</td>
                                    <td colspan="3" style="text-align: left;" id="td_touxiang_logo">
                                        <div>
                                            <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                            <input type="hidden" class="imgHidden" name="src" value=""/>
                                            <input type="hidden" class="imgHidden" name="originalName" value="">
                                            <input type="hidden" class="imgHidden" name="isfront" value="0">
                                            <form action="" enctype="multipart/form-data">
                                                <div class="imagediv">
                                                    <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_touxiang_logo')">X</span>
                                                    <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_touxiang_logo')"/>
                                                    <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                </div>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="height: 200px;">
                                    <td style="background: #DEF0D8;width: 10%">室内照</td>
                                    <td colspan="3" style="text-align: left;" id="td_shinei">
                                        <div>
                                            <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                            <input type="hidden" class="imgHidden" name="src" value=""/>
                                            <input type="hidden" class="imgHidden" name="originalName" value="">
                                            <input type="hidden" class="imgHidden" name="isfront" value="0">
                                            <form action="" enctype="multipart/form-data">
                                                <div class="imagediv">
                                                    <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_shinei')">X</span>
                                                    <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_shinei')"/>
                                                    <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                </div>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="height: 200px;">
                                    <td style="background: #DEF0D8;width: 10%">收银台照</td>
                                    <td colspan="3" style="text-align: left;" id="td_shouyintai">
                                        <div>
                                            <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                            <input type="hidden" class="imgHidden" name="src" value=""/>
                                            <input type="hidden" class="imgHidden" name="originalName" value="">
                                            <input type="hidden" class="imgHidden" name="isfront" value="0">
                                            <form action="" enctype="multipart/form-data">
                                                <div class="imagediv">
                                                    <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_shouyintai')">X</span>
                                                    <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_shouyintai')"/>
                                                    <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                </div>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="height: 200px;">
                                    <td style="background: #DEF0D8;width: 10%">街景照</td>
                                    <td colspan="3" style="text-align: left;" id="td_jiejing">
                                        <div>
                                            <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                            <input type="hidden" class="imgHidden"  name="src" value=""/>
                                            <input type="hidden" class="imgHidden" name="originalName" value="">
                                            <input type="hidden" class="imgHidden" name="isfront" value="0">
                                            <form action="" enctype="multipart/form-data">
                                                <div class="imagediv">
                                                    <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_jiejing')">X</span>
                                                    <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_jiejing')"/>
                                                    <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                </div>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="height: 200px;">
                                    <td style="background: #DEF0D8;width: 10%">法人银行卡</td>
                                    <td colspan="3" style="text-align: left;" id="td_farenyinhangka">
                                        <div>
                                            <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                            <input type="hidden" class="imgHidden"  name="src" value=""/>
                                            <input type="hidden" class="imgHidden" name="originalName" value="">
                                            <input type="hidden" class="imgHidden" name="isfront" value="0">
                                            <form action="" enctype="multipart/form-data">
                                                <div class="imagediv">
                                                    <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_farenyinhangka')">X</span>
                                                    <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_farenyinhangka')"/>
                                                    <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                </div>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="height: 200px;">
                                    <td style="background: #DEF0D8;width: 10%">收款委托书</td>
                                    <td colspan="3" style="text-align: left;" id="td_shoukuanweituoshu">
                                        <div>
                                            <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                            <input type="hidden" class="imgHidden"  name="src" value=""/>
                                            <input type="hidden" class="imgHidden" name="originalName" value="">
                                            <input type="hidden" class="imgHidden" name="isfront" value="0">
                                            <form action="" enctype="multipart/form-data">
                                                <div class="imagediv">
                                                    <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_shoukuanweituoshu')">X</span>
                                                    <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_shoukuanweituoshu')"/>
                                                    <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                </div>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="height: 100px;">
                                    <td style="background: #DEF0D8;">备注说明：</td>
                                    <td colspan="3" style="text-align: left;">
                                        <textarea style=" width:95%; height: 95px;" id="remarksContent"></textarea>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <%--反欺诈影像--%>
                            <div id='imgs_fanqizha' class="paperBlockfree" style="position: relative;margin-top:20px;">
                                <div class="block_hd" style="float:left;" style="float:left;" onclick="shrink(this)">
                                    <s class="ico icon-file-text-alt"></s><span class="bl_tit">反欺诈影像资料</span>
                                </div>
                                <table class="tb_info" style="font-size:12px;">
                                    <tbody>
                                    <tr style="height: 200px;">
                                        <td style="background: #DEF0D8;width: 10%;">法人身份证正面</td>
                                        <td colspan="3" style="text-align: left;" id="td_idcard_zhengmian_fqz">
                                            <div>
                                                <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                                <input type="hidden" class="imgHidden"  name="src" value=""/>
                                                <input type="hidden" class="imgHidden" name="originalName" value="">
                                                <input type="hidden" class="imgHidden" name="isfront" value="0">
                                                <form action="" enctype="multipart/form-data">
                                                    <div class="imagediv">
                                                        <span  style="display: none;" class="closeImg" onclick="closeDelete(this,'td_idcard_zhengmian')">X</span>
                                                        <input type="file" name="pic" class="picShow" onchange="setImagePreview1(this,'td_idcard_zhengmian')"/>
                                                        <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                    </div>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr style="height: 200px;">
                                        <%--身份证反面照片--%>
                                        <td style="background: #DEF0D8;width: 10%">法人身份证反面</td>
                                        <td colspan="3" style="text-align: left" id="td_idcard_fanmian_fqz">
                                            <div>
                                                <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                                <input type="hidden" class="imgHidden" name="src" value=""/>
                                                <input type="hidden" class="imgHidden" name="originalName" value="">
                                                <input type="hidden" class="imgHidden" name="isfront" value="0">
                                                <form action="" enctype="multipart/form-data">
                                                    <div class="imagediv">
                                                        <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_idcard_fanmian')">X</span>
                                                        <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_idcard_fanmian')"/>
                                                        <img class="addMaterial"   src="../resources/images/photoadd.png" />
                                                    </div>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr style="height: 200px;">
                                        <%--营业执照--%>
                                        <td style="background: #DEF0D8;width: 10%">营业执照</td>
                                        <td colspan="3" style="text-align: left;" id="td_yinyezhizhao_fqz">
                                            <div>
                                                <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                                <input type="hidden" class="imgHidden" name="src" value=""/>
                                                <input type="hidden" class="imgHidden" name="originalName" value="">
                                                <input type="hidden" class="imgHidden" name="isfront" value="0">
                                                <form action="" enctype="multipart/form-data">
                                                    <div class="imagediv">
                                                        <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_yinyezhizhao')">X</span>
                                                        <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_yinyezhizhao')"/>
                                                        <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                    </div>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr style="height: 200px;">
                                        <td style="background: #DEF0D8;width: 10%">门头logo照</td>
                                        <td colspan="3" style="text-align: left;" id="td_touxiang_logo_fqz">
                                            <div>
                                                <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                                <input type="hidden" class="imgHidden" name="src" value=""/>
                                                <input type="hidden" class="imgHidden" name="originalName" value="">
                                                <input type="hidden" class="imgHidden" name="isfront" value="0">
                                                <form action="" enctype="multipart/form-data">
                                                    <div class="imagediv">
                                                        <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_touxiang_logo')">X</span>
                                                        <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_touxiang_logo')"/>
                                                        <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                    </div>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr style="height: 200px;">
                                        <td style="background: #DEF0D8;width: 10%">室内照</td>
                                        <td colspan="3" style="text-align: left;" id="td_shinei_fqz">
                                            <div>
                                                <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                                <input type="hidden" class="imgHidden" name="src" value=""/>
                                                <input type="hidden" class="imgHidden" name="originalName" value="">
                                                <input type="hidden" class="imgHidden" name="isfront" value="0">
                                                <form action="" enctype="multipart/form-data">
                                                    <div class="imagediv">
                                                        <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_shinei')">X</span>
                                                        <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_shinei')"/>
                                                        <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                    </div>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr style="height: 200px;">
                                        <td style="background: #DEF0D8;width: 10%">收银台照</td>
                                        <td colspan="3" style="text-align: left;" id="td_shouyintai_fqz">
                                            <div>
                                                <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                                <input type="hidden" class="imgHidden" name="src" value=""/>
                                                <input type="hidden" class="imgHidden" name="originalName" value="">
                                                <input type="hidden" class="imgHidden" name="isfront" value="0">
                                                <form action="" enctype="multipart/form-data">
                                                    <div class="imagediv">
                                                        <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_shouyintai')">X</span>
                                                        <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_shouyintai')"/>
                                                        <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                    </div>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr style="height: 200px;">
                                        <td style="background: #DEF0D8;width: 10%">街景照</td>
                                        <td colspan="3" style="text-align: left;" id="td_jiejing_fqz">
                                            <div>
                                                <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                                <input type="hidden" class="imgHidden"  name="src" value=""/>
                                                <input type="hidden" class="imgHidden" name="originalName" value="">
                                                <input type="hidden" class="imgHidden" name="isfront" value="0">
                                                <form action="" enctype="multipart/form-data">
                                                    <div class="imagediv">
                                                        <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_jiejing')">X</span>
                                                        <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_jiejing')"/>
                                                        <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                    </div>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr style="height: 200px;">
                                        <td style="background: #DEF0D8;width: 10%">法人银行卡</td>
                                        <td colspan="3" style="text-align: left;" id="td_farenyinhangka_fqz">
                                            <div>
                                                <input type="hidden" class="imgHidden" class="imgHidden" name="type" value="1">
                                                <input type="hidden" class="imgHidden"  name="src" value=""/>
                                                <input type="hidden" class="imgHidden" name="originalName" value="">
                                                <input type="hidden" class="imgHidden" name="isfront" value="0">
                                                <form action="" enctype="multipart/form-data">
                                                    <div class="imagediv">
                                                        <span style="display: none;color: red;" class="closeImg" onclick="closeDelete(this,'td_farenyinhangka')">X</span>
                                                        <input type="file"  name="pic" class="picShow" onchange="setImagePreview1(this,'td_farenyinhangka')"/>
                                                        <img class="addMaterial"  src="../resources/images/photoadd.png" />
                                                    </div>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr style="height: 100px;">
                                        <td style="background: #DEF0D8;">反欺诈备注说明：</td>
                                        <td colspan="3" style="text-align: left;">
                                            <span style=" width:95%; height: 95px;" id="remarksContent_fanqizha"></span>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <%--商户审核信息--%>
                            <div  id='merchantCheck_information_div' class="paperBlockfree" style="position: relative;margin-top:20px;">
                                <div class="block_hd" style="float:left;" style="float:left;" onclick="shrink(this)">
                                    <s class="ico icon-file-text-alt"></s><span class="bl_tit">商户审核信息</span>
                                </div>
                                <table class="tb_info" style="font-size:12px;">
                                    <tbody>
                                    <tr style="height: 200px;">
                                        <td style="background: #DEF0D8;width: 10%;">审核信息</td>
                                        <td colspan="3" style="text-align: left;" >
                                            <span style=" width:95%; height: 95px;" id="merchantCheck_information"></span>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--查看商户订单弹出窗--%>
<div id="order_list_div" style="display: none" >
    <div class="Manager_style add_user_info search_style">
        <ul class="search_content clearfix">
            <li style="width:200px;margin-left: 80px;">
                <label class="lf">客户姓名:</label>
                <label style="width: 100px">
                    <input type="text" id="search_customName">
                </label>
            </li>
            <li style="width:200px; margin-left: 60px;">
                <label class="lf">手机号:</label>
                <label style="width: 100px">
                    <input type="text" id="search_custom_tel">
                </label>
            </li>
            <li style="width:200px;margin-left: 50px;">
                <button id="btn_search_order" type="button" class="btn btn-primary queryBtn">查询</button>
                <button id="btn_reset_order" type="button" class="btn btn-primary queryBtn">查询重置</button>
            </li>
        </ul>
    </div>
    <div >
        <table style=" clear:both ;cursor:pointer; font-size: 10px; width: 1000px; margin-top: 10px;" id="order_list_table" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover">
            <thead>
            <tr>
                <th>序号</th>
                <th>订单编号</th>
                <th>姓名</th>
                <th>手机号码</th>
                <th>证件号码</th>
                <th>申请时间</th>
                <th>秒付产品</th>
                <th>状态</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
<%--商品管理弹出窗--%>
<div id="merchantdise_div" style="display: none" >
    <div >
        <table style=" clear:both ;cursor:pointer; font-size: 10px; width: 1000px; margin-top: 10px;" id="merchantdise_list_table" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover">
            <thead>
            <tr>
                <th>序号</th>
                <th>商品</th>
                <th>商品类型</th>
                <th>品牌名称</th>
                <th>具体型号</th>
                <th>具体版本</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<%--商品基本信息--%>
<div class="paperBlockfree" style="margin-top:20px; margin-left:20px;margin-right:20px;display: none" id="goods_div">

    <div class="block_hd" style="float:left;">
        <s class="ico icon-file-text-alt"></s><span class="bl_tit">基本信息</span>
    </div>
    <table class="tb_info " style="font-size:12px; color: #000;">
        <tbody>
            <tr>
                <td  width="131px;">商品名称:</td>
                <td  style="width: 288px;" id="a">
                </td>
            </tr>
            <tr>
                <td class="align">商品类型:</td>
                <td id="b">

                </td>
            </tr>
            <tr>
                <td class="align">品牌名称:</td>
                <td id="c">
                </td>
            </tr>
            <tr>
                <td>具体型号:</td>
                <td id="d">
                </td>
            </tr>
            <tr>
                <td>具体版本:</td>
                <td id="e">
                </td>
            </tr>
        </tbody>
    </table>
        <div class="block_hd" style="float:left;">
            <s class="ico icon-file-text-alt"></s><span class="bl_tit">商品图片</span>
        </div>
        <table class="tb_info " style="font-size:12px; color: #000;">
            <tbody>
                <tr>
                    <td  width="131px;" colspan="2" id="f"></td>
                </tr>
            </tbody>
        </table>
</div>

<%--账户管理弹出窗--%>
<div id="div_merchant_manage" style="display: none;margin-left: 50px;height: 500px;" >
    <div class="addCommon clearfix">
        <div>
            <div id="container_manage" class="of-auto_H" style="padding:20px;">
                <div id="divFrom_manage">
                    <div class="paddingBox xdproadd" style="width:1200px">
                        <div class="paperBlockfree" style="height: 800px;">
                            <%--法人信息--%>
                            <div class="block_hd" style="float:left; margin-top: 30px;">
                                <s class="ico icon-file-text-alt"></s><span class="bl_tit">法人信息</span>
                            </div>
                            <table class="tb_info " style="font-size:12px; color: #000;" id="faren_table_manage">
                                <tbody>
                                <tr>
                                    <td width="131px;">法人姓名:</td>
                                    <td  width="288px;">
                                        <input type="hidden" id="faren_id_hidden" value="">
                                        <input id="add_person_name_manage" type="text" class="text_add" style="width: 250px;" />
                                    </td>
                                    <td>法人电话:</td>
                                    <td>
                                        <input id="add_person_tel_manage" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                    <td>法人身份证号:</td>
                                    <td>
                                        <input id="add_persion_card_manage" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>法人银行卡号:</td><!--***************-->
                                    <td>
                                        <input id="add_persion_bank_account_manage" type="text" class="text_add" style="width: 250px;"/>
                                    </td>

                                    <td>法人银行卡号开户行:</td>
                                    <td colspan="3">
                                        <select name="state" id="faren_province_manage" onchange="citySelAdd(this.options[this.options.selectedIndex].value,$('#faren_city_manage'))"type="text" style="width: 190px;height:30px;font-size: 14px;" >
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">省&nbsp;</span>
                                        <select name="state" id="faren_city_manage"  type="text" style=" width: 190px;height:30px;font-size: 14px;" >
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">市&nbsp;</span>
                                        <input id="add_persion_opening_bank_manage" type="text" class="text_add" style="width: 200px;" placeholder="输入银行名"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:131px;">法人人银行名称:</td>
                                    <td>
                                        <select  style="width: 250px; height: 31px;" id="add_persion_opening_bank_manage_head">
                                            <option value="1">请选择</option>
                                        </select>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <%--收款人委托人信息--%>
                            <div class="block_hd" style="float:left; margin-top: 30px;">
                                <s class="ico icon-file-text-alt"></s><span class="bl_tit">收款委托人信息</span>
                            </div>
                            <table class="tb_info " style="font-size:12px; color: #000;" id="add_money_bailor_table_manage">
                                <tbody>
                                <tr>
                                    <td style="width: 131px;">收款委托人姓名:</td>
                                    <td>
                                        <input type="hidden" id="weituo_id_hidden" value="">
                                        <input id="add_money_bailor_name_manage" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                    <td>收款委托人电话:</td>
                                    <td>
                                        <input id="add_money_bailor_tel_manage" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                    <td>收款委托人身份证号:</td>
                                    <td>
                                        <input id="add_money_bailor_idcard_manage" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>收款委托人银行卡号:</td>
                                    <td>
                                        <input id="add_money_bailor_account_manage" type="text" class="text_add" style="width: 250px;"/>
                                    </td>
                                    <td>收款委托人开户行:</td>
                                    <td colspan="3">
                                        <select name="state" id="weituo_province_manage" onchange="citySelAdd(this.options[this.options.selectedIndex].value,$('#weituo_city_manage'))"type="text" style="width: 190px;height:30px;font-size: 14px;" >
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">省&nbsp;</span>
                                        <select name="state" id="weituo_city_manage"  type="text" style=" width: 190px;height:30px;font-size: 14px;" >
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">市&nbsp;</span>
                                        <input id="add_money_bailor_oppen_bank_manage" type="text" class="text_add" style="width: 200px;"placeholder="输入银行名"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:131px;">收款委托人银行名称:</td>
                                    <td>
                                        <select  style="width: 250px; height: 31px;" id="add_money_bailor_oppen_bank_manage_head">
                                            <option value="">请选择</option>
                                        </select>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <%--对公账号--%>
                            <div class="block_hd" style="float:left; margin-top: 30px;">
                                <s class="ico icon-file-text-alt"></s><span class="bl_tit">对公账号</span>
                            </div>
                            <table class="tb_info " style="font-size:12px; color: #000;"
                                   id="add_public_opening_table_manage">
                                <tbody>
                                <tr>
                                    <td style="width:131px;">对公账号名称:</td>
                                    <td>
                                        <input type="hidden" id="public_id_hidden" value="">
                                        <input id="add_public_account_name_manage" type="text" class="text_add"
                                               style="width: 250px;"/>
                                    </td>
                                    <td>对公账号:</td>
                                    <td>
                                        <input id="add_public_bank_account_manage" type="text" class="text_add"
                                               style="width: 250px;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:131px;">对公开户行:</td>
                                    <td colspan="3">
                                        <select name="state" id="public_province_manage"
                                                onchange="citySelAdd(this.options[this.options.selectedIndex].value,$('#public_city_manage'))"
                                                type="text" style="width: 190px;height:30px;font-size: 14px;margin-left: 10px;">
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">省&nbsp;</span>
                                        <select name="state" id="public_city_manage" type="text"
                                                style=" width: 190px;height:30px;font-size: 14px;">
                                            <option value="">请选择</option>
                                        </select>
                                        <span style="line-height:30px;">市&nbsp;</span>
                                        <input id="add_public_opening_bank_manage" type="text" class="text_add" style="width: 250px;" placeholder="输入银行名"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:131px;">对公账号银行名称:</td>
                                    <td>
                                        <select  style="width: 250px; height: 31px;" id="add_public_opening_bank_manage_head">
                                            <option value="">请选择</option>
                                        </select>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <%--对私账号选择--%>
                            <div class="block_hd" style="float:left; margin-top: 30px; height: 42px;">
                                <s class="ico icon-file-text-alt"></s><span class="bl_tit">对私账号选择</span>
                            </div>
                            <table class="tb_info " style="font-size:12px; color: #000;"
                                   id="add_public_opening_table_manage">
                                <tbody>
                                <td style="width:131px;">选择主账号:</td>
                                <td colspan="3">
                                    <select id="edit_private_account" class="if" style="width:600px;height: 30px; margin-left: 10px;">
                                        <option value="">请选择</option>
                                    </select>
                                </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--绑定办单员弹出窗--%>
<div class="order_list" id="bidingSalesman" style="display: none;">
    <input type="hidden" id="merchant_id_biding_salesman" val="">
    <input type="hidden" id="initFlag">
    <div class="Manager_style add_user_info search_style">
        <ul class="search_content clearfix">
            <li style="width:300px; margin-left: 20px;margin-top: 10px;">
                <label class="lf">办单员名称:</label>
                <label style="width: 100px">
                    <input type="text" id="salesman_name">
                </label>
            </li>
            <li style="width:300px; margin-left: 20px;margin-top: 10px;">
                <label class="lf">手机号:</label>
                <label style="width: 100px">
                    <input type="text" id="salesman_tel">
                </label>
            </li>
            <li style="width:200px;margin-top: 10px;">
                <button id="search_salesmanName" type="button" class="btn btn-primary queryBtn">查询</button>
                <button type="button" class="btn btn-primary queryBtn" id="search_reset_biding_sal">查询重置</button>
            </li>
        </ul>
    </div>
    <table style="cursor:pointer; font-size: 10px; width: 800px; margin-top: 20px;" id="salesman_list" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover">
        <thead>
        <tr >
            <th>选择</th>
            <th>姓名</th>
            <th>手机号</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>

<%--展示该商户绑定的办单员弹出窗--%>
<div class="order_list" id="showMerchantSalesmanList" style="display: none;">
    <input type="hidden" val="" id="merchant_id_biding_salesman_show">
    <input type="hidden" id="initFlag1">
    <div class="Manager_style add_user_info search_style">
        <ul class="search_content clearfix">
            <li style="width:300px; margin-left: 20px;margin-top: 10px;">
                <label class="lf">办单员名称:</label>
                <label style="width: 100px">
                    <input type="text" id="salesman_name_show">
                </label>
            </li>
            <li style="width:300px; margin-left: 20px;margin-top: 10px;">
                <label class="lf">手机号:</label>
                <label style="width: 100px">
                    <input type="text" id="salesman_tel_show">
                </label>
            </li>
            <li style="width:200px;margin-top: 10px;">
                <button id="search_salesmanName_show" type="button" class="btn btn-primary queryBtn">查询</button>
                <button type="button" class="btn btn-primary queryBtn" id="search_sal_show_reset">查询重置</button>
            </li>
        </ul>
    </div>
    <table style="cursor:pointer; font-size: 10px; width: 800px; margin-top: 20px;" id="salesman_list_show" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover">
        <thead>
        <tr >
            <th>序号</th>
            <th>姓名</th>
            <th>手机号</th>
            <th>关联状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>

<%--修改商户分级--%>
<div id="changeMerchantGrade" style="display: none" >
    <div class="addCommon clearfix">
        <div>
            <%--<input  id="contract_id" type="hidden" />--%>
            <ul>
                <li style="margin-left: 30px;margin-bottom: 10px; margin-top: 50px;">
                    <label class="lf">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;商户级别:</label>
                    <label>
                        &nbsp;&nbsp;
                        <select id="merchant_grade" class="if" style="width:150px;height: 28px;">
                            <option value="" style="font-size: 10px;">请选择商户级别</option>
                        </select>
                    </label>
                </li>
            </ul>
        </div>
    </div>
</div>

</body>
</html>

