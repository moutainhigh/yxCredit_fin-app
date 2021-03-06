package com.zw.rule.web.contractorManage.controller;

import com.zw.base.util.DateUtils;
import com.zw.base.util.GeneratePrimaryKeyUtils;
import com.zw.base.util.RegexUtil;
import com.zw.base.util.StringUtils;
import com.zw.enums.WhiteContractStatusEnum;
import com.zw.enums.WhiteJobEnum;
import com.zw.enums.WhitePayTypeEnum;
import com.zw.rule.contractor.po.Contractor;
import com.zw.rule.contractor.po.WhiteList;
import com.zw.rule.contractor.service.ContractorService;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.NumberToTextConverter;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * 白名单导入
 * @author 陈清玉 create by 2018-06-19
 * @since 1.0.0
 */
public class WhiteListImportBusiness {

  private  final String SUF_XLSX = "xlsx";
  private  final String SUF_XLS = "xls";
    /**
     * 模板头
     */
    private  String [] headList ={"所属总包商名称","姓名","身份证","手机号","合同状态","合同开始日期","合同结束日期","职务","工种","发薪日","应发工资","工资发放形式","当地日最低工资" };
    /**
     * 是否有异常
     */
    private boolean isError = false;
    /**
     * 异常总数
     */
    private List<String> errors;

    /**
     * 异常信息
     */
    private String  errorMsg = "";
    /**
     * 数据库存在的身份证列表
     */
    private List<String> cardList;
    /**
     * 总包商列表
     */
    private List<Contractor> contractorList;

    private ContractorService contractorService;
    /**
     * 导入的Excel文件
     */
    private  MultipartFile file;
    /**
     * Excel文件Workbook
     */
    private Workbook workBook;
    /**
     * Excel文件sheet
     */
    private Sheet sheet;

    public WhiteListImportBusiness(MultipartFile file,ContractorService contractorService,List<Contractor> contractorList){
        this.file = file;
        this.contractorService = contractorService;
        this.contractorList = contractorList;
    }

    /**
     * 数据导入入口
     * @return 异常信息 如何没有异常 则是empty List
     * @throws Exception 解析异常
     */
    public List<String>  importData() throws Exception {
        if (file == null) {
            return null;
        }
        //初始化
        init();
       return !isError ? returnErrors() : this.errors;
    }

    /**
     * 初始化赋值workBook
     * @throws IOException 文件读取异常
     */
    private void init() throws IOException {
        //查询出全部白名单身份证号
        cardList = contractorService.findALLCards();
        errors = new ArrayList<>();
        String fileName = file.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
        if(SUF_XLSX.equalsIgnoreCase(suffix)) {
            this.workBook  = new XSSFWorkbook(file.getInputStream());
        } else if (SUF_XLS.equalsIgnoreCase(suffix)) {
            this.workBook  = new HSSFWorkbook(file.getInputStream());
        }else{
            errors.add("非Excel文件，请重新选择");
            isError = true;
        }
        //如果文件是excel
        if(!isError){
            checkTemplate();
        }
    }

    /**
     * 验证模板是否正确
     */
    private void checkTemplate(){
        this.sheet = this.workBook.getSheetAt(0);
        Row row = this.sheet.getRow(0);
        for (int j = 0; j < headList.length; j++) {
            String stringCellValue = row.getCell(j).getStringCellValue();
            if (stringCellValue == null || !headList[j].equals(stringCellValue.trim())){
                isError = true;
                errors.add("模版错误，请重新下载模版");
                break;
            }
        }

    }

    /**
     * 判断是否是空行
     * @param row excel row
     * @return true  空行 false 不是空行
     */
    private boolean isRowEmpty(Row row) {
        for (int c = row.getFirstCellNum(); c < row.getLastCellNum(); c++) {
            Cell cell = row.getCell(c);
            if (cell != null && cell.getCellTypeEnum() != CellType.BLANK){
                return false;
            }
        }
        return true;
    }
    /**
     * 返回出错的信息
     * @return  List<String> 出错的信息集合
      */
    private List<String> returnErrors() throws Exception {
        int rowSize = sheet.getLastRowNum();
        for (int i = 1; i <= rowSize; i++) {
            errorMsg = "第" + i + "行：" ;
            Row row = sheet.getRow(i);
            if(isRowEmpty(row)){
                return errors;
            }
            isError = false;
            white = new WhiteList();
            white.setId(GeneratePrimaryKeyUtils.getUUIDKey());
            white.setWhiteStatus("1");
            for (int j = 0; j < headList.length; j++) {
                isError = checkValue(row,j);
                //如果有一个单元格出现异常就终止
                if(isError) {
                    errors.add(errorMsg);
                    break;
                }
            }
            if(!isError) {
                //保存数据
                contractorService.addWhiteList(white);
                //身份证去重
                this.cardList.add(white.getCard());
            }
        }
        return errors;
    }

    private WhiteList white = null;

    /**
     * 验证每一个单元格的数据
     * @param row 行
     * @param index 索引
     * @return 返回是否有异常 true 有 false 没有
     */
    private boolean checkValue(Row row,int index){
        String value = getStringCellValue(row.getCell(index));
        switch (index){
            //所属总包商名称
            case 0:
                if(StringUtils.isBlank(value)){
                    errorMsg +=  headList[index] + "不能为空";
                    isError  = true;
                }else{
                    if(!CollectionUtils.isEmpty(contractorList)){
                        for (Contractor contractor : this.contractorList) {
                            //如果匹配上总包商就赋值
                            if (value.equals(contractor.getContractorName())) {
                                white.setContractorId(contractor.getId());
                                return false;
                            }
                        }
                    }
                    errorMsg += headList[index] + "为：《"+ value + "》在系统里面不存在，请先完善数据在进行添加";
                    isError  = true;
                }
                break;
            //姓名
            case 1:
                if(StringUtils.isBlank(value)){
                    errorMsg += headList[index] + "不能为空";
                    isError  = true;
                }
                white.setRealName(value);
                break;
            //身份证
            case 2:
                if(StringUtils.isBlank(value)){
                    errorMsg += headList[index] + "不能为空";
                    isError  = true;
                }else if(!RegexUtil.isIdentityCard(value)){
                    errorMsg += headList[index] + "格式不正确";
                    isError  = true;
                }else {
                    //如果用户导入的身份证在我们的库里面存在证明是重复数据
                    if(!CollectionUtils.isEmpty(cardList) && cardList.contains(value)) {
                        errorMsg += headList[index] + "为：《"+ value + "》的数据已经存在不能重复添加";
                        isError  = true;
                    }
                }
                white.setCard(value);
                break;
            //手机号
            case 3:
            if(StringUtils.isNotBlank(value) && !RegexUtil.isnNewMobile(value)){
                    errorMsg += headList[index] + "格式不正确";
                    isError  = true;
                }
                white.setTelphone(value);
                break;
             //合同状态
            case 4:
                if(!StringUtils.isEmpty(value)) {
                    WhiteContractStatusEnum contractStatusEnum = WhiteContractStatusEnum.getByLabel(value);
                    if(contractStatusEnum != null) {
                        value = contractStatusEnum.getCode().toString();
                    }
                }
                white.setContractStatus(value);
                break;
            //合同开始日期
            case 5:
                white.setContractStartDate(value);
                break;
            //合同结束日期
            case 6:
                white.setContractEndDate(value);
                break;
            //职务
            case 7:
                if(!StringUtils.isEmpty(value)) {
                    WhiteJobEnum whiteJobEnum = WhiteJobEnum.getByLabel(value);
                    if(whiteJobEnum != null) {
                        value = whiteJobEnum.getCode().toString();
                    }
                }
                white.setJob(value);
                break;
            //工种
            case 8:
                white.setJobType(value);
                break;
            //发薪日
            case 9:
                white.setLatestPayday(value);
                break;
            //应发工资
            case 10:
                if(StringUtils.isBlank(value)){
                    errorMsg += headList[index] +  "不能为空,";
                    isError  = true;
                }else if(!RegexUtil.isNumber(value)){
                    errorMsg += headList[index] + "必须为数字";
                    isError  = true;
                }
                white.setLatestPay(value);
                break;
            //工资发放形式
            case 11:
                if(!StringUtils.isEmpty(value)) {
                    WhitePayTypeEnum typeEnum = WhitePayTypeEnum.getByLabel(value);
                    if(typeEnum != null) {
                        value = typeEnum.getCode().toString();
                    }
                }
                white.setPayType(value);
                break;
            //当地日最低工资
            case 12:
                white.setLocalMonthlyMinWage(value);
                break;
                default:
        }
        return isError;
    }

    /**
     * 获得单元格字符串
     *
     */
    private String getStringCellValue(Cell cell) {
        if (cell == null) {
            return null;
        }
        String result;
        switch (cell.getCellTypeEnum()) {
            case BOOLEAN:
                result = String.valueOf(cell.getBooleanCellValue());
                break;
            case NUMERIC:
                if (HSSFDateUtil.isCellDateFormatted(cell)) {
                    try {
                        result = DateUtils.formatDate(cell.getDateCellValue(),DateUtils.STYLE_3);
                    }catch (Exception e){
                        result = "";
                    }
                } else {
                    String strCell=NumberToTextConverter.toText(cell.getNumericCellValue());
                    if(!strCell.contains(".")) {
                        DecimalFormat df = new DecimalFormat("#");
                        strCell=df.format(cell.getNumericCellValue());
                    }
                    result =strCell;
                }
                break;
            case STRING:
                if (cell.getRichStringCellValue() == null) {
                    result = null;
                } else {
                    result = cell.getRichStringCellValue().getString();
                }
                break;
            case BLANK:
                result = null;
                break;
            case FORMULA:
                try {
                    result = String.valueOf(cell.getNumericCellValue());
                } catch (Exception e) {
                    result = cell.getRichStringCellValue().getString();
                }
                break;
            default:
                result = "";
        }

        if (result != null) {
            result = result.trim();
        }
        return result;
    }

    /**
     * 清空对象(clear to let GC do its work)
     */
    public  void  clearAll(){
        /*
          数据库存在的身份证列表
         */
        if( this.cardList != null) {
            this.cardList.clear();
        }
        /*
          总包商列表
         */
        if( this.contractorList != null) {
            this.contractorList.clear();
        }
        /*
          Excel文件sheet
         */
        this.sheet = null;
        /*
          Excel文件Workbook
         */
        this.workBook = null;
        /*
          导入的Excel文件
         */
        this.file = null;
    }

}
